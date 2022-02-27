//
//  CharacterListPresenterTests.swift
//  MarvelTests
//
//  Created by Carlos Lloret Playan on 04/04/21.
//

import Alamofire
@testable import Marvel
import Mockingbird
import XCTest

final class CharacterListPresenterTests: XCTestCase {
    private var interactor: CharacterListInteractorMock!
    private var view: CharacterListViewProtocolMock!
    private var wireframe: CharacterListWireframeProtocolMock!
    private var sut: CharacterListPresenter!

    override func setUp() {
        super.setUp()

        view = mock(CharacterListViewProtocol.self)
        wireframe = mock(CharacterListWireframeProtocol.self)
    }

    override func tearDown() {
        interactor = nil
        view = nil
        wireframe = nil
        sut = nil
        
        super.tearDown()
    }

    func test_viewDidLoad_shouldReturnItems() {
        interactor = CharacterListInteractorMock()

        sut = CharacterListPresenter(view: view, interactor: interactor, wireframe: wireframe)

        sut.viewDidLoad()

        XCTAssertEqual(sut.numberOfSections(), 1)
        XCTAssertEqual(sut.numberOfItems(in: 0), 1)

        let path = IndexPath(row: 0, section: 0)
        XCTAssertEqual(sut.item(at: path).name, "Hulk")
    }

    func test_presenter_shouldShowDetails_whenCharacterIsSelected() {
        interactor = CharacterListInteractorMock()

        let sut = CharacterListPresenter(view: view, interactor: interactor, wireframe: wireframe)

        sut.viewDidLoad()

        let path = IndexPath(row: 0, section: 0)
        sut.didSelectItem(at: path)

        let character = TestData.getSampleCharacter()
        verify(wireframe.navigate(to: .characterDetails(character))).wasCalled()
    }

    func test_presenter_shouldShowError_whenInteractorFails() {
        interactor = CharacterListInteractorMock(result: .failure)

        let sut = CharacterListPresenter(view: view, interactor: interactor, wireframe: wireframe)

        sut.viewDidLoad()

        verify(wireframe.showError("Unable to obtain characters".localized)).wasCalled()
    }

    func test_viewDidLoad_shouldShowAndHideLoading() {
        interactor = CharacterListInteractorMock()

        let sut = CharacterListPresenter(view: view, interactor: interactor, wireframe: wireframe)

        sut.viewDidLoad()

        verify(view.setLoadingVisible(true)).wasCalled()
        verify(view.setLoadingVisible(false)).wasCalled()
    }

    func test_viewDidLoad_shouldReloadData_whenDataAreReceived() {
        interactor = CharacterListInteractorMock()

        let sut = CharacterListPresenter(view: view, interactor: interactor, wireframe: wireframe)

        sut.viewDidLoad()

        verify(view.reloadData()).wasCalled()
    }
}
