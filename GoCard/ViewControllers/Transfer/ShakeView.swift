//
//  ShakeView.swift
//  GoCard
//
//  Created by ナム Nam Nguyen on 3/16/17.
//  Copyright © 2017 GoCard, Ltd. All rights reserved.
//

import UIKit

class ShakeView: UIView {
    @IBOutlet var ovals: [UIImageView]?
    @IBOutlet weak var locationIcon: UIImageView?
    @IBOutlet weak var backButton: UIButton?
    @IBOutlet weak var backgroundView: UIView?
    @IBOutlet weak var title:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        title.characterSpacing(1.27, lineHeight: 16, withFont: UIFont.boldRoboto(size:14))
        backgroundView?.round(6)
        backButton?.round()
        backButton?.characterSpacing(1.5, lineHeight: 16, withFont: UIFont.boldRoboto(size:14))
        UserDefaults.standard.set(true, forKey: "waitingForShaking")
        ovals?.forEach{
            $0.alpha = 0.0
        }
        UIView.animateKeyframes(withDuration: 1.0, delay: 0.25, options: [.repeat,.calculationModeLinear], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.25, animations: {
                self.ovals?[0].alpha = 1.0
            })
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25, animations: {
                self.ovals?[1].alpha = 1.0
            })
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.25, animations: {
                self.ovals?[2].alpha = 1.0
            })
            UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.25, animations: {
                self.ovals?[3].alpha = 1.0
            })
        }, completion: { done in
            self.ovals?.forEach{
                $0.alpha = 0.0
            }
        })
    }
    
    @IBAction func didTouchBack(_ sender: Any) {
        self.removeFromSuperview()
        UserDefaults.standard.set(false, forKey: "waitingForShaking")
    }
}
