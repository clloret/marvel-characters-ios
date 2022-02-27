//
//  CharacterListViewControllerTests.swift
//  MarvelTests
//
//  Created by Carlos Lloret Playan on 05/04/21.
//

@testable import Marvel
import Mockingbird
import XCTest

final class CharacterListViewControllerTests: XCTestCase {
    private var sut: CharacterListViewController!
    private var interactor: CharacterListInteractorProtocol!
    private var presenter: CharacterListPresenterProtocol!
    private var wireframe: CharacterListWireframeProtocolMock!
    private var progressHUD: ProgressHUDProtocolMock!

    override func setUp() {
        super.setUp()

        let sb = UIStoryboard(name: "Main", bundle: nil)
        sut = sb.instantiateViewController(ofType: CharacterListViewController.self)

        wireframe = mock(CharacterListWireframeProtocol.self)
        interactor = CharacterListInteractorMock()
        presenter = CharacterListPresenter(view: sut, interactor: interactor, wireframe: wireframe)
        sut.presenter = presenter

        progressHUD = mock(ProgressHUDProtocol.self)
        sut.progressHUD = progressHUD

        sut.loadViewIfNeeded()
    }

    override func tearDown() {
        sut = nil
        interactor = nil
        presenter = nil
        wireframe = nil
        progressHUD = nil

        super.tearDown()
    }

    func test_outlets_shouldBeConnected() {
        XCTAssertNotNil(sut.collectionView, "collectionView")
    }

    func test_collectionViewDelegates_shouldBeConnected() {
        XCTAssertNotNil(sut.collectionView.dataSource, "dataSource")
        XCTAssertNotNil(sut.collectionView.delegate, "delegate")
    }

    func test_cellForItemAt_shouldSetCorrectValues_whenFirstRow() throws {
        let cell = try XCTUnwrap(cellForItem(in: sut.collectionView, row: 0) as? CharacterCell)

        XCTAssertEqual(cell.nameLabel?.text, "Hulk")
    }

    func test_progressHUDShowAndDismiss_shouldBeCalled() {
        verify(progressHUD.show(withStatus: "Loading".localized)).wasCalled()
        verify(progressHUD.dismiss()).wasCalled()
    }

    func test_numberOfItems_shouldBe1() {
        XCTAssertEqual(numberOfItems(in: sut.collectionView), 1)
    }

    func test_didSelectItem_shouldNavigateToCharacterDetails() {
        didSelectItem(in: sut.collectionView, item: 0)
        verify(wireframe.navigate(to: .characterDetails(TestData.getSampleCharacter()))).wasCalled()
    }
}
