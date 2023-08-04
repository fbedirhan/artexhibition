//
//  APIManager.swift
//  Exhibition
//
//  Created by Bedirhan Yıldız on 2.08.2023.
//

import Moya
import Foundation

protocol Networkable {
    var provider: MoyaProvider<Services> { get }
}

class APIManager: Networkable {
    
    var provider = MoyaProvider<Services>(plugins: [NetworkLoggerPlugin()])
    
    func request<T: Decodable>(target: Services, success: @escaping Callback<T>, failure: @escaping CallbackError) {
        provider.request(target) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(T.self, from: response.data)
                    success(results)
                } catch let error {
                    failure(.decodeError(message: error.localizedDescription))
                }
            case let .failure(error):
                failure(.statusMessage(message: error.localizedDescription))
            }
        }
    }
 }
