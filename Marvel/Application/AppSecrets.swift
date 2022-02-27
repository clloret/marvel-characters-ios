//
//  AppSecrets.swift
//  Marvel
//
//  Created by Carlos Lloret Playan on 05/04/21.
//

import Foundation

final class AppSecrets {
    private(set) var privateKey: String = ""
    private(set) var publicKey: String = ""

    init() {
        loadValuesFromPlist()
    }

    private func loadValuesFromPlist() {
        var config: [String: Any]?

        if let infoPlistPath = Bundle.main.url(forResource: "Secrets", withExtension: "plist") {
            do {
                let infoPlistData = try Data(contentsOf: infoPlistPath)
                if let dict = try PropertyListSerialization.propertyList(
                    from: infoPlistData,
                    options: [],
                    format: nil) as? [String: Any]
                {
                    config = dict
                }
            } catch {
                print(error)
            }
        }

        privateKey = config?["privateKey"] as? String ?? ""
        publicKey = config?["publicKey"] as? String ?? ""
    }
}
