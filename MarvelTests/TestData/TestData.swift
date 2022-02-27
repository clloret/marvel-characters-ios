//
//  TestData.swift
//  Marvel
//
//  Created by Carlos Lloret Playan on 04/04/21.
//

import Foundation
@testable import Marvel

final class TestData {
    static func getSampleCharacter() -> MarvelCharacter {
        MarvelCharacter(
            id: 1009351,
            name: "Hulk",
            description: "Caught in a gamma bomb explosion while trying to save the life of a teenager, Dr. Bruce Banner was transformed into the incredibly powerful creature called the Hulk. An all too often misunderstood hero, the angrier the Hulk gets, the stronger the Hulk gets.",
            thumbnail: MarvelImage(
                path: "http://i.annihil.us/u/prod/marvel/i/mg/9/90/4ce5a862a6c48",
                imageExtension: MarvelExtension.jpg
            )
        )
    }

    static func getSampleComic() -> MarvelComic {
        MarvelComic(
            id: 1,
            title: "Sample Comic",
            thumbnail: MarvelImage(
                path: "http://i.annihil.us/u/prod/marvel/i/mg/9/90/4ce5a862a6c48",
                imageExtension: MarvelExtension.jpg
            )
        )
    }
}
