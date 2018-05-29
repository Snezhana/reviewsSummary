//
//  ReviewsNavigationController.swift
//  ReviewsSummaryApp
//
//  Created by Snezhana Stojanova on 11/02/2018.
//  Copyright © 2018 SS. All rights reserved.
//

import UIKit

class ReviewsNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let reviewsVC = viewControllers[0] as? ReviewsTableViewController else { return }
        let presenter = ReviewPresenterImplementation()
        presenter.view = reviewsVC
        reviewsVC.presenter = presenter
        let dataSource = ReviewDataSourceImplementation()
        presenter.dataSource = dataSource
        let dataManager = ReviewDataManagerImplementation()
        dataSource.dataManager = dataManager
        let dataFecther = ReviewFetcherImplementation()
        dataManager.fetcher = dataFecther
        
        addChildViewController(reviewsVC)
    }



}
