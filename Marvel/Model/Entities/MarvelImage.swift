//
//  MarvelImage.swift
//  Marvel
//
//  Created by Carlos Lloret Playan on 04/04/21.
//

import Foundation

struct MarvelImage: Decodable, Equatable {
    let path: String
    let imageExtension: MarvelExtension

    enum CodingKeys: String, CodingKey {
        case path
        case imageExtension = "extension"
    }
}

enum MarvelExtension: String, Decodable {
    case gif
    case jpg
    case png
}

extension MarvelImage {
    var imageUrl: URL? {
        URL(string: "\(path).\(imageExtension)")
    }

    var landscapeImageUrl: URL? {
        URL(string: "\(path)/landscape_incredible.\(imageExtension)")
    }

    var standardMediumImageUrl: URL? {
        URL(string: "\(path)/standard_medium.\(imageExtension)")
    }
}
