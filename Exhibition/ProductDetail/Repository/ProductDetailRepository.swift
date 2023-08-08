//
//  ProductDetailRepository.swift
//  Exhibition
//
//  Created by Bedirhan Yıldız on 2.08.2023.
//

import Foundation

protocol ProductDetailRepositoryProtocol {
    func getCollectionDetail(id: String,
                             success: @escaping Callback<ProductDetailResponse>,
                             failure: @escaping CallbackError)
}

class ProductDetailRepository: ProductDetailRepositoryProtocol {
    
    private var apiManager: Networkable
    
    init(apiManager: Networkable) {
        self.apiManager = apiManager
    }
    
    func getCollectionDetail(id: String,
                       success: @escaping Callback<ProductDetailResponse>,
                       failure: @escaping CallbackError) {
        apiManager.request(target: .GetCollectionDetail(id: id), success: success, failure: failure)
    }
}
