//
//  DictionaryExtension.swift
//  TWWorkshop
//
//  Created by sarath-7196 on 20/12/19.
//  Copyright © 2019 TW. All rights reserved.
//

import Foundation

extension Dictionary where Key: ExpressibleByStringLiteral, Value: Any {
    
    func createProduct() -> Product {
        let name = self["name"] as? String ?? ""
        let price = self["price"] as? String ?? ""
        let imageUrl = self["image"] as? String
        let pid = self["pid"] as? String ?? ""
        let offerPrice = self["offerPrice"] as? String
        return Product.init(imageUrl: imageUrl, productName: name, price: price, offerPrice: offerPrice, pid: pid)
    }
    
}
