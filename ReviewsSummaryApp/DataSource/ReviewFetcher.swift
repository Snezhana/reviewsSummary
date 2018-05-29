//
//  ReviewFetcher.swift
//  ReviewsSummaryApp
//
//  Created by Snezhana Stojanova on 10/02/2018.
//  Copyright © 2018 SS. All rights reserved.
//

import Foundation
enum Response {
    case success(data: Data)
    case error(error: String)
}

class ReviewFetcherImplementation: ReviewFetcher {
    func getJsonWithReviews(_ complition: @escaping (Response) -> ()) {
        guard let url = URL(string: "https://itunes.apple.com/nl/rss/customerreviews/id=284882215/sortby=mostrecent/json") else { return }
        let urlRequest = URLRequest(url: url)
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest, completionHandler: {
            (data, response, error) in
            if let error = error {
                complition(.error(error: error.localizedDescription))
                print("Error:\(String(describing: error))")
                return
            }
            guard let responseData = data else {
                complition(.error(error: "Error: did not receive data"))
                return
            }
            complition((.success(data: responseData)))
        })
        task.resume()
    }
}
