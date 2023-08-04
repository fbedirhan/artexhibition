//
//  ProductDetailViewModel.swift
//  Exhibition
//
//  Created by Bedirhan Yıldız on 2.08.2023.
//

import Foundation

class ProductDetailViewModel: BaseViewModel {
    
    private var productListRepository: ProductDetailRepositoryProtocol
    @Published var artObjectDetail: ArtObjectDetail?
    
    init(repo: ProductDetailRepository = ProductDetailRepository()) {
        self.productListRepository = repo
    }
    
    func getCollectionDetail(artObjectId: String?) {
        guard let id = artObjectId else {
            return
        }
        
        self.progress = true
        productListRepository.getCollectionDetail(id: id) { result in
            self.progress = false
            self.artObjectDetail = result.artObject
        } failure: { error in
            self.progress = false
            self.error = error
        }

    }
}
