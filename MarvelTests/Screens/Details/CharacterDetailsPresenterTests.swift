//
//  CharacterDetailsPresenterTests.swift
//  Marvel
//
//  Created by Carlos Lloret Playan on 05/04/21.
//

import Alamofire
@testable import Marvel
import Mockingbird
import XCTest

final class CharacterDetailsPresenterTests: XCTestCase {
    private var sut: CharacterDetailsPresenter!
    private var interactor: CharacterDetailsInteractorProtocolMock!
    private var view: CharacterDetailsViewProtocolMock!
    private var wireframe: CharacterDetailsWireframeProtocolMock!

    override func setUp() {
        super.setUp()

        interactor = mock(CharacterDetailsInteractorProtocol.self)
        view = mock(CharacterDetailsViewProtocol.self)
        wireframe = mock(CharacterDetailsWireframeProtocol.self)
    }

    override func tearDown() {
        sut = nil
        interactor = nil
        view = nil
        wireframe = nil

        super.tearDown()
    }

    func test_title_shouldReturnCorrectValue() {
        given(interactor.getComics(of: any(), completion: any())).will { _, completion in
            let result: [MarvelComic] = [TestData.getSampleComic()]
            completion(Result.success(result))
        }

        let sut = CharacterDetailsPresenter(view: view, interactor: interactor, wireframe: wireframe,
                                            character: TestData.getSampleCharacter())

        sut.viewDidLoad()

        XCTAssertEqual(sut.title(), "Details of".localized + " Hulk")
    }

    func test_viewDidLoad_shouldReturnCorrectItems() {
        given(interactor.getComics(of: any(), completion: any())).will { _, completion in
            let result: [MarvelComic] = [TestData.getSampleComic()]
            completion(Result.success(result))
        }

        sut = CharacterDetailsPresenter(view: view, interactor: interactor, wireframe: wireframe,
                                        character: TestData.getSampleCharacter())

        sut.viewDidLoad()

        XCTAssertEqual(sut.numberOfSections(), 1)
        XCTAssertEqual(sut.numberOfItems(in: 0), 1)

        let path = IndexPath(row: 0, section: 0)
        XCTAssertEqual(sut.item(at: path).title, "Sample Comic")
    }

    func test_viewDidLoad_shouldShowError_whenInteractorFails() {
        given(interactor.getComics(of: any(), completion: any())).will { _, completion in
            completion(Result.failure(ServiceError.requestError))
        }

        sut = CharacterDetailsPresenter(view: view, interactor: interactor, wireframe: wireframe,
                                        character: TestData.getSampleCharacter())

        sut.viewDidLoad()

        verify(wireframe.showError("Unable to obtain the comics".localized)).wasCalled()
    }
}
