//
//  FileHelper.swift
//  GoCard
//
//  Created by ナム Nam Nguyen on 3/28/17.
//  Copyright © 2017 GoCard, Ltd. All rights reserved.
//

import UIKit

final class FileHelper {
    
    class func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    class func saveImagePNG(image imageData:UIImage, name imageName:String, savingComplete complete:((String?)->())) {
        if let data = UIImagePNGRepresentation(imageData) {
            let filename:URL = getDocumentsDirectory().appendingPathComponent(imageName.trim()).appendingPathExtension("png")
            print("Will save at: \(filename)")
            do {
                try data.write(to: filename)
                complete(filename.absoluteString)
            } catch (let err) {
                print("Saving error: \(err.localizedDescription)")
                complete(nil)
            }
        }
    }
    class func saveImageJPEG(image imageData:UIImage, name imageName:String, savingComplete complete:((String?)->())) {
        if let data = UIImageJPEGRepresentation(imageData, 1.0) {
            let filename = getDocumentsDirectory().appendingPathComponent(imageName.trim()).appendingPathExtension("jpeg")
            print("Will save at: \(filename)")
            do {
                try data.write(to: filename)
                complete(filename.absoluteString)
            } catch (let err) {
                print("Saving error: \(err.localizedDescription)")
                complete(nil)
            }
        }
    }
}
