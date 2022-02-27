//
//  MarvelCharacterTests.swift
//  Marvel
//
//  Created by Carlos Lloret Playan on 05/04/21.
//

@testable import Marvel
import XCTest

final class MarvelCharacterTests: XCTestCase {
    func test_notEmptyDescription_shouldReturnCorrectValue_whenDescriptionIsEmpty() {
        let image = TestData.getSampleCharacter().thumbnail
        let sut = MarvelCharacter(id: 0, name: "Name", description: "", thumbnail: image)
        
        XCTAssertEqual(sut.notEmptyDescription, "No description available".localized)
    }

    func test_notEmptyDescription_shouldReturnCorrectValue_whenDescriptionIsNotEmpty() {
        let sut = TestData.getSampleCharacter()

        XCTAssertEqual(sut.notEmptyDescription, sut.description)
    }
}
