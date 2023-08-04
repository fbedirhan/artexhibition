//
//  UIColor.swift
//  Exhibition
//
//  Created by Bedirhan Yıldız on 4.08.2023.
//

import Foundation
import UIKit

enum AssetsColor: String {
    case F5F5F5
    case E5E5E5
    case CCCCCC
}

extension UIColor {
    static func appColor(_ name: AssetsColor) -> UIColor? {
         return UIColor(named: name.rawValue)
    }
}
