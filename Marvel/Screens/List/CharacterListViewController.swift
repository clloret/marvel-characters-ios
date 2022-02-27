//
//  CharacterListViewController.swift
//  Marvel
//
//  Created by Carlos Lloret Playan on 04/04/21.
//

import UIKit

final class CharacterListViewController: UIViewController {
    @IBOutlet private(set) var collectionView: UICollectionView!

    var presenter: CharacterListPresenterProtocol!
    var progressHUD: ProgressHUDProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        presenter.viewDidLoad()
    }

    private func setupView() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

// MARK: - CharacterListViewProtocol

extension CharacterListViewController: CharacterListViewProtocol {
    func reloadData() {
        collectionView.reloadData()
    }

    func setLoadingVisible(_ visible: Bool) {
        if visible {
            progressHUD?.show(withStatus: "Loading".localized)
        } else {
            progressHUD?.dismiss()
        }
    }
}

// MARK: - UICollectionViewDataSource

extension CharacterListViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter.numberOfSections()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfItems(in: section)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCell.identifier, for: indexPath) as! CharacterCell
        let item = presenter.item(at: indexPath)
        cell.setup(with: item)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CharacterListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        presenter.didSelectItem(at: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let width = UIScreen.main.bounds.size.width
        let height = width * (212.0 / 375.0)

        return CGSize(width: width, height: height)
    }
}
