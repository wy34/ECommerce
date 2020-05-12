//
//  ActivityIndicator.swift
//  Artable
//
//  Created by William Yeung on 5/5/20.
//  Copyright © 2020 William Yeung. All rights reserved.
//

import UIKit

class Indicator: UIActivityIndicatorView {
    convenience init() {
        self.init(frame: CGRect.zero)
        style = .large
        hidesWhenStopped = true
    }
}
