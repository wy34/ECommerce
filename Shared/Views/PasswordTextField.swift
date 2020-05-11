//
//  PasswordTextField.swift
//  Artable
//
//  Created by William Yeung on 4/29/20.
//  Copyright © 2020 William Yeung. All rights reserved.
//

import UIKit

class PasswordTextField: RoundIndentedTextfield {
    // MARK: - Properties
    let passwordCheckImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isHidden = true
        return imageView
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(passwordCheckImageView)
        passwordCheckImageView.anchor(trailing: self.trailingAnchor, centerY: self.centerYAnchor, trailingPadding: 6, height: 30, width: 30)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func withPlaceholder(_ placeholder: String) -> PasswordTextField {
        let tf = PasswordTextField()
        tf.placeholder = placeholder
        return tf
    }
}
