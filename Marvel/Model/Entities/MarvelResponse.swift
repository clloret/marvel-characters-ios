//
//  MarvelResponse.swift
//  Marvel
//
//  Created by Carlos Lloret Playan on 04/04/21.
//

import Foundation

struct MarvelResponse<T: Decodable>: Decodable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String
    let etag: String
    let data: MarvelData<T>
}
