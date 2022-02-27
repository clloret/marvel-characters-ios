//
//  ComicCellTests.swift
//  Marvel
//
//  Created by Carlos Lloret Playan on 05/04/21.
//

@testable import Marvel
import XCTest

final class CharacterDetailsPresenterMock: CharacterDetailsPresenterProtocol {
    func viewDidLoad() {}

    func title() -> String {
        "Sample Title"
    }

    func numberOfSections() -> Int {
        1
    }

    func numberOfItems(in section: Int) -> Int {
        1
    }

    func item(at indexPath: IndexPath) -> MarvelComic {
        TestData.getSampleComic()
    }
}

final class ComicCellTests: XCTestCase {
    private var viewController: CharacterDetailsViewController!
    private var sut: ComicCell!

    override func setUp() {
        super.setUp()

        let sb = UIStoryboard(name: "Main", bundle: nil)
        viewController = sb.instantiateViewController(ofType: CharacterDetailsViewController.self)

        let presenter = CharacterDetailsPresenterMock()
        viewController.presenter = presenter
        viewController.loadViewIfNeeded()

        sut = cellForItem(in: viewController.collectionView, row: 0) as? ComicCell
    }

    override func tearDown() {
        sut = nil
        viewController = nil
        
        super.tearDown()
    }

    func test_outlets_shouldBeConnected() {
        XCTAssertNotNil(sut.titleLabel, "titleLabel")
        XCTAssertNotNil(sut.thumbnailView, "thumbnailView")
    }

    func test_setup_shouldSetValues() {
        XCTAssertEqual(sut.titleLabel.text, "Sample Comic")
        // TODO: Assert the image thumbnail (problem with af.setImage)
        // XCTAssertNotNil(sut.thumbnailView.image, "thumbnailView")
    }

    func test_prepareForReuse_shouldSetImagesToNil() {
        sut.thumbnailView.image = UIImage()

        sut.prepareForReuse()

        XCTAssertNil(sut.thumbnailView.image)
    }
}
