//
//  UserDefaultsManager.swift
//  TWWorkshop
//
//  Created by sarath-7196 on 20/12/19.
//  Copyright © 2019 TW. All rights reserved.
//

import Foundation

protocol ProductQuantityUpdate: class {
    func saveQuantity(pid: String, quantity: Int)
    func getQuantity(pid: String) -> Int
}

class UserDefaultsManager: NSObject, ProductQuantityUpdate {

    func saveQuantity(pid: String, quantity: Int) {
        if var productsQuantityDict = UserDefaults.standard.dictionary(forKey: "ProductsQuantityDict") {
            productsQuantityDict[pid] = quantity
            UserDefaults.standard.set(productsQuantityDict, forKey: "ProductsQuantityDict")
        } else {
            let productsQuantityDict = [pid : quantity]
            UserDefaults.standard.set(productsQuantityDict, forKey: "ProductsQuantityDict")
        }
        UserDefaults.standard.synchronize()
    }
    
    func getQuantity(pid: String) -> Int {
        if let productsQuantityDict = UserDefaults.standard.dictionary(forKey: "ProductsQuantityDict") {
            if let quantity = productsQuantityDict[pid] as? Int {
                return quantity
            }
        }
        return 0
    }
    
}
