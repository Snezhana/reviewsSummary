//
//  ReviewsDataSource.swift
//  ReviewsSummaryApp
//
//  Created by Snezhana Stojanova on 10/02/2018.
//  Copyright © 2018 SS. All rights reserved.
//

import Foundation

protocol ReviewDataManager {
    func loadReviews(completion: @escaping ([Review]) -> ())
}


class ReviewDataSourceImplementation: ReviewsDataSource {
    var dataManager: ReviewDataManager? 
   
    var allReviews = [Review]() {
        didSet {
            filteredReviews = allReviews
        }
    }
    /// didSet: recalculates topWords
    var filteredReviews = [Review]() {
        didSet {
            topWords = getTopWordsWithNumberOfAppearing()
        }
    }
   
    var topWords: [String]?
    
    
    func loadReviews(completion: @escaping () -> ()) {
        dataManager?.loadReviews(completion: { reviewsData in
            self.allReviews = reviewsData
            completion()
        })
    }
    
    func numberOfReviews() -> Int {
        return filteredReviews.count
    }
    
    func reviewForIndexPath(_ indexPath: IndexPath) -> Review? {
        return filteredReviews[indexPath.row]
    }
    
    func removeFilter(complition: () -> ()) {
        filteredReviews = allReviews
        complition()
    }
    
    func filterByStars(_ stars: Int, complition: () -> ()) {
        filteredReviews = allReviews.filter{ Int($0.rating) == stars }
        complition()
    }
    
    func getTopWords() -> [String] {
        return topWords ?? []
    }
    
    func getTopWordsWithNumberOfAppearing() -> [String] {
        let contentItems = filteredReviews.map {$0.content}
        var wordsCount: [String: Int] = [:]
        let nonCharacters : [Character] = [".", ",", "?", "!"]
        for content in contentItems {
            let words = content.components(separatedBy: " ").filter({$0.count > 4})
            for word in words {
                var filteredWord = word
                if nonCharacters.contains(filteredWord.last!) { filteredWord.removeLast() }
                wordsCount[filteredWord.lowercased(), default: 0] += 1
            }
        }
       
        return wordsCount.sorted(by: { $0.value > $1.value }).map{ $0.key }
    }
   
}
