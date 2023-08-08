//
//  ProductListViewModelTests.swift
//  ExhibitionTests
//
//  Created by Bedirhan Yıldız on 2.08.2023.
//

import XCTest
@testable import Exhibition

final class ProductListRepositoryTest: XCTestCase {
    
    var apiManager: Networkable!
    var repo: ProductListRepositoryProtocol!
    var count: Int!
    
    override func setUp() {
        super.setUp()
        apiManager = APIManager()
        repo = ProductListRepository(apiManager: apiManager)
        count = 10
    }

    override func tearDown() {
        super.tearDown()
        apiManager = nil
        repo = nil
        count = nil
    }

    func testProductList() {
        let expectation = XCTestExpectation(description: "Async Product List Call")

        repo.getCollection(start:1, count:count) { result in
            XCTAssertEqual(result.artObjects?.count, self.count, "Should be 10 Art objects")
            expectation.fulfill()
        } failure: { result in
            XCTAssertNotNil(result)
            expectation.fulfill()
        }
            
        wait(for: [expectation], timeout: 3.0)
    }
    
    func testProductListMaxItem() {
        let expectation = XCTestExpectation(description: "Async Product List Max Call")

        repo.getCollection(start:1001, count:count) { result in
            XCTAssertEqual(result.artObjects?.count, 0, "Should be 0 Art objects")
            expectation.fulfill()
        } failure: { result in
            XCTAssertNotNil(result)
            expectation.fulfill()
        }
            
        wait(for: [expectation], timeout: 3.0)
    }
    

}
