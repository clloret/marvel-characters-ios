//
//  TestHelpers.swift
//  MarvelTests
//
//  Created by Carlos Lloret Playan on 05/04/21.
//

import UIKit

func cellForItem(in collectionView: UICollectionView, row: Int, section: Int = 0) -> UICollectionViewCell? {
    collectionView.dataSource?.collectionView(
        collectionView, cellForItemAt: IndexPath(row: row, section: section)
    )
}

func numberOfItems(in collectionView: UICollectionView, section: Int = 0) -> Int? {
    collectionView.dataSource?.collectionView(collectionView, numberOfItemsInSection: section)
}

func didSelectItem(in collectionView: UICollectionView, item: Int, section: Int = 0) {
    collectionView.delegate?.collectionView?(collectionView, didSelectItemAt: IndexPath(item: item, section: section))
}
