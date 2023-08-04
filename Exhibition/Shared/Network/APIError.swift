//
//  APIError.swift
//  Exhibition
//
//  Created by Bedirhan Yıldız on 2.08.2023.
//

import Foundation

public enum APIError : Error {
    case general
    case timeout
    case noData
    case noNetwork
    case statusMessage(message : String)
    case decodeError(message : String)
}
