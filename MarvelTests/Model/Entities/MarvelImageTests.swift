//
//  MarvelImageTests.swift
//  MarvelTests
//
//  Created by Carlos Lloret Playan on 05/04/21.
//

@testable import Marvel
import XCTest

final class MarvelImageTests: XCTestCase {
    func test_imageUrl_shouldReturnCorrectUrl() {
        let sut = MarvelImage(path: "http://i.annihil.us/u/prod/marvel/i/mg/5/a0/538615ca33ab0", imageExtension: .jpg)

        XCTAssertEqual(sut.imageUrl?.absoluteString, "http://i.annihil.us/u/prod/marvel/i/mg/5/a0/538615ca33ab0.jpg")
    }

    func test_landscapeImageUrl_shouldReturnCorrectUrl() {
        let sut = MarvelImage(path: "http://i.annihil.us/u/prod/marvel/i/mg/5/a0/538615ca33ab0", imageExtension: .jpg)

        XCTAssertEqual(sut.landscapeImageUrl?.absoluteString, "http://i.annihil.us/u/prod/marvel/i/mg/5/a0/538615ca33ab0/landscape_incredible.jpg")
    }

    func test_standardMediumImageUrl_shouldReturnCorrectUrl() {
        let sut = MarvelImage(path: "http://i.annihil.us/u/prod/marvel/i/mg/5/a0/538615ca33ab0", imageExtension: .jpg)

        XCTAssertEqual(sut.standardMediumImageUrl?.absoluteString, "http://i.annihil.us/u/prod/marvel/i/mg/5/a0/538615ca33ab0/standard_medium.jpg")
    }
}
