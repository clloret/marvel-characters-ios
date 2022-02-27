//
//  MarvelComic.swift
//  Marvel
//
//  Created by Carlos Lloret Playan on 04/04/21.
//

import Foundation

struct MarvelComic: Decodable {
    let id: Int
    let title: String
    let thumbnail: MarvelImage
}
