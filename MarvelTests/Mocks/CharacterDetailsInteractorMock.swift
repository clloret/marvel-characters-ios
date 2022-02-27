//
//  CharacterDetailsInteractorMock.swift
//  Marvel
//
//  Created by Carlos Lloret Playan on 05/04/21.
//

import Foundation
@testable import Marvel

final class CharacterDetailsInteractorMock {
    enum CompletionResult {
        case success
        case failure
    }

    private let result: CompletionResult

    init(result: CompletionResult = .success) {
        self.result = result
    }
}

// MARK: - CharacterDetailsInteractorProtocol

extension CharacterDetailsInteractorMock: CharacterDetailsInteractorProtocol {
    func getComics(of characterId: Int, completion: @escaping (Result<[MarvelComic], ServiceError>) -> Void) {
        switch result {
        case .success:
            let result: [MarvelComic] = [TestData.getSampleComic()]
            completion(Result.success(result))
        case .failure:
            completion(Result.failure(ServiceError.requestError))
        }
    }
}
