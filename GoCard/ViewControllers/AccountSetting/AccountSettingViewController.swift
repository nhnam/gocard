//
//  AccountSettingViewController.swift
//  GoCard
//
//  Created by ナム Nam Nguyen on 3/27/17.
//  Copyright © 2017 GoCard, Ltd. All rights reserved.
//

import UIKit

class AccountSettingViewController: BaseViewController, UIScrollViewDelegate {

    @IBOutlet var segments: [SegmentControlItem]!
    @IBOutlet weak var scrollView: UIScrollView!
    private var personalSettingVC: PersonalSettingViewController?
    private var businessSettingVC: BusinessSettingViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        self.title = "ACCOUNT SETTING"
        segments.forEach {
            $0.addTarget(self, action: #selector(didTouchSegment(_:)), for: .touchUpInside)
        }
        segments[0].active = true
        // load personal view
        let mainSb = UIStoryboard(name: "Main", bundle: nil)
        if let vc = mainSb.instantiateViewController(withIdentifier: "PersonalSettingViewController") as? PersonalSettingViewController {
            personalSettingVC = vc
            scrollView.addSubview(vc.view)
            vc.view.frame = scrollView.bounds
            self.addChildViewController(vc)
            vc.didMove(toParentViewController: self)
        }
        if let vc = mainSb.instantiateViewController(withIdentifier: "BusinessSettingViewController") as? BusinessSettingViewController {
            businessSettingVC = vc
            scrollView.addSubview(vc.view)
            vc.view.frame = scrollView.bounds.offsetBy(dx: scrollView.frame.size.width, dy: 0)
            self.addChildViewController(vc)
            vc.didMove(toParentViewController: self)
        }
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: 2*scrollView.frame.size.width, height: scrollView.frame.size.height)
    }
    
    internal func didTouchSegment(_ sender: SegmentControlItem?) {
        guard let item = sender else { return }
        segments.forEach {
            if $0 != item { $0.active = false }
            else { $0.active = true }
        }
        if item.tag == 101 {
            UIView.animateKeyframes(withDuration: 0.3, delay: 0.0, options: [.calculationModePaced], animations: {
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.3, animations: {  [unowned self] in
                    self.scrollView.contentOffset = CGPoint(x: 0, y: 0)
                })
            }, completion: nil)
        } else if item.tag == 102 {
            UIView.animateKeyframes(withDuration: 0.3, delay: 0.0, options: [.calculationModePaced], animations: {
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.3, animations: { [unowned self] in
                    self.scrollView.contentOffset = CGPoint(x: self.scrollView.frame.size.width, y: 0)
                })
            }, completion: nil)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        if offset.x > scrollView.frame.size.width / 2 {
            segments[1].active = true
            segments[0].active = false
        } else {
            segments[0].active = true
            segments[1].active = false
        }
    }
}
