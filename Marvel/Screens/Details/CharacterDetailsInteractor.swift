//
//  CharacterDetailsInteractor.swift
//  Marvel
//
//  Created by Carlos Lloret Playan on 04/04/21.
//

import Foundation

final class CharacterDetailsInteractor {
    private let service: ServiceProtocol

    init(service: ServiceProtocol) {
        self.service = service
    }
}

// MARK: - CharacterDetailsInteractor

extension CharacterDetailsInteractor: CharacterDetailsInteractorProtocol {
    func getComics(of characterId: Int, completion: @escaping (Result<[MarvelComic], ServiceError>) -> Void) {
        service.getComics(of: characterId, completion: completion)
    }
}
