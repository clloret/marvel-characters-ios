//
//  ComicCell.swift
//  Marvel
//
//  Created by Carlos Lloret Playan on 04/04/21.
//

import AlamofireImage
import UIKit

final class ComicCell: UICollectionViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var thumbnailView: UIImageView!

    static var identifier: String {
        String(describing: self)
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        thumbnailView.image = nil
    }

    func setup(with data: MarvelComic) {
        titleLabel.text = data.title
        showThumbnail(data)
    }

    private func showThumbnail(_ data: MarvelComic) {
        guard let imageUrl = data.thumbnail.standardMediumImageUrl else {
            return
        }

        thumbnailView.af.setImage(withURL: imageUrl)
    }
}
