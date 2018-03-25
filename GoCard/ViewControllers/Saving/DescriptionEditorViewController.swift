//
//  DescriptionEditorViewController.swift
//  GoCard
//
//  Created by ナム Nam Nguyen on 3/15/17.
//  Copyright © 2017 GoCard, Ltd. All rights reserved.
//

import UIKit
import RealmSwift

class DescriptionEditorViewController: BaseViewController {

    @IBOutlet weak var contentTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup(){
        title = "GOAL DESCRIPTION"
        if let goal = Session.editingGoal {
            contentTextView.text = goal.detail
        }
        contentTextView.characterSpacing(0.7, lineHeight: 23)
    }
    
    @IBAction func didTouchCheckButton(_ sender: Any) {
        let realm = try! Realm()
        try! realm.write {
            Session.editingGoal?.detail = contentTextView.text
        }
        let size = CGSize(width: 40, height: 30)
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(ActivityData(size: size, type: .ballBeat))
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.0) { [weak self] in
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
            _ = self?.navigationController?.popViewController(animated: true)
        }
    }
}
