//
//  BaseViewModel.swift
//  Exhibition
//
//  Created by Bedirhan Yıldız on 3.08.2023.
//

import Foundation
import UIKit

class BaseViewModel: ObservableObject {
    @Published var error: APIError?
    @Published var progress: Bool?
}
