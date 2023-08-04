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

    var viewModel: ProductListViewModel!
    var anyCancellable: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        viewModel = ProductListViewModel()
        anyCancellable = Set<AnyCancellable>()
    }

    override func tearDown() {
        super.tearDown()
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
}
