//
//  CharacterDetailsInteractorTests.swift
//  Marvel
//
//  Created by Carlos Lloret Playan on 05/04/21.
//

@testable import Marvel
import Mockingbird
import Swinject
import XCTest

final class CharacterDetailsInteractorTests: XCTestCase {
    private var sut: CharacterDetailsInteractor!
    private var service: ServiceProtocolMock!

    override func setUp() {
        super.setUp()

        service = mock(ServiceProtocol.self)
        sut = CharacterDetailsInteractor(service: service)
    }

    override func tearDown() {
        sut = nil
        service = nil
        
        super.tearDown()
    }

    func test_getCharacters_callApiToGetCharacters() {
        sut.getComics(of: 1) { _ in
        }

        verify(service.getComics(of: 1, completion: any())).wasCalled()
    }
}
