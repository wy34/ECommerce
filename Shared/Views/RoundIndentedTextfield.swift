//
//  RoundIndentedTextfield.swift
//  Artable
//
//  Created by William Yeung on 5/10/20.
//  Copyright © 2020 William Yeung. All rights reserved.
//

import UIKit

class RoundIndentedTextfield: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .white
        anchor(height: 40)
        borderStyle = .roundedRect

        let padding = UIView()
        padding.anchor(height: frame.height, width: 10)
        leftView = padding
        leftViewMode = .always
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func withPlaceholder(_ placeholder: String) -> RoundIndentedTextfield {
        let tf = RoundIndentedTextfield()
        tf.placeholder = placeholder
        return tf
    }
}
