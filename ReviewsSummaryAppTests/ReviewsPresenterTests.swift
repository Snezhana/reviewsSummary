//
//  ReviewsPresenterTests.swift
//  ReviewsSummaryAppTests
//
//  Created by Snezhana Stojanova on 11/02/2018.
//  Copyright © 2018 SS. All rights reserved.
//

import XCTest
@testable import ReviewsSummaryApp

class ReviewsPresenterTests: XCTestCase {
    let presenter = ReviewPresenterImplementation()
    override func setUp() {
        super.setUp()
        let reviews = [ReviewItem(rating: 1, title: "one star", version: "1.2.3", content: "one star content"),
                       ReviewItem(rating: 3, title: "three star", version: "1.2.3", content: "three star content"),
                       ReviewItem(rating: 4, title: "four star", version: "1.2.3", content: "four star content"),
                       ReviewItem(rating: 5, title: "five star", version: "1.4.3", content: "five star content"),
                       ReviewItem(rating: 5, title: "five star 2", version: "1.5.3", content: "five star content 2")]
        presenter.dataSource = MockDataSource(reviews: reviews)
    }
    
    func testNumberOfRowsReturnByPresenter() {
        XCTAssert(presenter.numberOfReviews() == 5)
    }
    
    func testReviewItemPerIndexReturnedByPresenter() {
        XCTAssert(presenter.reviewForIndexPath(IndexPath(row: 0, section: 1))?.rating == 1)
        XCTAssert(presenter.reviewForIndexPath(IndexPath(row: 1, section: 1))?.title == "three star")
        XCTAssert(presenter.reviewForIndexPath(IndexPath(row: 2, section: 1))?.version == "1.2.3")
        XCTAssert(presenter.reviewForIndexPath(IndexPath(row: 3, section: 1))?.content == "five star content")
    }
    
    func testTopWordsReturnedByPresenter() {
        XCTAssert(presenter.topWords()[0] == "Test1")
    }
    
    func testFilteringByStar() {
        presenter.filterByStars(1)
        XCTAssert(presenter.numberOfReviews() == 1)
        presenter.presentAllReviews()
        XCTAssert(presenter.numberOfReviews() == 5)
        presenter.filterByStars(2)
        XCTAssert(presenter.numberOfReviews() == 0)
        presenter.filterByStars(5)
        XCTAssert(presenter.numberOfReviews() == 2)
    }
    

}

class MockDataSource: ReviewsDataSource {
    var filteredReviews: [Review]
    var reviews: [Review]
    init(reviews: [Review]) {
        self.reviews = reviews
        filteredReviews = reviews
    }
   

    func numberOfReviews() -> Int {
        return filteredReviews.count
    }
    
    func reviewForIndexPath(_ indexPath: IndexPath) -> Review? {
        return filteredReviews[indexPath.row]
    }
    
    func loadReviews(completion: @escaping () -> ()) {}
    
    func filterByStars(_ stars: Int, complition: () -> ()) {
        filteredReviews = reviews.filter{ $0.rating == stars }
    }
    
    func removeFilter(complition: () -> ()) {
        filteredReviews = reviews
    }
    
    func getTopWords() -> [String] {
        return ["Test1", "Test2", "Test3"]
    }
    
    
}

class MockView: PresenterOutput {
    func dataIsLoaded() {}
}
    
    
