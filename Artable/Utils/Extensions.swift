//
//  Extensions.swift
//  Artable
//
//  Created by William Yeung on 4/28/20.
//  Copyright © 2020 William Yeung. All rights reserved.
//

import UIKit


extension UIView {
    func anchor(top: NSLayoutYAxisAnchor? = nil, trailing: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, leading: NSLayoutXAxisAnchor? = nil, centerY: NSLayoutYAxisAnchor? = nil, centerX: NSLayoutXAxisAnchor? = nil, topPadding: CGFloat = 0, trailingPadding: CGFloat = 0, bottomPadding: CGFloat = 0, leadingPadding: CGFloat = 0, centerYPadding: CGFloat = 0, centerXPadding: CGFloat = 0, height: CGFloat? = nil, width: CGFloat? = nil) {
        
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
        
        if let centerY = centerY {
            centerYAnchor.constraint(equalTo: centerY, constant: centerYPadding).isActive = true
        }
        
        if let centerX = centerX {
            centerXAnchor.constraint(equalTo: centerX, constant: centerXPadding).isActive = true
        }

    }
}

extension UIColor {
    static var customBlue = #colorLiteral(red: 0.2274509804, green: 0.2666666667, blue: 0.3607843137, alpha: 1)
    static var customRed = #colorLiteral(red: 0.8352941176, green: 0.3921568627, blue: 0.3137254902, alpha: 1)
    static var customWhite = #colorLiteral(red: 0.9529411765, green: 0.9490196078, blue: 0.968627451, alpha: 1)
}

extension UITextField {
    func createCustomTextField(withPlaceholder placeholder: String, withCheckImage image: UIImage? = nil) -> UITextField {
        let tf = UITextField()
        tf.backgroundColor = .white
        tf.placeholder = placeholder
        tf.anchor(height: 40)
        
        let padding = UIView()
        padding.anchor(height: tf.frame.height, width: 10)
        tf.leftView = padding
        tf.leftViewMode = .always
        
        if let image = image {
            let imageView = UIImageView()
            tf.addSubview(imageView)
            imageView.image = image
            imageView.anchor(trailing: tf.trailingAnchor, centerY: tf.centerYAnchor, trailingPadding: 6, height: 30, width: 30)
        }
        
        return tf
    }
}

extension UIButton {
    func createCustomButton(withTitle title: String, ofColor color: UIColor, withBackgroundColor bgColor: UIColor, textAlignment: UIControl.ContentHorizontalAlignment? = nil) -> UIButton {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont(name: "Futura", size: 16)
        button.setTitleColor(color, for: .normal)
        button.backgroundColor = bgColor
        button.anchor(height: 40)
        
        if let textAlignment = textAlignment {
            button.contentHorizontalAlignment = textAlignment
        }
        
        return button
    }
}

extension UILabel {
    func createTitleLabels(withText text: String, ofColor color: UIColor) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = color
        label.textAlignment = .center
        label.font = UIFont(name: "Futura", size: 17)
        return label
    }
}


extension UIImageView {
    func setUpBackground(withImage image: UIImage) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }
}
