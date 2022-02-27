//
//  CharacterDetailsContract.swift
//  Marvel
//
//  Created by Carlos Lloret Playan on 04/04/21.
//

import UIKit

protocol CharacterDetailsWireframeProtocol: WireframeProtocol {}

protocol CharacterDetailsViewProtocol: ViewProtocol {
    func showData(character: MarvelCharacter)
    func reloadData()
    func setLoadingVisible(_ visible: Bool)
}

protocol CharacterDetailsPresenterProtocol: PresenterProtocol {
    func viewDidLoad()

    func title() -> String
    func numberOfSections() -> Int
    func numberOfItems(in section: Int) -> Int
    func item(at indexPath: IndexPath) -> MarvelComic
}

protocol CharacterDetailsInteractorProtocol: InteractorProtocol {
    func getComics(of characterId: Int, completion: @escaping (Result<[MarvelComic], ServiceError>) -> Void)
}
