//
//  AppConstantsTests.swift
//  Marvel
//
//  Created by Carlos Lloret Playan on 05/04/21.
//

@testable import Marvel
import XCTest

final class AppConstantsTests: XCTestCase {
    func test_characterComicsUrlShouldReturnCurrectValue() {
        let result = AppConstants.Url.characterComicsUrl(999)

        XCTAssertEqual(result.absoluteString, "https://gateway.marvel.com/v1/public/characters/999/comics")
    }
}
