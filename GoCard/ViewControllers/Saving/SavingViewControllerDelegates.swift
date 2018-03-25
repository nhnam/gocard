//
//  SavingViewControllerDelegates.swift
//  GoCard
//
//  Created by ナム Nam Nguyen on 3/19/17.
//  Copyright © 2017 GoCard, Ltd. All rights reserved.
//

import UIKit

extension SavingViewController {
    // MARK - UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering() ? tableDataFiltered.count : tableData.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "goal_cell", for: indexPath)
        if cell is GoalCell {
            if isFiltering() {
                (cell as! GoalCell).config(tableDataFiltered[indexPath.row])
            } else {
                (cell as! GoalCell).config(tableData[indexPath.row])
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? GoalCell else { return }
        cell.setNeedsLayout()
        cell.prepareForWillDisplay()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isFiltering() {
            selectedGoal = tableDataFiltered[indexPath.row]
        } else {
            selectedGoal = tableData[indexPath.row]
        }
        performSegue(withIdentifier: "toGoalDetail", sender: self)
    }
    
    // MARK - UIScrollViewDelegate
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if searchBar.canResignFirstResponder { searchBar.resignFirstResponder() }
    }
}
