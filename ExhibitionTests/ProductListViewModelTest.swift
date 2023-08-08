//
//  ProductListViewModelTest.swift
//  ExhibitionTests
//
//  Created by Bedirhan Yıldız on 4.08.2023.
//

import XCTest
import Combine
@testable import Exhibition

final class ProductListViewModelTest: XCTestCase {
    
    var apiManager: Networkable!
    var repo: ProductListRepositoryProtocol!
    var viewModel: ProductListViewModel!
    var anyCancellable: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        apiManager = APIManager()
        repo = ProductListRepository(apiManager: apiManager)
        viewModel = ProductListViewModel(repo: repo)
        anyCancellable = Set<AnyCancellable>()
    }

    override func tearDown() {
        super.tearDown()
        apiManager = nil
        repo = nil
        viewModel = nil
        anyCancellable = nil
    }

    func testCollectionWithArtObjects() {
        let expectation = XCTestExpectation(description: "Async Product List View Model Call")
        
        viewModel.$artObjects
            .dropFirst()
            .sink { result in
                XCTAssertEqual(result?.count, 10, "Art object count should be equal to 10")
                expectation.fulfill()
            }
            .store(in: &anyCancellable)
        
        viewModel.getCollection()
        wait(for: [expectation], timeout: 3.0)

    }
    
    func testCollectionLoadMore() {
        let section = 1
        let row = 8
        let index = (section * 10) + row

        let expectation1 = XCTestExpectation(description: "Async Product List View Model Call")
        
        viewModel.$artObjects
            .dropFirst()
            .sink { result in
                expectation1.fulfill()
            }
            .store(in: &anyCancellable)
        
        viewModel.getCollection()
        wait(for: [expectation1], timeout: 3.0)
        
        let expectation2 = XCTestExpectation(description: "Async Product List View Load More")

        viewModel.$artObjects
            .dropFirst()
            .sink { result in
                XCTAssertEqual(result?.count, 20, "Art object count should be equal to 10")
                expectation2.fulfill()
            }
            .store(in: &anyCancellable)
        
        viewModel.loadMore(index: index)
        wait(for: [expectation2], timeout: 3.0)
    }
}
