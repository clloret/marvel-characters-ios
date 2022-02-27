//
//  ServiceTests.swift
//  Marvel
//
//  Created by Carlos Lloret Playan on 04/04/21.
//

import Alamofire
@testable import Marvel
import Mockingbird
import OHHTTPStubs
import XCTest

final class ServiceTests: XCTestCase {
    private let session: Alamofire.Session = {
        let configuration = URLSessionConfiguration.af.default
        HTTPStubs.setEnabled(true, for: configuration)
        return Alamofire.Session(configuration: configuration)
    }()

    private let appSecrets = AppSecrets()
    private var sut: ServiceProtocol!

    override func setUp() {
        super.setUp()

        sut = Service(appSecrets: appSecrets, session: session)
    }

    override func tearDown() {
        sut = nil
        HTTPStubs.removeAllStubs()

        super.tearDown()
    }

    private func setupSuccessStubs() {
        stub(condition: isHost(AppConstants.Url.host) && isPath("/v1/public/characters")) { _ in
            let stubPath = OHPathForFile("Characters.json", type(of: self))
            return fixture(filePath: stubPath!, headers: ["Content-Type": "application/json"])
        }
        stub(condition: isHost(AppConstants.Url.host) && pathStartsWith("/v1/public/characters/1/comics")) { _ in
            let stubPath = OHPathForFile("Comics.json", type(of: self))
            return fixture(filePath: stubPath!, headers: ["Content-Type": "application/json"])
        }
    }

    private func setupStubsFailed() {
        stub(condition: isHost(AppConstants.Url.host)) { _ in
            HTTPStubsResponse(error: ServiceError.requestError)
        }
    }

    func test_getCharacters_shouldReturnCorrectData_whenSuccess() {
        setupSuccessStubs()

        let expectation = XCTestExpectation(description: #function)

        var value: [MarvelCharacter]?
        sut.getCharacters { result in
            if case let .success(response) = result {
                value = response
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)

        XCTAssertNotNil(value)
        XCTAssertEqual(value?.count, 20)
        XCTAssertEqual(value?.first?.name, "Hulk")
    }

    func test_getCharacters_shouldReturnRequestError_whenFailed() {
        setupStubsFailed()

        let expectation = XCTestExpectation(description: #function)

        var resultError: ServiceError?
        sut.getCharacters { result in
            if case let .failure(error) = result {
                resultError = error
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)

        XCTAssertEqual(resultError, ServiceError.requestError)
    }

    func test_getComics_shouldReturnCorrectData_whenSuccess() {
        setupSuccessStubs()

        let expectation = XCTestExpectation(description: #function)

        var value: [MarvelComic]?
        sut.getComics(of: 1) { result in
            if case let .success(response) = result {
                value = response
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)

        XCTAssertNotNil(value)
        XCTAssertEqual(value?.count, 20)
        XCTAssertEqual(value?.first?.title, "Avengers Forever")
    }

    func test_getComics_shouldReturnRequestError_whenFailed() {
        setupStubsFailed()

        let expectation = XCTestExpectation(description: #function)

        var resultError: ServiceError?
        sut.getComics(of: 1) { result in
            if case let .failure(error) = result {
                resultError = error
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)

        XCTAssertEqual(resultError, ServiceError.requestError)
    }
}
