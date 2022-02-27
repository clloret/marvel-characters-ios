//
//  CharacterDetailsViewControllerTests.swift
//  Marvel
//
//  Created by Carlos Lloret Playan on 05/04/21.
//

@testable import Marvel
import Mockingbird
import XCTest

final class CharacterDetailsViewControllerTests: XCTestCase {
    private let character = TestData.getSampleCharacter()
    private var sut: CharacterDetailsViewController!
    private var interactor: CharacterDetailsInteractorProtocol!
    private var presenter: CharacterDetailsPresenterProtocol!
    private var wireframe: CharacterDetailsWireframeProtocolMock!
    private var progressHUD: ProgressHUDProtocolMock!

    override func setUp() {
        super.setUp()

        let sb = UIStoryboard(name: "Main", bundle: nil)
        sut = sb.instantiateViewController(ofType: CharacterDetailsViewController.self)

        wireframe = mock(CharacterDetailsWireframeProtocol.self)
        interactor = CharacterDetailsInteractorMock()
        presenter = CharacterDetailsPresenter(view: sut, interactor: interactor, wireframe: wireframe, character: character)
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
        XCTAssertNotNil(sut.thumbnailView, "thumbnailView")
        XCTAssertNotNil(sut.nameLabel, "nameLabel")
        XCTAssertNotNil(sut.descriptionView, "descriptionView")
        XCTAssertNotNil(sut.collectionView, "collectionView")
    }

    func test_collectionViewDelegates_shouldBeConnected() {
        XCTAssertNotNil(sut.collectionView.dataSource, "dataSource")
        XCTAssertNotNil(sut.collectionView.delegate, "delegate")
    }

    func test_numberOfItems_shouldBe1() {
        XCTAssertEqual(numberOfItems(in: sut.collectionView), 1)
    }

    func test_progressHUDShowAndDismiss_shouldBeCalled() {
        verify(progressHUD.show(withStatus: "Loading".localized)).wasCalled()
        verify(progressHUD.dismiss()).wasCalled()
    }

}
