//
//  ProductDetailViewModel.swift
//  ExhibitionTests
//
//  Created by Bedirhan Yıldız on 4.08.2023.
//

import XCTest
import Combine
@testable import Exhibition

final class ProductDetailViewModelTest: XCTestCase {

    var apiManager: Networkable!
    var repo: ProductDetailRepositoryProtocol!
    var viewModel: ProductDetailViewModel!
    var anyCancellable: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        apiManager = APIManager()
        repo = ProductDetailRepository(apiManager: apiManager)
        viewModel = ProductDetailViewModel(repo: repo)
        anyCancellable = Set<AnyCancellable>()
    }

    override func tearDown() {
        super.tearDown()
        viewModel = nil
        anyCancellable = nil
    }
    
    func testCollectionDetailWithArtObjects() {
        let expectation = XCTestExpectation(description: "Async Product Detail View Model Call")
        let artObjectId = "BK-17040-A"

        viewModel.$artObjectDetail
            .dropFirst()
            .sink { result in
                XCTAssertEqual(result?.objectNumber, artObjectId, "Art object numbers should be same")
                expectation.fulfill()
            }
            .store(in: &anyCancellable)
        
        viewModel.getCollectionDetail(artObjectId: artObjectId)
        wait(for: [expectation], timeout: 3.0)

    }

}
