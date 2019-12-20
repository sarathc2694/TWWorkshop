//
//  Product.swift
//  TWWorkshop
//
//  Created by sarath-7196 on 20/12/19.
//  Copyright © 2019 TW. All rights reserved.
//

import Foundation

struct Product: Codable {
    
    let imageUrl: String?
    let productName: String
    let price: String
    let offerPrice: String?
    let pid: String
}
