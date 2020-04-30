//
//  RegisterVC.swift
//  Artable
//
//  Created by William Yeung on 4/28/20.
//  Copyright © 2020 William Yeung. All rights reserved.
//

import UIKit
import Firebase

class RegisterVC: UIViewController {
    
    // MARK: - Properties
    private let backgroundImage: UIImageView = {
        return UIImageView().setUpBackground(withImage: #imageLiteral(resourceName: "bg_right1"))
    }()
    
    private let registerLabel: UILabel = {
        return UILabel().createTitleLabels(withText: "Register", ofColor: .customRed)
    }()
    
    private let usernameTextField: UITextField = {
        return UITextField().createCustomTextField(withPlaceholder: "username")
    }()
    
    private let emailTextField: UITextField = {
        return UITextField().createCustomTextField(withPlaceholder: "email")
    }()
    
    private let passwordTextField: UITextField = {
        return UITextField().createCustomTextField(withPlaceholder: "password", withCheckImage: #imageLiteral(resourceName: "red_check"))
    }()
    
    private let confirmPasswordTextField: UITextField = {
        return UITextField().createCustomTextField(withPlaceholder: "confirm password", withCheckImage: #imageLiteral(resourceName: "red_check"))
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton().createCustomButton(withTitle: "Register", ofColor: .customWhite, withBackgroundColor: .customBlue)
        button.addTarget(self, action: #selector(handleRegisterPressed), for: .touchUpInside)
        return button
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.hidesWhenStopped = true
        return indicator
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Selectors
    @objc func handleRegisterPressed() {
        guard let username = usernameTextField.text, !username.isEmpty,
            let email = emailTextField.text, !email.isEmpty,
            let  password = passwordTextField.text, !username.isEmpty else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                debugPrint(error)
                return
            }
            
            print("Successfully registered new user")
        }
        
    }
    
    // MARK: - Helper functions
    func configureUI() {
        edgesForExtendedLayout = []
        
        view.addSubview(backgroundImage)
        backgroundImage.anchor(top: view.topAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor)
        
        
        let stack = UIStackView(arrangedSubviews: [registerLabel, usernameTextField, emailTextField, passwordTextField, confirmPasswordTextField, registerButton])
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 15
        view.addSubview(stack)
        stack.anchor(top: view.topAnchor, trailing: view.trailingAnchor, leading: view.leadingAnchor, topPadding: 20, trailingPadding: 20, leadingPadding: 20)
        
        view.addSubview(activityIndicator)
        activityIndicator.anchor(top: stack.bottomAnchor, centerX: view.centerXAnchor, topPadding: 10, height: 15, width: 15)
    }
    
}
