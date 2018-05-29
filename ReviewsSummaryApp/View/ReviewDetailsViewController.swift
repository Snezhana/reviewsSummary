//
//  ReviewDetailsViewController.swift
//  ReviewsSummaryApp
//
//  Created by Snezhana Stojanova on 10/02/2018.
//  Copyright © 2018 SS. All rights reserved.
//

import UIKit

class ReviewDetailsViewController: UIViewController {

    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var version: UILabel!
    @IBOutlet weak var reviewTitle: UILabel!
    @IBOutlet weak var content: UILabel!
    var review: Review?
    override func viewDidLoad() {
        super.viewDidLoad()
        rating.text = String.init(repeating: "⭐️", count: review?.rating ?? 0)
        version.text = review?.version
        reviewTitle.text = review?.title
        content.text = review?.content
    }

}
