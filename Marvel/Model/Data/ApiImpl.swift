//
//  ApiImpl.swift
//  Marvel
//
//  Created by Carlos Lloret Playan on 02/04/2021.
//
//

import Alamofire
import CryptoSwift
import Foundation

class Api: ApiInterface {
  func getTimeStamp() -> String {
    return NSDate().timeIntervalSince1970.description
  }

  func calculateHash(ts: String) -> String {
    return (ts + AppConstants.Api.privateKey + AppConstants.Api.publicKey).md5()
  }

  func getComics(of characterId: Int, completion: @escaping (Result<[Comic], ApiError>) -> Void) {
    let ts = getTimeStamp()
    let params: Parameters = [
      "ts": ts,
      "apikey": AppConstants.Api.publicKey,
      "hash": calculateHash(ts: ts),
    ]
    AF.request(AppConstants.Url.characterComicsUrl(characterId), parameters: params)
      .validate(contentType: ["application/json"])
      .validate()
      .responseDecodable(of: MarvelResponse<Comic>.self) { response in
        switch response.result {
        case .success(let data):
          completion(Swift.Result.success(data.data.results))
        case .failure(let error):
          print("Error: \(error)")
          completion(Swift.Result.failure(ApiError.requestError)
          )
        }
      }
  }

  func getCharacters(completion: @escaping (Result<[MarvelCharacter], ApiError>) -> Void) {
    let ts = getTimeStamp()
    let params: Parameters = [
      "ts": ts,
      "apikey": AppConstants.Api.publicKey,
      "hash": calculateHash(ts: ts),
      "orderBy": "-modified",
    ]
    AF.request(AppConstants.Url.charactersUrl, parameters: params)
      .validate(contentType: ["application/json"])
      .validate()
      .responseDecodable(of: MarvelResponse<MarvelCharacter>.self) { response in
        switch response.result {
        case .success(let data):
          completion(Swift.Result.success(data.data.results))
        case .failure(let error):
          print("Error: \(error)")
          completion(Swift.Result.failure(ApiError.requestError)
          )
        }
      }
  }
}
