//
//  CustomImage.swift
//  TWWorkshop
//
//  Created by sarath-7196 on 20/12/19.
//  Copyright © 2019 TW. All rights reserved.
//

import Foundation
import UIKit

let imageCache =  NSCache<AnyObject, AnyObject>()

class CustomImageView: UIImageView {
    
    var imageUrl: String?
    
    func loadImageUsingURLString(_ url: String) {
        
        imageUrl = url
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        NetworkManager.sharedInstance.getData(with: url) { (data, error) in
            if error != nil {
                print(error!)
                return
            }
            DispatchQueue.main.async(execute: {
                if let imageData = data, let imageToCache = UIImage(data: imageData) {
                    if self.imageUrl == url {
                        self.image =  imageToCache
                    }
                    imageCache.setObject(imageToCache, forKey: url as AnyObject)
                }
            })
        }
    }
}
