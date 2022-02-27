//
//  AppConstants.swift
//  Marvel
//
//  Created by Carlos Lloret Playan on 04/04/21.
//

import Alamofire
import Foundation

struct AppConstants {
    enum Url {
        static let scheme = "https"
        static let host = "gateway.marvel.com"
        static let version = "/v1"
        static let characters = "/public/characters"
        static let characterComics = "/comics"

        static var baseUrl: URL {
            var components = URLComponents()
            components.scheme = scheme
            components.host = host
            components.path = version
            return components.url!
        }

        static var charactersUrl: URL {
            return baseUrl.appendingPathComponent(characters)
        }

        static func characterComicsUrl(_ characterId: Int) -> URL {
            return charactersUrl
                .appendingPathComponent(String(characterId))
                .appendingPathComponent(characterComics)
        }
    }
}
