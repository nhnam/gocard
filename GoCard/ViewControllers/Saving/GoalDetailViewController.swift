//
//  GoalDetailViewController.swift
//  GoCard
//
//  Created by ナム Nam Nguyen on 3/13/17.
//  Copyright © 2017 GoCard, Ltd. All rights reserved.
//

import UIKit

class GoalDetailViewController: BaseViewController, UIScrollViewDelegate {

    @IBOutlet weak var headerTopSpaceConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var featuredImage: UIImageView!
    @IBOutlet weak var goalNameLabel: UILabel!
    @IBOutlet weak var currentCostLabel: UILabel!
    @IBOutlet weak var totalCostLabel: UILabel!
    @IBOutlet weak var containerHeightConstraint: NSLayoutConstraint!
    private lazy var isAddedGradient: Bool = {
        self.addGradientMask(self.featuredImage)
       return true
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    var goal:Goal? {
        didSet{
            self.reload()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        headerView.setNeedsLayout()
        _ = isAddedGradient
        reload()
    }
    
    private func setup(){
        headerView.round(5)
        currentCostLabel.characterSpacing(0.55, lineHeight: 18, withFont: UIFont.roboto(size: 15))
        currentCostLabel.sizeToFit()
        totalCostLabel.characterSpacing(0.55, lineHeight: 15, withFont: UIFont.roboto(size: 13))
        totalCostLabel.sizeToFit()
        goalNameLabel.characterSpacing(0.75, lineHeight: 18, withFont: UIFont.boldRoboto(size: 15))
        goalNameLabel.sizeToFit()
        contentLabel.characterSpacing(0.65, lineHeight: 20, withFont: UIFont.roboto(size: 13))
        contentLabel.textAlignment = .left
        contentLabel.sizeToFit()
        scrollView.addObserver(self, forKeyPath: "contentSize", options: [.new], context: nil)
    }
    
    func addGradientMask(_ targetView: UIView) {
        let gradientMask = CAGradientLayer()
        gradientMask.frame = targetView.bounds
        gradientMask.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        gradientMask.locations = [0.8, 1.0]
        let maskView: UIView = UIView()
        maskView.layer.addSublayer(gradientMask)
        targetView.mask = maskView
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize" {
            let size: CGSize = contentLabel.sizeThatFits(CGSize(width: contentLabel.bounds.size.width, height: CGFloat.greatestFiniteMagnitude))
            let height = size.height
            containerHeightConstraint.constant = height
            contentLabel.setNeedsLayout()
            scrollView.removeObserver(self, forKeyPath: "contentSize")
            var contentSize = scrollView.contentSize
            contentSize.height = height
            scrollView.contentSize = contentSize
        }
    }
    
    private func reload() {
        guard let goal = self.goal else { return }
        if let _ = view {
            goalNameLabel.text = goal.title
            contentLabel.text = goal.detail
            goalNameLabel.characterSpacing(0.75, lineHeight: 18, withFont: UIFont.boldRoboto(size: 15))
            contentLabel.characterSpacing(0.65, lineHeight: 20, withFont: UIFont.roboto(size: 13))
            contentLabel.textAlignment = .left
            guard let url = URL(string: goal.featurePhotoUrl) else { return }
            featuredImage.contentMode = .scaleAspectFill
            featuredImage.kf.setImage(with: url)
            scrollView.contentOffset = CGPoint(x:0, y:0)
        }
    }
    
    @IBAction func didTouchEditButton(_ sender: Any) {
        Session.editingGoal = self.goal
        performSegue(withIdentifier: "toEditGoalVC", sender: self)
    }
}
