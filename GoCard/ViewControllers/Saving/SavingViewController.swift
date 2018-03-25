//
//  SavingViewController.swift
//  GoCard
//
//  Created by ナム Nam Nguyen on 3/12/17.
//  Copyright © 2017 GoCard, Ltd. All rights reserved.
//

import UIKit
import RealmSwift

final class SavingViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    @IBOutlet weak var tableGoal: UITableView!
    @IBOutlet weak var searchBar: UITextField!
    internal var tableData:[Goal] = []
    internal var tableDataFiltered:[Goal] = []
    internal var selectedGoal:Goal?
    internal var notificationToken: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    private func setup(){
        self.title = "SAVING"
        searchBar.round(5.0)
        searchBar.addImageLeftView(#imageLiteral(resourceName: "Search Icon"))
        searchBar.attributedPlaceholder = NSAttributedString(string: "Search", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12), NSAttributedStringKey.foregroundColor: UIColor(hex:0x333333)])
        searchBar.delegate = self
        searchBar.addTarget(self, action: #selector(searchFieldDidChanged(_:)), for: .editingChanged)
        // load data
        let goals = try! Realm().objects(Goal.self).sorted(byKeyPath: Key.Goal.goalId.rawValue, ascending:false)
        notificationToken = goals.observe { (changes: RealmCollectionChange) in
            switch changes {
            case .initial:
                self.tableData.removeAll()
                self.tableData.append(contentsOf: goals)
                self.tableGoal.reloadData()
                break
            case .update(_, _, _, _):
                self.tableData.removeAll()
                self.tableData.append(contentsOf: goals)
                self.tableGoal.reloadData()
                break
            case .error(let err):
                fatalError("\(err)")
                break
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationViewController = segue.destination as? GoalDetailViewController else {
            return super.prepare(for: segue, sender: sender)
        }
        destinationViewController.goal = selectedGoal
    }
}

extension SavingViewController: UITextFieldDelegate {
    internal func isFiltering() -> Bool{
        if let keyword = searchBar.text {
            return keyword.characters.count > 2
        }
        return false
    }
    @objc internal func searchFieldDidChanged(_ textField: UITextField) {
        if let keyword = searchBar.text {
            if isFiltering() {
                applyFilter(keyword: keyword)
            } else if keyword.characters.count == 0 {
                resetFilter()
            }
        } else {
            resetFilter()
        }
    }
    internal func textFieldShouldClear(_ textField: UITextField) -> Bool {
        resetFilter()
        return true
    }
    internal func applyFilter(keyword key:String) {
        var allData:[Goal] = []
        allData.append(contentsOf: tableData)
        let filteredData = allData.filter {
            return $0.title.contains(key)
        }
        tableDataFiltered.removeAll()
        tableDataFiltered.append(contentsOf: filteredData)
        selectedGoal = nil
        tableGoal.reloadData()
    }
    internal func resetFilter() {
        selectedGoal = nil
        tableGoal.reloadData()
        UIView.animateKeyframes(withDuration: 0.35, delay: 0, options: [.calculationModeLinear], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.35, animations: {
                self.searchBar.resignFirstResponder()
            })
        }, completion: nil)
    }
    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if !searchBar.canResignFirstResponder { return false }
        UIView.animateKeyframes(withDuration: 0.35, delay: 0, options: [.calculationModeLinear], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.35, animations: {
                self.searchBar.resignFirstResponder()
            })
        }, completion: nil)
        return false
    }
}
