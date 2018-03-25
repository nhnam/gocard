//
//  QRCodeView.swift
//  GoCard
//
//  Created by ナム Nam Nguyen on 3/16/17.
//  Copyright © 2017 GoCard, Ltd. All rights reserved.
//

import UIKit

class QRCodeView: UIView {

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var qrCodeImageView:UIImageView?
    @IBOutlet weak var backButton:UIButton?
    @IBOutlet weak var title:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        title.characterSpacing(1.27, lineHeight: 16, withFont: UIFont.boldRoboto(size:14))
        backgroundView.round(6)
        backButton?.round()
        backButton?.glowWithColor(color: UIColor.greenButton)
        let qrImage = self.generateQR(from :"https://google.com")
        qrCodeImageView?.image = qrImage
        backButton?.characterSpacing(1.5, lineHeight: 16, withFont: UIFont.boldRoboto(size:14))
    }
    
    private func generateQR(from string:String) -> UIImage? {
        let data = string.data(using: String.Encoding.isoLatin1)
        if let filter = CIFilter(name:"CIQRCodeGenerator") {
            filter.setValue(data, forKey:"inputMessage")
            filter.setValue("H", forKey:"inputCorrectionLevel")
            guard let qrCodeImage = filter.outputImage else { return nil }
            guard let imageView = qrCodeImageView else { return nil }
            let scaleX = imageView .frame.size.width / qrCodeImage.extent.size.width
            let scaleY = imageView .frame.size.height / qrCodeImage.extent.size.height
            let transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
            if let output = filter.outputImage?.applying(transform) {
                return UIImage(ciImage: output)
            }
        }
        return nil
    }

    @IBAction func didTouchBack(_ sender: Any) {
        self.removeFromSuperview()
    }
    
}
