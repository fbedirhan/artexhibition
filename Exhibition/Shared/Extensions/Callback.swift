//
//  Callback.swift
//  Exhibition
//
//  Created by Bedirhan Yıldız on 2.08.2023.
//

import Foundation
import UIKit

public typealias Callback<T> = (_ result: T) -> Void
public typealias CallbackVoid = () -> Void
public typealias CallbackError = (_ result: APIError) -> Void

var screenWidth: CGFloat {
    get {
        return UIScreen.main.bounds.width
    }
}
