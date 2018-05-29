//
//  ReviewsPresentation.swift
//  ReviewsSummaryApp
//
//  Created by Snezhana Stojanova on 10/02/2018.
//  Copyright © 2018 SS. All rights reserved.
//

import Foundation

protocol ReviewsDataSource {
    func numberOfReviews() -> Int
    func reviewForIndexPath(_ indexPath: IndexPath) -> Review?
    func loadReviews(completion: @escaping () -> ())
    func filterByStars(_ stars: Int, complition: () -> ())
    func removeFilter(complition: () -> ())
    func getTopWords() -> [String]

}


protocol PresenterOutput: class {
    func dataIsLoaded()
}

class ReviewPresenterImplementation: ReviewPresenter {
  
    var dataSource: ReviewsDataSource?
    weak var view: PresenterOutput?
    
    func presentAllReviews() {
        dataSource?.removeFilter(complition: {
            self.view?.dataIsLoaded()
        })
    }
    
    func loadReviews() {
        dataSource?.loadReviews(completion: {
            DispatchQueue.main.sync {
                self.view?.dataIsLoaded()
            }
        })
    }
    
    func numberOfReviews() -> Int {
        return dataSource?.numberOfReviews() ?? 0
    }
    
    func reviewForIndexPath(_ indexPath: IndexPath) -> Review? {
        return dataSource?.reviewForIndexPath(indexPath) ?? nil
    }
    
    func filterByStars(_ stars: Int) {
        dataSource?.filterByStars(stars, complition: {
            self.view?.dataIsLoaded()
        })
    }
    
    func topWords() -> [String] {
        return dataSource?.getTopWords() ?? []
    }
}
