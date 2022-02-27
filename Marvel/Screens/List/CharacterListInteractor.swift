//
//  CharacterListInteractor.swift
//  Marvel
//
//  Created by Carlos Lloret Playan on 04/04/21.
//

import Foundation

final class CharacterListInteractor {
    private let service: ServiceProtocol

    init(service: ServiceProtocol) {
        self.service = service
    }
}

// MARK: - CharacterListInteractorProtocol

extension CharacterListInteractor: CharacterListInteractorProtocol {
    func getCharacters(completion: @escaping (Result<[MarvelCharacter], ServiceError>) -> Void) {
        service.getCharacters(completion: completion)
    }
}
