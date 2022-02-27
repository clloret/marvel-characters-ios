//
//  ServiceProtocol.swift
//  Marvel
//
//  Created by Carlos Lloret Playan on 04/04/21.
//

import Foundation

protocol ServiceProtocol {
    func getCharacters(completion: @escaping (Result<[MarvelCharacter], ServiceError>) -> Void)
    func getComics(of characterId: Int, completion: @escaping (Result<[MarvelComic], ServiceError>) -> Void)
}
