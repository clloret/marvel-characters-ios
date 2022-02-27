//
//  CharacterListInteractorMock.swift
//  Marvel
//
//  Created by Carlos Lloret Playan on 04/04/21.
//

import Foundation
@testable import Marvel

final class CharacterListInteractorMock {
    enum CompletionResult {
        case success
        case failure
    }

    private let result: CompletionResult

    init(result: CompletionResult = .success) {
        self.result = result
    }
}

// MARK: - CharacterListInteractorProtocol

extension CharacterListInteractorMock: CharacterListInteractorProtocol {
    func getCharacters(completion: @escaping (Result<[MarvelCharacter], ServiceError>) -> Void) {
        switch result {
        case .success:
            let result: [MarvelCharacter] = [TestData.getSampleCharacter()]
            completion(Result.success(result))
        case .failure:
            completion(Result.failure(ServiceError.requestError))
        }
    }
}
