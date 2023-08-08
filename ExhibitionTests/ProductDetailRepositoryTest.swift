//
//  ProductDetailRepositoryTest.swift
//  ExhibitionTests
//
//  Created by Bedirhan Yıldız on 3.08.2023.
//

import XCTest
@testable import Exhibition

final class ProductDetailRepositoryTest: XCTestCase {

    var apiManager: Networkable!
    var repo: ProductDetailRepositoryProtocol!

    override func setUp() {
        super.setUp()
        apiManager = APIManager()
        repo = ProductDetailRepository(apiManager: apiManager)
    }

    override func tearDown() {
        super.tearDown()
        apiManager = nil
        repo = nil
    }
    
    func testProductDetailRepository() {
        let expectation = XCTestExpectation(description: "Async Product Detail Call")
        let artObjectId = "BK-17040-A"
        repo.getCollectionDetail(id: artObjectId) { result in
            XCTAssertEqual(artObjectId, result.artObject?.objectNumber, "Object numbers are same")
            expectation.fulfill()
        } failure: { result in
            expectation.fulfill()
        }
            
        wait(for: [expectation], timeout: 3.0)
    }

    func testProductDetailFail() {
        let expectation = XCTestExpectation(description: "Async Product Detail Call")
        let artObjectId = "test1234"

        repo.getCollectionDetail(id: artObjectId) { result in
            XCTAssertEqual(artObjectId, result.artObject?.objectNumber, "Object numbers are same")
            expectation.fulfill()
        } failure: { result in
            XCTAssertNotNil(result)
            expectation.fulfill()
        }
            
        wait(for: [expectation], timeout: 3.0)
    }

}
