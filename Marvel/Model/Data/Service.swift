//
//  Service.swift
//  Marvel
//
//  Created by Carlos Lloret Playan on 04/04/21.
//

import Alamofire
import CryptoSwift
import Foundation

final class Service: ServiceProtocol {
    private let appSecrets: AppSecrets
    private let session: Alamofire.Session

    init(appSecrets: AppSecrets, session: Alamofire.Session) {
        self.appSecrets = appSecrets
        self.session = session
    }

    private func getTimeStamp() -> String {
        return NSDate().timeIntervalSince1970.description
    }

    private func calculateHash(ts: String) -> String {
        return (ts + appSecrets.privateKey + appSecrets.publicKey).md5()
    }

    func getCharacters(completion: @escaping (Result<[MarvelCharacter], ServiceError>) -> Void) {
        let ts = getTimeStamp()
        let params: Parameters = [
            "ts": ts,
            "apikey": appSecrets.publicKey,
            "hash": calculateHash(ts: ts),
            "orderBy": "-modified",
            "limit": "100",
        ]
        session.request(AppConstants.Url.charactersUrl, parameters: params)
            .validate(contentType: ["application/json"])
            .validate()
            .responseDecodable(of: MarvelResponse<MarvelCharacter>.self) { response in
                switch response.result {
                case .success(let data):
                    completion(Swift.Result.success(data.data.results))
                case .failure(let error):
                    print("Error: \(error)")
                    completion(Swift.Result.failure(ServiceError.requestError)
                    )
                }
            }
    }

    func getComics(of characterId: Int, completion: @escaping (Result<[MarvelComic], ServiceError>) -> Void) {
        let ts = getTimeStamp()
        let params: Parameters = [
            "ts": ts,
            "apikey": appSecrets.publicKey,
            "hash": calculateHash(ts: ts),
        ]
        session.request(AppConstants.Url.characterComicsUrl(characterId), parameters: params)
            .validate(contentType: ["application/json"])
            .validate()
            .responseDecodable(of: MarvelResponse<MarvelComic>.self) { response in
                switch response.result {
                case .success(let data):
                    completion(Swift.Result.success(data.data.results))
                case .failure(let error):
                    print("Error: \(error)")
                    completion(Swift.Result.failure(ServiceError.requestError)
                    )
                }
            }
    }
}
