//
//  ReviewDataSourceTests.swift
//  ReviewsSummaryAppTests
//
//  Created by Snezhana Stojanova on 11/02/2018.
//  Copyright © 2018 SS. All rights reserved.
//

import XCTest
@testable import ReviewsSummaryApp

class ReviewDataSourceTests: XCTestCase {
    let dataSource = ReviewDataSourceImplementation()
    override func setUp() {
        super.setUp()
        dataSource.dataManager = MockReviewDataManager()
        dataSource.loadReviews(completion: {})
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testNumberOfReviewsReturnedByDataSource() {
        XCTAssert(dataSource.numberOfReviews() == 5)
    }
    
    func testReviewItemPerIndexReturnedByDataSource() {
        XCTAssert(dataSource.reviewForIndexPath(IndexPath(row: 0, section: 1))?.rating == 1)
        XCTAssert(dataSource.reviewForIndexPath(IndexPath(row: 1, section: 1))?.title == "three star")
        XCTAssert(dataSource.reviewForIndexPath(IndexPath(row: 2, section: 1))?.version == "1.2.3")
        XCTAssert(dataSource.reviewForIndexPath(IndexPath(row: 3, section: 1))?.content == "five stars content")
    }
    
    func testTopWordsReturnedByPresenter() {
        XCTAssert(dataSource.topWords![0] == "content")
        dataSource.filterByStars(5, complition:{})
        XCTAssert(dataSource.topWords![0] == "stars")
    }
    
    func testFilteringByStar() {
        dataSource.filterByStars(1, complition:{})
        XCTAssert(dataSource.numberOfReviews() == 1)
        dataSource.removeFilter {}
        XCTAssert(dataSource.numberOfReviews() == 5)
        dataSource.filterByStars(2, complition: {})
        XCTAssert(dataSource.numberOfReviews() == 0)
        dataSource.filterByStars(5, complition:{})
        XCTAssert(dataSource.numberOfReviews() == 2)
    }
}

class MockReviewDataManager: ReviewDataManager {
    func loadReviews(completion: @escaping ([Review]) -> ()) {
        completion([ReviewItem(rating: 1, title: "one star", version: "1.2.3", content: "one star  content"),
                    ReviewItem(rating: 3, title: "three star", version: "1.2.3", content: "three star content"),
                    ReviewItem(rating: 4, title: "four star", version: "1.2.3", content: "four star content"),
                    ReviewItem(rating: 5, title: "five star", version: "1.4.3", content: "five stars content"),
                    ReviewItem(rating: 5, title: "five star 2", version: "1.5.3", content: "five stars stars content 2")])
    }
    
    
}
