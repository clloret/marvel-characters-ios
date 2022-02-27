//
//  MarvelCharacter.swift
//  Marvel
//
//  Created by Carlos Lloret Playan on 04/04/21.
//

import Foundation

struct MarvelCharacter: Decodable, Equatable {
    let id: Int
    let name, description: String
    let thumbnail: MarvelImage
}

extension MarvelCharacter {
    var notEmptyDescription: String {
        description.isEmpty ? "No description available".localized : description
    }
}
