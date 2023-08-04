//
//  ProductListViewModelTests.swift
//  ExhibitionTests
//
//  Created by Bedirhan Yıldız on 2.08.2023.
//

import XCTest
@testable import Exhibition

final class ProductListRepositoryTest: XCTestCase {
    
    var repo: ProductListRepositoryProtocol!
    
    override func setUp() {
        super.setUp()
        repo = ProductListRepository()
    }

    override func tearDown() {
        super.tearDown()
        repo = nil
    }
    
    func textProductList() {
        let expectation = XCTestExpectation(description: "Async Product List Call")

        repo.getCollection(start:1, count:10) { result in
            XCTAssertEqual(result.artObjects.count, 10, "Should be 10 Art objects")
            expectation.fulfill()
        } failure: { result in
            XCTAssertNotNil(result)
            expectation.fulfill()
        }
            
        wait(for: [expectation], timeout: 3.0)
    }

    func testProductListMaxItem() {
        let expectation = XCTestExpectation(description: "Async Product List Call")

        repo.getCollection(start:1001, count:10) { result in
            XCTAssertEqual(result.artObjects.count, 0, "Should be 0 Art objects")
            expectation.fulfill()
        } failure: { result in
            XCTAssertNotNil(result)
            expectation.fulfill()
        }
            
        wait(for: [expectation], timeout: 3.0)
    }

}
