//
//  CharacterCellTests.swift
//  MarvelTests
//
//  Created by Carlos Lloret Playan on 05/04/21.
//

@testable import Marvel
import XCTest

// TODO: Consider whether it is more convenient to use Mockingbird
final class CharacterListPresenterMock: CharacterListPresenterProtocol {
    func viewDidLoad() {}

    func numberOfSections() -> Int {
        1
    }

    func numberOfItems(in section: Int) -> Int {
        1
    }

    func item(at indexPath: IndexPath) -> MarvelCharacter {
        TestData.getSampleCharacter()
    }

    func didSelectItem(at indexPath: IndexPath) {}
}

final class CharacterCellTests: XCTestCase {
    private var viewController: CharacterListViewController!
    private var sut: CharacterCell!

    override func setUp() {
        super.setUp()

        let sb = UIStoryboard(name: "Main", bundle: nil)
        viewController = sb.instantiateViewController(ofType: CharacterListViewController.self)

        let presenter = CharacterListPresenterMock()
        viewController.presenter = presenter
        viewController.loadViewIfNeeded()

        sut = cellForItem(in: viewController.collectionView, row: 0) as? CharacterCell
    }

    override func tearDown() {
        sut = nil
        viewController = nil
        
        super.tearDown()
    }

    func test_outlets_shouldBeConnected() {
        XCTAssertNotNil(sut.nameLabel, "nameLabel")
        XCTAssertNotNil(sut.thumbnailView, "thumbnailView")
        XCTAssertNotNil(sut.thumbnailWidthConstraint, "thumbnailWidthConstraint")
    }

    func test_setup_shouldSetValues() {
        XCTAssertEqual(sut.nameLabel.text, "Hulk")
        // TODO: Assert the image thumbnail (problem with af.setImage)
        // XCTAssertNotNil(sut.thumbnailView.image, "thumbnailView")
    }

    func test_prepareForReuse_shouldSetImagesToNil() {
        sut.thumbnailView.image = UIImage()

        sut.prepareForReuse()

        XCTAssertNil(sut.thumbnailView.image)
    }
}
