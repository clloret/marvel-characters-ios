//
//  MarvelData.swift
//  Marvel
//
//  Created by Carlos Lloret Playan on 04/04/21.
//

import Foundation

struct MarvelData<T: Decodable>: Decodable {
    let offset, limit, total, count: Int
    let results: [T]
}
