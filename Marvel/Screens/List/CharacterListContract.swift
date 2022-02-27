//
//  CharacterListContract.swift
//  Marvel
//
//  Created by Carlos Lloret Playan on 04/04/21.
//

import UIKit

enum CharacterListNavigationOption: Equatable {
    case characterDetails(MarvelCharacter)
}

protocol CharacterListWireframeProtocol: WireframeProtocol {
    func navigate(to option: CharacterListNavigationOption)
}

protocol CharacterListViewProtocol: ViewProtocol {
    func reloadData()
    func setLoadingVisible(_ visible: Bool)
}

protocol CharacterListPresenterProtocol: PresenterProtocol {
    func viewDidLoad()

    func numberOfSections() -> Int
    func numberOfItems(in section: Int) -> Int
    func item(at indexPath: IndexPath) -> MarvelCharacter
    func didSelectItem(at indexPath: IndexPath)
}

protocol CharacterListInteractorProtocol: InteractorProtocol {
    func getCharacters(completion: @escaping (Result<[MarvelCharacter], ServiceError>) -> Void)
}
