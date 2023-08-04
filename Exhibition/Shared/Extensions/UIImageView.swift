//
//  UIImageView.swift
//  Exhibition
//
//  Created by Bedirhan Yıldız on 2.08.2023.
//

import Foundation
import UIKit
import SDWebImage

extension UIImageView {
    
    func load(url: String, placeholder: UIImage? = nil, callback: CallbackVoid? = nil) {
        sd_setImage(with: URL(string: url), placeholderImage: placeholder) { img, error, _, url in
            callback?()
        }
    }
    
    @IBInspectable var tint: UIColor? {
        get {
            return .white
        }
        set {
            if let color = newValue {
                self.image = self.image?.sd_tintedImage(with: color)
            }
        }
    }
}
