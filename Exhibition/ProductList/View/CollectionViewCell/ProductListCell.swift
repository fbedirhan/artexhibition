//
//  ProductListCell.swift
//  Exhibition
//
//  Created by Bedirhan Yıldız on 1.08.2023.
//

import Foundation
import UIKit

class ProductListCell: UICollectionViewCell {
    
    /// product list cell UI proporites
    let artObjetTitleLabel = UILabel()
    let artObjectImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        
        /// art object image view
        artObjectImageView.translatesAutoresizingMaskIntoConstraints = false
        artObjectImageView.backgroundColor = UIColor.appColor(.CCCCCC)
        artObjectImageView.contentMode = .scaleAspectFit
        contentView.addSubview(artObjectImageView)

        /// art object title Label
        artObjetTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        artObjetTitleLabel.font = UIFont.systemFont(ofSize: 14)
        artObjetTitleLabel.numberOfLines = 0
        contentView.addSubview(artObjetTitleLabel)

        /// product list cell constraints
        NSLayoutConstraint.activate([
            artObjectImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            artObjectImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            artObjectImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            artObjectImageView.heightAnchor.constraint(equalToConstant: 100),

            artObjetTitleLabel.topAnchor.constraint(equalTo: artObjectImageView.bottomAnchor, constant: 4),
            artObjetTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            artObjetTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            artObjetTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    /// Function to configure the cell with product data
    func set(item: ArtObject?) {
        if let url = item?.headerImage?.url {
            artObjectImageView.load(url: url)
        }
        artObjetTitleLabel.text = item?.title
    }
}

