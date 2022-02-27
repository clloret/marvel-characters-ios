//
//  UtilsAssembly.swift
//  Marvel
//
//  Created by Carlos Lloret Playan on 05/04/21.
//

import Foundation
import Swinject

final class UtilsAssembly: Assembly {
    func assemble(container: Container) {
        container.register(ProgressHUDProtocol.self) { _ in
            ProgressHUD()
        }
        .inObjectScope(.container)

        container.register(AlertUtilsProtocol.self) { _ in
            AlertUtils()
        }
        .inObjectScope(.container)
    }
}
