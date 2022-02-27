//
//  CharacterListAssembly.swift
//  Marvel
//
//  Created by Carlos Lloret Playan on 04/04/21.
//

import Foundation
import Swinject

final class CharacterListAssembly: Assembly {
    func assemble(container: Container) {
        container.register(CharacterListInteractorProtocol.self) { resolver in
            let service = resolver.resolve(ServiceProtocol.self)!
            return CharacterListInteractor(service: service)
        }

        container.register(CharacterListPresenterProtocol.self) {
            (resolver, view: CharacterListViewProtocol, wireframe: CharacterListWireframeProtocol) in
                let interactor = resolver.resolve(CharacterListInteractorProtocol.self)!
                return CharacterListPresenter(view: view, interactor: interactor, wireframe: wireframe)
        }

        container.register(CharacterListWireframeProtocol.self) { resolver in
            CharacterListWireframe(resolver: AppResolverWrapper(resolver: resolver))
        }
    }
}
