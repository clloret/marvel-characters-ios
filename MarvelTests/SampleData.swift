//
//  SampleData.swift
//  Marvel
//
//  Created by Carlos Lloret Playan on 04/04/2021.
//
//

import Foundation
@testable import Marvel

class TestData {
  static func getSampleCharacter() -> MarvelCharacter {
    MarvelCharacter(
      id: 1009351,
      name: "Hulk",
      description: "Caught in a gamma bomb explosion while trying to save the life of a teenager, Dr. Bruce Banner was transformed into the incredibly powerful creature called the Hulk. An all too often misunderstood hero, the angrier the Hulk gets, the stronger the Hulk gets.",
      modified: "2020-07-21T10:35:15-0400",
      thumbnail: MarvelImage(
        path: "http://i.annihil.us/u/prod/marvel/i/mg/5/a0/538615ca33ab0",
        imageExtension: MarvelExtension.jpg
      )
    )
  }
}
