//
//  CharacterDetailsViewController.swift
//  Marvel
//
//  Created by Carlos Lloret Playan on 04/04/21.
//

import UIKit

final class CharacterDetailsViewController: UIViewController {
    @IBOutlet var thumbnailView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionView: UITextView!
    @IBOutlet var collectionView: UICollectionView!

    var presenter: CharacterDetailsPresenterProtocol!
    var progressHUD: ProgressHUDProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        presenter.viewDidLoad()
        title = presenter.title()
    }

    private func setupView() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

// MARK: - CharacterDetailsViewProtocol

extension CharacterDetailsViewController: CharacterDetailsViewProtocol {
    func showData(character: MarvelCharacter) {
        if let imageUrl = character.thumbnail.imageUrl {
            thumbnailView.af.setImage(withURL: imageUrl)
        }
        nameLabel.text = character.name
        descriptionView.text = character.notEmptyDescription
    }

    func reloadData() {
        collectionView.reloadData()
    }

    func setLoadingVisible(_ visible: Bool) {
        if visible {
            let progressStatus = "Loading".localized
            progressHUD?.show(withStatus: progressStatus)
        } else {
            progressHUD?.dismiss()
        }
    }
}

// MARK: - UICollectionViewDataSource

extension CharacterDetailsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter.numberOfSections()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfItems(in: section)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ComicCell.identifier, for: indexPath) as! ComicCell
        let item = presenter.item(at: indexPath)
        cell.setup(with: item)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CharacterDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: 100, height: 119)
    }
}
