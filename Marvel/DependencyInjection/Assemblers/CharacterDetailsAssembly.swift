//
//  CharacterDetailsAssembly.swift
//  Marvel
//
//  Created by Carlos Lloret Playan on 04/04/21.
//

import Foundation
import Swinject

final class CharacterDetailsAssembly: Assembly {
    func assemble(container: Container) {
        container.register(CharacterDetailsInteractorProtocol.self) { resolver in
            let service = resolver.resolve(ServiceProtocol.self)!
            return CharacterDetailsInteractor(service: service)
        }

        container.register(CharacterDetailsPresenterProtocol.self) { (resolver,
                                                                      view: CharacterDetailsViewProtocol,
                                                                      wireframe: CharacterDetailsWireframeProtocol,
                                                                      character: MarvelCharacter) in
                let interactor = resolver.resolve(CharacterDetailsInteractorProtocol.self)!
                return CharacterDetailsPresenter(view: view, interactor: interactor, wireframe: wireframe,
                                                 character: character)
        }

        container.register(CharacterDetailsWireframeProtocol.self) { (resolver, character: MarvelCharacter) in
            CharacterDetailsWireframe(resolver: AppResolverWrapper(resolver: resolver), character: character)
        }
    }
}
