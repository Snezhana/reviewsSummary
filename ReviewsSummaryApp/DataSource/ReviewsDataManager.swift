//
//  ReviewsDataManager.swift
//  ReviewsSummaryApp
//
//  Created by Snezhana Stojanova on 10/02/2018.
//  Copyright © 2018 SS. All rights reserved.
//

import Foundation

protocol ReviewFetcher {
    func getJsonWithReviews(_ complition: @escaping (Response) -> ())
}

class ReviewDataManagerImplementation: ReviewDataManager {
    var fetcher: ReviewFetcher?
    func loadReviews(completion: @escaping ([Review]) -> ()) {
        fetcher?.getJsonWithReviews ({ response in
            switch response {
            case .error(let error):
                print("Response error: \(error)")
                completion([])
            case .success(let data):
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    let feed = json?["feed"] as? [String: Any]
                    var reviews = [ReviewItem]()
                    let entryReviews = feed?["entry"] as? [[String: Any]]
                    
                    entryReviews?.forEach({
                        guard let rating = ($0["im:rating"] as? [String: String])?["label"] else { return }
                        let title = self.getValueFromDict($0["title"] as? [String: String])
                        let version = self.getValueFromDict($0["im:version"] as? [String: String])
                        let content = self.getValueFromDict($0["content"] as? [String: Any])
                        reviews.append(ReviewItem(rating: Int(rating) ?? 0, title: title, version: version, content: content))
                    })
                    completion(reviews)
                } catch {
                    print("Error while trying to convert data to JSON: \(error)")
                    completion([])
                }
            }
        })
        
    }
    
    private func getValueFromDict(_ dict: [String: Any]?) -> String  {
        return dict?["label"] as? String ?? ""
    }
}
