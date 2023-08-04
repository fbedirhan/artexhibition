//
//  ProductListViewModel.swift
//  Exhibition
//
//  Created by Bedirhan Yıldız on 2.08.2023.
//

import Foundation

class ProductListViewModel: BaseViewModel {
    
    private var productListRepository: ProductListRepositoryProtocol
    @Published var artObjects: [ArtObject]?
    var tempArtObjects = [ArtObject]()
    var start = 0
    var count = 10
    var total = 0
    var artObjectLimit = 10000
    
    init(repo: ProductListRepository = ProductListRepository()) {
        self.productListRepository = repo
    }
    
    func getCollection() {
        self.progress = true
        productListRepository.getCollection(start: start + 1, count: count) { result in
            self.progress = false
            self.tempArtObjects.append(contentsOf: result.artObjects)
            self.artObjects = self.tempArtObjects
            self.total = result.count
            self.start = self.start + 1
        } failure: { error in
            self.progress = false
            self.error = error
        }
    }
    
    func loadMore(index: Int) {
        if (start * count) < artObjectLimit && self.progress == false {
            let scrollStart = (Double(start * count) * 0.9).rounded(.down)
            if start > 0 && index >= Int(scrollStart) {
                getCollection()
            }
        }
    }
}
