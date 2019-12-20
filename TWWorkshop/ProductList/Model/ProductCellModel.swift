//
//  ProductCellModel.swift
//  TWWorkshop
//
//  Created by sarath-7196 on 20/12/19.
//  Copyright © 2019 TW. All rights reserved.
//

import Foundation

struct ProductCellModel {
    let imageUrl: String?
    let productName: String
    var price: String
    var isOfferPrice: Bool
    let pid: String
    
    init(product: Product) {
        pid = product.pid
        productName = product.productName
        imageUrl = product.imageUrl
        price = ""
        isOfferPrice = false
        if let offerPrice = product.offerPrice {
            price = offerPrice
            isOfferPrice = true
        } else {
            price = product.price
            isOfferPrice = false
        }
    }
}
