//
//  ProductCell.swift
//  TWWorkshop
//
//  Created by sarath-7196 on 20/12/19.
//  Copyright © 2019 TW. All rights reserved.
//

import Foundation
import UIKit

class ProductCell: UITableViewCell {
    
    private var productCount: Int! {
        didSet {
            if let count = productCount, oldValue != productCount {
                self.quantityLabel.text = "\(count)"
                quantityUpdateDelegate?.saveQuantity(pid: pid, quantity: productCount)
                updateDecrementButton()
            }
        }
    }
    
    weak var quantityUpdateDelegate: ProductQuantityUpdate!
    
    private var pid: String = ""
    
    private lazy var productImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.image = UIImage.init(named: "phone")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var productNameLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 2
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.font = UIFont.boldSystemFont(ofSize: 13)
        titleLabel.textAlignment = .left
        return titleLabel
    }()
    
    private lazy var priceLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.font = UIFont.boldSystemFont(ofSize: 13)
        titleLabel.textAlignment = .left
        return titleLabel
    }()
    
    private lazy var quantityLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 0
        titleLabel.text = "0"
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.font = UIFont.boldSystemFont(ofSize: 13)
        titleLabel.textAlignment = .left
        return titleLabel
    }()
    
    private lazy var incrementButton: UIButton = {
        let titleLabel = UIButton()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.isUserInteractionEnabled = true
        titleLabel.backgroundColor = .white
        titleLabel.layer.cornerRadius = 4
        titleLabel.layer.borderColor = UIColor.black.cgColor
        titleLabel.layer.borderWidth = 1
        titleLabel.setAttributedTitle(NSAttributedString.init(string: "+", attributes: [NSAttributedStringKey.foregroundColor : UIColor.black]), for: UIControlState.normal)
        titleLabel.addTarget(self, action: #selector(addQuantity), for: UIControlEvents.touchUpInside)
        titleLabel.titleLabel?.lineBreakMode = .byTruncatingTail
        return titleLabel
    }()
    
    private lazy var decrementButton: UIButton = {
        let titleLabel = UIButton()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.isUserInteractionEnabled = true
        titleLabel.backgroundColor = .white
        titleLabel.layer.cornerRadius = 4
        titleLabel.setAttributedTitle(NSAttributedString.init(string: "-", attributes: [NSAttributedStringKey.foregroundColor : UIColor.black]), for: UIControlState.normal)
        titleLabel.layer.borderColor = UIColor.black.cgColor
        titleLabel.layer.borderWidth = 1
        titleLabel.addTarget(self, action: #selector(decreaseQuantity), for: UIControlEvents.touchUpInside)
        titleLabel.titleLabel?.lineBreakMode = .byTruncatingTail
        return titleLabel
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
        self.setUpConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func addQuantity() {
        productCount += 1
    }
    
    @objc func decreaseQuantity() {
        productCount -= 1
    }
    
    private func setUpView() {
        self.addSubview(productImageView)
        self.addSubview(productNameLabel)
        self.addSubview(priceLabel)
        self.addSubview(incrementButton)
        self.addSubview(decrementButton)
        self.addSubview(quantityLabel)
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
        quantityLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        quantityLabel.centerYAnchor.constraint(equalTo: self.decrementButton.centerYAnchor).isActive = true
        decrementButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        decrementButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        decrementButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
        decrementButton.trailingAnchor.constraint(equalTo: self.quantityLabel.leadingAnchor, constant: -10).isActive = true
        incrementButton.trailingAnchor.constraint(equalTo: self.decrementButton.leadingAnchor).isActive = true
        incrementButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        incrementButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
        incrementButton.bottomAnchor.constraint(equalTo: self.decrementButton.bottomAnchor).isActive = true
    }
    
    fileprivate func updateDecrementButton() {
        if self.productCount < 1 {
            self.productCount = 0
            self.decrementButton.isEnabled = false
        } else {
            self.decrementButton.isEnabled = true
        }
    }
    
    func updateProduct(productModel: ProductCellModel,quantityUpdateDelegate: ProductQuantityUpdate) {
        self.pid = productModel.pid
        self.quantityUpdateDelegate = quantityUpdateDelegate
        self.productCount = quantityUpdateDelegate.getQuantity(pid: pid)
        updateDecrementButton()
        self.quantityLabel.text = String(describing: self.productCount ?? 0)
        self.productNameLabel.text = productModel.productName
        if let imageUrl = productModel.imageUrl {
            self.productImageView.loadImageUsingURLString(imageUrl)
        }
        self.priceLabel.text = productModel.price
        if productModel.isOfferPrice {
            self.priceLabel.textColor = UIColor.orange
        } else {
            self.priceLabel.textColor = UIColor.darkGray
        }
    }
    
}
