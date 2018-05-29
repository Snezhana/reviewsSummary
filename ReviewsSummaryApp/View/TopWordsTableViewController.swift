//
//  TopWordsTableViewController.swift
//  ReviewsSummaryApp
//
//  Created by Snezhana Stojanova on 11/02/2018.
//  Copyright © 2018 SS. All rights reserved.
//

import UIKit

class TopWordsTableViewController: UITableViewController {
    var presenter: ReviewPresenter?
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let presenter = presenter else { return 0 }
        return presenter.topWords().count < 3 ? presenter.topWords().count : 3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TopWordCell", for: indexPath)
        cell.textLabel?.text = presenter?.topWords()[indexPath.row]

        return cell
    }

}
