//
//  CategoryCell.swift
//  Artable
//
//  Created by William Yeung on 5/5/20.
//  Copyright © 2020 William Yeung. All rights reserved.
//

import UIKit
import Kingfisher

class CategoryCell: UICollectionViewCell {
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        categoryImage.layer.cornerRadius = 5
    }
    
    func configureCell(category: Category) {
        categoryLabel.text = category.name
        
        if let url = URL(string: category.imageUrl) {
            let placeholder = UIImage(named: "placeholder")
            let options: KingfisherOptionsInfo = [KingfisherOptionsInfoItem.transition(.fade(0.1))]
            categoryImage.kf.indicatorType = .activity
            categoryImage.kf.setImage(with: url, placeholder: placeholder, options: options)
        }
    }
}
