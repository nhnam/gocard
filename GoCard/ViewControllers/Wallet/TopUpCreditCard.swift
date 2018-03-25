//
//  TopUpCreditCard.swift
//  GoCard
//
//  Created by ナム Nam Nguyen on 3/21/17.
//  Copyright © 2017 GoCard, Ltd. All rights reserved.
//

import UIKit

class TopUpCreditCard: UIView {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var uploadControl: CameraUploadControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        loadCreditCard()
    }
    
    let creditCardImages = ["CreditCard01","CreditCard02","CreditCard03","CreditCard04"]
    private func loadCreditCard() {
        var x:CGFloat = 0.0
        let y:CGFloat = 10.0
        let itemH:CGFloat = scrollView.frame.size.height - 20
        for idx in 0..<creditCardImages.count {
            x += 20.0
            let view = UIImageView(frame: CGRect(x: x, y: y, width: itemH*1.5, height: itemH))
            view.image = UIImage(named:creditCardImages[idx])
            view.contentMode = .scaleAspectFit
            scrollView.addSubview(view)
            x += itemH*1.5
        }
        scrollView.contentSize = CGSize(width: x + 20, height: scrollView.frame.size.height)
    }
    
    @IBAction func didTouchPickPhoto(_ sender: Any) {
        showCaptureImage()
    }
    
    func showCaptureImage() {
        guard let topViewController = UIViewController.topViewController() else { return }
        let pickerController = DKImagePickerController()
        pickerController.sourceType = .camera
        pickerController.singleSelect = true
        pickerController.didSelectAssets = { (assets: [DKAsset]) in
            BlurFullScreenView.showHiddenCurrent()
            guard let asset = assets.first else { return }
            asset.fetchImageWithSize(CGSize(width: 300, height: 200), completeBlock: { image, info in
                
            })
        }
        pickerController.didCancel = {
            BlurFullScreenView.showHiddenCurrent()
        }
        if UI_USER_INTERFACE_IDIOM() == .pad {
            pickerController.modalPresentationStyle = .formSheet
        }
        BlurFullScreenView.hideCurrent()
        topViewController.present(pickerController, animated: true) {
        }
    }
}
