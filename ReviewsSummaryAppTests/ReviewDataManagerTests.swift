//
//  ReviewDataManagerTests.swift
//  ReviewsSummaryAppTests
//
//  Created by Snezhana Stojanova on 11/02/2018.
//  Copyright © 2018 SS. All rights reserved.
//

import XCTest
@testable import ReviewsSummaryApp

class ReviewDataManagerTests: XCTestCase {
    let dataManager = ReviewDataManagerImplementation()
    override func setUp() {
        super.setUp()
        dataManager.fetcher = MockReviewFetcher()
    }
    
    func testIfDataManagerIsProperlyMappingData() {
        let expectation = XCTestExpectation(description: "Take Json Data")
        
        dataManager.loadReviews(completion: { (reviews) in
            XCTAssert(reviews.count == 50)
            print(reviews[0].title)
            XCTAssert(reviews[0].title == "Irritant")
            print(reviews[0].content)
            XCTAssert(reviews[0].content == "Elke keer als ik even op mijn Facebook app zit valt het uit na 1 minuut zo irritant dit!! Doe er wat aan aub")
            XCTAssert(reviews[0].version == "173.0")
            XCTAssert(reviews[0].rating == 1)
             expectation.fulfill()
            })
        wait(for: [expectation], timeout: 3.0)
    }
    
}

class MockReviewFetcher: ReviewFetcher {
    func getJsonWithReviews(_ complition: @escaping (Response) -> ()) {
        let bundle = Bundle(for: type(of: self))
        if let path = bundle.path(forResource: "test_reviews_json", ofType: nil) {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                complition(.success(data: data))
            }
            catch {
                print("not possible to Make Data from file: \(error)")
            }
        }
    }
}
