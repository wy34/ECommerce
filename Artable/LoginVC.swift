//
//  ViewController.swift
//  Artable
//
//  Created by William Yeung on 4/28/20.
//  Copyright © 2020 William Yeung. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    // MARK: - Properties
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "bg_right1")
        return imageView
    }()
    
    private let loginLabel: UILabel = {
        let label = UILabel()
        label.text = "Login"
        label.textColor = UIColor.customBlue
        label.textAlignment = .center
        label.font = UIFont(name: "Futura", size: 17)
        return label
    }()
    
    private let emailTextField: UITextField = {
        return UITextField().createCustomTextField(withPlaceholder: "Email")
    }()
    
    private let passwordTextField: UITextField = {
        return UITextField().createCustomTextField(withPlaceholder: "Password")
    }()
    
    private let forgotPasswordButton: UIButton = {
        UIButton().createCustomButton(withTitle: "Forgot Password?", ofColor: .customRed, withBackgroundColor: .clear, textAlignment: .right)
    }()
    
    private let loginButton: UIButton = {
        UIButton().createCustomButton(withTitle: "Log In", ofColor: UIColor.customWhite, withBackgroundColor: .customBlue)
    }()
    
    private let newUserButton: UIButton = {
        UIButton().createCustomButton(withTitle: "Create new user", ofColor: UIColor.customWhite, withBackgroundColor: .customRed)
    }()
    
    private let guestButton: UIButton = {
        UIButton().createCustomButton(withTitle: "Continue as guest", ofColor: UIColor.customWhite, withBackgroundColor: .lightGray)
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Helper functions
    func configureUI() {
        view.addSubview(backgroundImageView)
        backgroundImageView.anchor(top: view.topAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor)
        
        let stack = UIStackView(arrangedSubviews: [loginLabel, emailTextField, passwordTextField, forgotPasswordButton, loginButton, newUserButton, guestButton])
        let navbarHeight = (navigationController?.navigationBar.frame.size.height)!
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 12
        view.addSubview(stack)
        stack.anchor(top: view.topAnchor, trailing: view.trailingAnchor, leading: view.leadingAnchor, topPadding: navbarHeight * 2 + 20, trailingPadding: 20, leadingPadding: 20)
    }
}

