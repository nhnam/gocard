//
//  UploadCell.swift
//  GoCard
//
//  Created by ナム Nam Nguyen on 3/26/17.
//  Copyright © 2017 GoCard, Ltd. All rights reserved.
//

import UIKit

final class UploadCell: UITableViewCell {
    @IBOutlet weak var uploadButton:UIButton!
    weak var viewcontroller: UIViewController?
    override func awakeFromNib() {
        super.awakeFromNib()
        uploadButton.round()
        uploadButton.glowWithColor(color: UIColor.blueButton)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func didTouchUploadButton(_ sender: UIButton?) {
        uploadButton.peek {
            self.viewcontroller?.performSegue(withIdentifier: "toAddNewCard", sender: self.viewcontroller)
        }
    }
    
}
