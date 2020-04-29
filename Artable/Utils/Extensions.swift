//
//  Extensions.swift
//  Artable
//
//  Created by William Yeung on 4/28/20.
//  Copyright © 2020 William Yeung. All rights reserved.
//

import UIKit


extension UIView {
    func anchor(top: NSLayoutYAxisAnchor? = nil, trailing: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, leading: NSLayoutXAxisAnchor? = nil, topPadding: CGFloat = 0, trailingPadding: CGFloat = 0, bottomPadding: CGFloat = 0, leadingPadding: CGFloat = 0, height: CGFloat? = nil, width: CGFloat? = nil) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: topPadding).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -trailingPadding).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -bottomPadding).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: leadingPadding).isActive = true
        }
        
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
    }
}

extension UIColor {
    static var customBlue = #colorLiteral(red: 0.2274509804, green: 0.2666666667, blue: 0.3607843137, alpha: 1)
    static var customRed = #colorLiteral(red: 0.8352941176, green: 0.3921568627, blue: 0.3137254902, alpha: 1)
    static var customWhite = #colorLiteral(red: 0.9529411765, green: 0.9490196078, blue: 0.968627451, alpha: 1)
}



extension UITextField {
    func createCustomTextField(withPlaceholder placeholder: String) -> UITextField {
        let tf = UITextField()
        tf.backgroundColor = .white
        tf.placeholder = placeholder
        tf.anchor(height: 40)
        
        let padding = UIView()
        padding.anchor(height: tf.frame.height, width: 10)
        tf.leftView = padding
        tf.leftViewMode = .always
        
        return tf
    }
}



extension UIButton {
    func createCustomButton(withTitle title: String, ofColor color: UIColor, withBackgroundColor bgColor: UIColor, textAlignment: UIControl.ContentHorizontalAlignment? = nil) -> UIButton {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont(name: "Futura", size: 14)
        button.setTitleColor(color, for: .normal)
        
        if let textAlignment = textAlignment {
            button.contentHorizontalAlignment = textAlignment
        }
        
        button.backgroundColor = bgColor
        button.anchor(height: 40)
        return button
    }
}
