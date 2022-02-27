//
//  CharacterListPresenter.swift
//  Marvel
//
//  Created by Carlos Lloret Playan on 04/04/21.
//

import Foundation

final class CharacterListPresenter {
    private unowned let view: CharacterListViewProtocol
    private let interactor: CharacterListInteractorProtocol
    private let wireframe: CharacterListWireframeProtocol

    private var items: [MarvelCharacter] = [] {
        didSet {
            view.reloadData()
        }
    }

    init(
        view: CharacterListViewProtocol,
        interactor: CharacterListInteractorProtocol,
        wireframe: CharacterListWireframeProtocol)
    {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }

    private func getCharacters() {
        view.setLoadingVisible(true)

        interactor.getCharacters { [unowned self] result in
            view.setLoadingVisible(false)

            switch result {
            case .success(let data):
                items = data
            case .failure:
                wireframe.showError("Unable to obtain characters".localized)
            }
        }
    }
}

// MARK: - CharacterListPresenterProtocol

extension CharacterListPresenter: CharacterListPresenterProtocol {
    func viewDidLoad() {
        getCharacters()
    }

    func numberOfSections() -> Int {
        return 1
    }

    func numberOfItems(in section: Int) -> Int {
        return items.count
    }

    func item(at indexPath: IndexPath) -> MarvelCharacter {
        return items[indexPath.row]
    }

    func didSelectItem(at indexPath: IndexPath) {
        let character = items[indexPath.row]
        wireframe.navigate(to: .characterDetails(character))
    }
}
