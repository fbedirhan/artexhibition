//
//  ProductListAdapter.swift
//  Exhibition
//
//  Created by Bedirhan Yıldız on 4.08.2023.
//

import Foundation
import UIKit

protocol ProductListDelegate: NSObject {
    func selectItem(item: ArtObject?)
    func loadMore(index: Int)
}

class ProductListAdapter: NSObject,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    var items: [ArtObject]? = nil
    var itemsInSection: Int = 1
    var delegate: ProductListDelegate? = nil
    
    init(itemsInSection: Int, delegate: ProductListDelegate? = nil) {
        self.itemsInSection = itemsInSection
        self.delegate = delegate
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: screenWidth / 2 - 16, height: 180)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductListCell", for: indexPath) as? ProductListCell {
            let index = ((indexPath.section) * itemsInSection) + indexPath.row
            let item = items?[index]
            cell.set(item: item)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = ((indexPath.section) * itemsInSection) + indexPath.row
        let item = items?[index]
        delegate?.selectItem(item: item)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let index = (indexPath.section * itemsInSection) + indexPath.row
        delegate?.loadMore(index: index)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return (items?.count ?? 0) / itemsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ProductListHeader", for: indexPath) as! ProductListHeader
            headerView.set(title: "Section \(indexPath.section + 1)")
            return headerView
        }
        return UICollectionReusableView()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    
}
