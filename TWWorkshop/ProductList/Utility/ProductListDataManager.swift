//
//  ProductListDataManager.swift
//  TWWorkshop
//
//  Created by sarath-7196 on 20/12/19.
//  Copyright © 2019 TW. All rights reserved.
//

import Foundation

protocol ProductDataFetch {
    func getProducts(completion: @escaping ([Product]?) -> Void)
}

class ProductListDataManager: NSObject, ProductDataFetch {
    
    let productListUrl = "https://www.mocky.io/v2/5dfb59e72f00006200ff9e80"
    
    func getProducts(completion: @escaping ([Product]?) -> Void) {
        NetworkManager.sharedInstance.getData(with: productListUrl) { [weak self] (data, error) in
            guard let weakSelf = self, let data = data else {
                completion(nil)
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let object = json as? [Any] {
                    completion(weakSelf.createProducts(objs: object))
                }
            } catch {
                completion(nil)
            }
        }
    }
    
    private func createProducts(objs: [Any]) -> [Product] {
        var productsArr: [Product] = []
        for obj in objs {
            if let objDict = obj as? [String : String] {
                let product = objDict.createProduct()
                productsArr.append(product)
            }
        }
        return productsArr
    }
    
}
