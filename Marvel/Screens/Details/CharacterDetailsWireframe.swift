//
//  CharacterDetailsWireframe.swift
//  Marvel
//
//  Created by Carlos Lloret Playan on 04/04/21.
//

import UIKit

final class CharacterDetailsWireframe: BaseWireframe {
    private let resolver: AppResolver
    private let storyboard = UIStoryboard(name: "Main", bundle: nil)

    init(resolver: AppResolver, character: MarvelCharacter) {
        self.resolver = resolver

        let moduleViewController = storyboard.instantiateViewController(ofType: CharacterDetailsViewController.self)
        moduleViewController.progressHUD = resolver.resolve(ProgressHUDProtocol.self)
        super.init(resolver: resolver, viewController: moduleViewController)

        let presenter = resolver.resolve(CharacterDetailsPresenterProtocol.self, arguments: moduleViewController as CharacterDetailsViewProtocol, self as CharacterDetailsWireframeProtocol, character)
        moduleViewController.presenter = presenter
    }
}

// MARK: - CharacterDetailsWireframeProtocol

extension CharacterDetailsWireframe: CharacterDetailsWireframeProtocol {}
