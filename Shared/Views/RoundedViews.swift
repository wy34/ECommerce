//
//  RoundedViews.swift
//  Artable
//
//  Created by William Yeung on 4/29/20.
//  Copyright © 2020 William Yeung. All rights reserved.
//

import UIKit

class RoundedShadowView: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.shadowColor = AppColors.customBlue.cgColor
        layer.shadowOffset = CGSize.zero
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 3
    }
}
