//
//  PickerImageView.swift
//  ArtableAdmin
//
//  Created by William Yeung on 5/8/20.
//  Copyright © 2020 William Yeung. All rights reserved.
//

import UIKit

class PickerImageView: UIImageView {
    
    convenience init() {
        self.init(frame: CGRect.zero)
        
        self.image = #imageLiteral(resourceName: "camera")
        self.contentMode = .center
        self.backgroundColor = .lightGray
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
}
