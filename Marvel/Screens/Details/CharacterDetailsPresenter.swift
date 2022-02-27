//
//  CharacterDetailsPresenter.swift
//  Marvel
//
//  Created by Carlos Lloret Playan on 04/04/21.
//

import Foundation

final class CharacterDetailsPresenter {
    private unowned let view: CharacterDetailsViewProtocol
    private let interactor: CharacterDetailsInteractorProtocol
    private let wireframe: CharacterDetailsWireframeProtocol
    private let character: MarvelCharacter

    private var items: [MarvelComic] = [] {
        didSet {
            view.reloadData()
        }
    }

    init(
        view: CharacterDetailsViewProtocol,
        interactor: CharacterDetailsInteractorProtocol,
        wireframe: CharacterDetailsWireframeProtocol,
        character: MarvelCharacter)
    {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
        self.character = character
    }

    private func getComics() {
        view.setLoadingVisible(true)

        interactor.getComics(of: character.id) { [unowned self] result in
            view.setLoadingVisible(false)

            switch result {
            case .success(let data):
                items = data
            case .failure:
                wireframe.showError("Unable to obtain the comics".localized)
            }
        }
    }
}

// MARK: - CharacterDetailsPresenterInterface

extension CharacterDetailsPresenter: CharacterDetailsPresenterProtocol {
    func viewDidLoad() {
        view.showData(character: character)
        getComics()
    }

    func title() -> String {
        let detailsOf = "Details of".localized
        return "\(detailsOf) \(character.name)"
    }

    func numberOfSections() -> Int {
        return 1
    }

    func numberOfItems(in section: Int) -> Int {
        return items.count
    }

    func item(at indexPath: IndexPath) -> MarvelComic {
        return items[indexPath.row]
    }
}
