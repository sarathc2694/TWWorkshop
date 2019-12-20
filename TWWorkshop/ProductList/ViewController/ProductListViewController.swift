//
//  ViewController.swift
//  TWWorkshop
//
//  Created by sarath-7196 on 20/12/19.
//  Copyright © 2019 TW. All rights reserved.
//

import UIKit

class ProductListViewController: UIViewController {
    
    private var products: [ProductCellModel] = []
    
    var quantityUpdateManager: ProductQuantityUpdate!
    
    private var productFetchManager: ProductDataFetch!
    
    private let cellId = "ProductCell"
    
    private lazy var listView: UITableView = {
        let tableView = UITableView.init()
        tableView.isScrollEnabled = true
        tableView.delegate = self
        tableView.backgroundColor = UIColor.white
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ProductCell.self, forCellReuseIdentifier: cellId)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        quantityUpdateManager = UserDefaultsManager()
        productFetchManager = ProductListDataManager()
        view.backgroundColor = UIColor.white
        setUpView()
        fetchData()
    }

    private func setUpView() {
        self.view.addSubview(listView)
        listView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        listView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        listView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        listView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func fetchData() {
        productFetchManager?.getProducts { [weak self]  (result) in
            if let weakSelf = self, let productsArr = result {
                DispatchQueue.main.async {
                    weakSelf.updateViewModels(productsArr: productsArr)
                    weakSelf.listView.reloadData()
                }
            }
        }
    }
    
    private func updateViewModels(productsArr: [Product]) {
        for product in productsArr {
            products.append(ProductCellModel.init(product: product))
        }
    }

}

extension ProductListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}


extension ProductListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? ProductCell {
            let product = products[indexPath.item]
            cell.updateProduct(productModel: product, quantityUpdateDelegate: self.quantityUpdateManager)
            return cell
        }
        return UITableViewCell()
    }

}











