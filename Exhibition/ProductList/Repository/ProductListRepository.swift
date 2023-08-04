//
//  ProductListRepository.swift
//  Exhibition
//
//  Created by Bedirhan Yıldız on 2.08.2023.
//

import Foundation

protocol ProductListRepositoryProtocol {
    func getCollection(start: Int, count: Int,
                       success: @escaping Callback<ProductListResponse>,
                       failure: @escaping CallbackError)
}

class ProductListRepository: ProductListRepositoryProtocol {
    
    private var apiManager: APIManager
    
    init(apiManager: APIManager = APIManager()) {
        self.apiManager = apiManager
    }
    
    func getCollection(start: Int, count: Int,
                       success: @escaping Callback<ProductListResponse>,
                       failure: @escaping CallbackError) {
        let params = ["p": start, "ps": count]
        apiManager.request(target: .GetCollection(queryParams: params), success: success, failure: failure)
    }
}
