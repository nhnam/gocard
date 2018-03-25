//
//  BusinessSettingViewController.swift
//  GoCard
//
//  Created by ナム Nam Nguyen on 3/27/17.
//  Copyright © 2017 GoCard, Ltd. All rights reserved.
//

import UIKit

class BusinessSettingViewController: BaseViewController {

    @IBOutlet weak var uploadIdCardButton: UIButton!
    @IBOutlet weak var uploadConsignButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }

    private func setup() {
        uploadIdCardButton.round()
        uploadConsignButton.round()
    }
    
    @IBAction func didTouchUpload(_ sender: UIButton) {
        sender.peek {
            self.showPicker()
        }
    }
    
    func showPicker() {
        let pickerController = DKImagePickerController()
        pickerController.singleSelect = true
        pickerController.sourceType = .both
        pickerController.didSelectAssets = { [unowned self] (assets: [DKAsset]) in
            guard let asset = assets.first else { return }
            asset.fetchImageWithSize(CGSize(width:300, height:200), completeBlock: { image, info in
                //
            })
        }
        if UI_USER_INTERFACE_IDIOM() == .pad {
            pickerController.modalPresentationStyle = .formSheet
        }
        
        self.present(pickerController, animated: true) {}
    }
}
