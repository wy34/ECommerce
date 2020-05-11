//
//  ProductCell.swift
//  Artable
//
//  Created by William Yeung on 5/5/20.
//  Copyright © 2020 William Yeung. All rights reserved.
//

import UIKit
import Kingfisher

class ProductCell: UITableViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var addButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        addButton.layer.cornerRadius = 5
        addButton.backgroundColor = AppColors.customRed
        addButton.tintColor = AppColors.customWhite
    }

    func configureCell(product: Product) {
        productTitle.text = product.name
        productPrice.text = String(product.price)
        
        if let url = URL(string: product.imageUrl) {
            let placeholderImage = UIImage(named: "placeholder")
            productImage.kf.indicatorType = .activity
            let options: KingfisherOptionsInfo = [KingfisherOptionsInfoItem.transition(.fade(0.2))]
            productImage.kf.setImage(with: url, placeholder: placeholderImage, options: options)
        }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        if let price = formatter.string(from: product.price as NSNumber) {
            productPrice.text = price
        }
    }
    
    @IBAction func addToCartClicked(_ sender: Any) {
        
    }
    
    @IBAction func favoriteClicked(_ sender: Any) {
           
    }

}
