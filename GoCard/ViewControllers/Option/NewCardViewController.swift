//
//  NewCardViewController.swift
//  GoCard
//
//  Created by ナム Nam Nguyen on 3/26/17.
//  Copyright © 2017 GoCard, Ltd. All rights reserved.
//

import UIKit

final class NewCardViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        self.title = "ADD NEW CARD"
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapBackground(_:))))
    }
    
    @IBAction func didTouchCameraButton(_ sender: Any) {
        let pickerController = DKImagePickerController()
        pickerController.singleSelect = true
        pickerController.didSelectAssets = { (assets: [DKAsset]) in
            guard let asset = assets.first else { return }
            asset.fetchImageWithSize(CGSize(width:300, height: 200), completeBlock: { image, info in
                print("Image granted")
            })
        }
        if UI_USER_INTERFACE_IDIOM() == .pad {
            pickerController.modalPresentationStyle = .formSheet
        }
        self.present(pickerController, animated: true) {}
    }
    
    @IBAction func didTouchConfirmButton(_ sender: Any) {
        self.performSegue(withIdentifier: "toEnterPin", sender: self)
    }
    
    internal func didTapBackground(_ sender:UIGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
