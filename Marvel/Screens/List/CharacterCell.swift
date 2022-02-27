//
//  CharacterCell.swift
//  Marvel
//
//  Created by Carlos Lloret Playan on 04/04/21.
//

import AlamofireImage
import UIKit

final class CharacterCell: UICollectionViewCell {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var thumbnailView: UIImageView!
    @IBOutlet var thumbnailWidthConstraint: NSLayoutConstraint!

    static var identifier: String {
        String(describing: self)
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        thumbnailView.image = nil
    }

    func setup(with data: MarvelCharacter) {
        nameLabel.text = data.name
        showThumbnail(data)
    }

    private func showThumbnail(_ data: MarvelCharacter) {
        guard let imageUrl = data.thumbnail.landscapeImageUrl else {
            return
        }
        setupImageSize()

        thumbnailView.af.setImage(withURL: imageUrl)
    }

    private func setupImageSize() {
        let width = UIScreen.main.bounds.size.width
        thumbnailWidthConstraint.constant = width
        layoutIfNeeded()
    }
}
