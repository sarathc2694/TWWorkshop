//
//  ProductCell.swift
//  TWWorkshop
//
//  Created by sarath-7196 on 20/12/19.
//  Copyright © 2019 TW. All rights reserved.
//

import Foundation
import UIKit

class ProductCell: UICollectionViewCell {
    
    let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "phone")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let productNameLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 2
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.font = UIFont.boldSystemFont(ofSize: 13)
        titleLabel.textAlignment = .left
        return titleLabel
    }()
    
    let priceLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.font = UIFont.boldSystemFont(ofSize: 13)
        titleLabel.textAlignment = .left
        return titleLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpView()
        self.setUpConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView() {
        self.addSubview(productImageView)
        self.addSubview(productNameLabel)
        self.addSubview(priceLabel)
    }
    
    private func setUpConstraints() {
        productImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        productImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        productImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        productImageView.heightAnchor.constraint(equalToConstant: 130).isActive = true
        productNameLabel.topAnchor.constraint(equalTo: self.productImageView.topAnchor).isActive = true
        productNameLabel.leadingAnchor.constraint(equalTo: self.productImageView.trailingAnchor, constant: 10).isActive = true
        productNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        priceLabel.topAnchor.constraint(equalTo: self.productNameLabel.bottomAnchor, constant: 10).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo: self.productImageView.trailingAnchor, constant: 10).isActive = true
        priceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
    }
    
    func updateProduct(product: Product) {
        self.priceLabel.text = product.price
        self.productNameLabel.text = product.productName
    }
    
}
