//
//  PasswordTextField.swift
//  Artable
//
//  Created by William Yeung on 4/29/20.
//  Copyright © 2020 William Yeung. All rights reserved.
//

import UIKit

class PasswordTextField: UITextField {

    let passwordCheckImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isHidden = true
        return imageView
    }()
    
    let padding: UIView = {
        let padding = UIView()
        padding.anchor(height: 10, width: 10)
        return padding
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupTextField() {
        backgroundColor = .white
        anchor(height: 40)
        
        addSubview(padding)
        leftView = padding
        leftViewMode = .always
        
        addSubview(passwordCheckImageView)
        passwordCheckImageView.anchor(trailing: self.trailingAnchor, centerY: self.centerYAnchor, trailingPadding: 6, height: 30, width: 30)
    }
}
