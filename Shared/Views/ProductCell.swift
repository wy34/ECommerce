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

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configureCell(product: Product) {
        productTitle.text = product.name
        productPrice.text = String(product.price)
        if let url = URL(string: product.imageUrl) {
            productImage.kf.setImage(with: url)
        }
    }
    
    @IBAction func addToCartClicked(_ sender: Any) {
        
    }
    
    @IBAction func favoriteClicked(_ sender: Any) {
           
    }

}
