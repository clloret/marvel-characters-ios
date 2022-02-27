//
//  DataAssembly.swift
//  Marvel
//
//  Created by Carlos Lloret Playan on 04/04/21.
//

import Alamofire
import Foundation
import Swinject

final class DataAssembly: Assembly {
    func assemble(container: Container) {
        container.register(Alamofire.Session.self) { _ in
            Session.default
        }
        .inObjectScope(.container)

        container.register(AppSecrets.self) { _ in
            AppSecrets()
        }
        .inObjectScope(.container)

        container.register(ServiceProtocol.self) { resolver in
            let appSecrets = resolver.resolve(AppSecrets.self)!
            let session = resolver.resolve(Alamofire.Session.self)!
            return Service(appSecrets: appSecrets, session: session)
        }
        .inObjectScope(.container)
    }
}
