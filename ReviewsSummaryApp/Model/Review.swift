//
//  Review.swift
//  ReviewsSummaryApp
//
//  Created by Snezhana Stojanova on 10/02/2018.
//  Copyright © 2018 SS. All rights reserved.
//

import Foundation

protocol Review {
    var rating: Int { get set }
    var title: String { get set }
    var version: String { get set }
    var content: String { get set }
}

struct ReviewItem: Review {
    var rating: Int
    var title: String
    var version: String
    var content: String
}
