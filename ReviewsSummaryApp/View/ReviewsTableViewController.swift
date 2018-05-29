//
//  ReviewsTableViewController.swift
//  ReviewsSummaryApp
//
//  Created by Snezhana Stojanova on 10/02/2018.
//  Copyright © 2018 SS. All rights reserved.
//

import UIKit

protocol ReviewPresenter {
    func numberOfReviews() -> Int
    func reviewForIndexPath(_ indexPath: IndexPath) -> Review?
    func loadReviews()
    func filterByStars(_ stars: Int)
    func presentAllReviews()
    func topWords() -> [String]
}


class ReviewsTableViewController: UITableViewController, PresenterOutput {
    var presenter: ReviewPresenter?
    @IBOutlet weak var filterByStarsButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadReviews()
    }
    
    //Fix for bug in iOS11.2: UIBarButtonItem is fade out after selecting and return
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if #available(iOS 11.2, *) {
            self.navigationController?.navigationBar.tintAdjustmentMode = .normal
            self.navigationController?.navigationBar.tintAdjustmentMode = .automatic
        }
    }
    // MARK: - PresenterOutput
    
    func dataIsLoaded() {
        tableView?.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfReviews() ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewTableViewCell", for: indexPath) as? ReviewTableViewCell else { return UITableViewCell() }
        guard let review = presenter?.reviewForIndexPath(indexPath) else { return UITableViewCell()  }
        cell.rating.text = String.init(repeating: "⭐️", count: review.rating)
        cell.version.text = review.version
        cell.title.text = review.title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "ReviewDetailsViewController") as? ReviewDetailsViewController else { return }
        vc.review = presenter?.reviewForIndexPath(indexPath)
        show(vc, sender: nil)
    }
    
    
    // MARK: - IBActions
    
    @IBAction func didTapTopWords(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "TopWordsTableViewController") as? TopWordsTableViewController else { return }
        vc.presenter = presenter
        show(vc, sender: nil)
    }
    
    @IBAction func filterByStar(_ sender: Any) {
        let filterOptionsContr = UIAlertController()
        let action = UIAlertAction(title: NSLocalizedString("All Reviews", comment: "Title of Action for presenting all reviews - removing filter"), style: .default, handler: { _ in
            self.presenter?.presentAllReviews()
            self.title = "All Reviews"
        })
        filterOptionsContr.addAction(action)
        for i in 1...5 {
            let starsString = NSLocalizedString("Stars", comment: "Stars")
            let starString = NSLocalizedString("Star", comment: "Star")
            let action = UIAlertAction(title: String.init(repeating: "⭐️", count: i), style: .default, handler: { _ in
                self.presenter?.filterByStars(i)
                self.title = "\(i) \(i != 1 ? starsString : starString) \(NSLocalizedString("Reviews", comment: "Reviews"))"
            })
            filterOptionsContr.addAction(action)
        }
        filterOptionsContr.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "Cancel"), style: .cancel, handler: nil))
        if let popoverController = filterOptionsContr.popoverPresentationController {
            popoverController.barButtonItem = sender as? UIBarButtonItem
        }
        present(filterOptionsContr, animated: true, completion: nil)
    }
}
