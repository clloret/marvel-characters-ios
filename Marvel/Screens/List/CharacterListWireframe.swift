//
//  CharacterListWireframe.swift
//  Marvel
//
//  Created by Carlos Lloret Playan on 04/04/21.
//

import UIKit

final class CharacterListWireframe: BaseWireframe {
    private let resolver: AppResolver
    private let storyboard = UIStoryboard(name: "Main", bundle: nil)

    init(resolver: AppResolver) {
        self.resolver = resolver

        let moduleViewController = storyboard.instantiateViewController(ofType: CharacterListViewController.self)
        moduleViewController.progressHUD = resolver.resolve(ProgressHUDProtocol.self)
        super.init(resolver: resolver, viewController: moduleViewController)

        let presenter = resolver.resolve(
            CharacterListPresenterProtocol.self,
            arguments: moduleViewController as CharacterListViewProtocol, self as CharacterListWireframeProtocol
        )
        moduleViewController.presenter = presenter
    }
}

// MARK: - CharacterListWireframeProtocol

extension CharacterListWireframe: CharacterListWireframeProtocol {
    func navigate(to option: CharacterListNavigationOption) {
        switch option {
        case .characterDetails(let character):
            showCharacterDetails(character: character)
        }
    }

    private func showCharacterDetails(character: MarvelCharacter) {
        guard let wireframe = resolver.resolve(CharacterDetailsWireframeProtocol.self, argument: character)
            as? BaseWireframe
        else {
            return
        }
        navigationController?.pushWireframe(wireframe, animated: true)
    }
}
