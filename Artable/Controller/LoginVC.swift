//
//  ViewController.swift
//  Artable
//
//  Created by William Yeung on 4/28/20.
//  Copyright © 2020 William Yeung. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {
    
    // MARK: - Properties
    private let backgroundImageView: UIImageView = {
        return UIImageView().setUpBackground(withImage: #imageLiteral(resourceName: "bg_left1"))
    }()
    
    private let loginLabel: UILabel = {
        return UILabel().createTitleLabels(withText: "Log In", ofColor: AppColors.customBlue)
    }()
    
    private let emailTextField: UITextField = {
        return UITextField().create(withPlaceholder: "email")
    }()
    
    private let passwordTextField: UITextField = {
        return UITextField().create(withPlaceholder: "password")
    }()
    
    private let forgotPasswordButton: UIButton = {
        let button = UIButton().createCustomButton(withTitle: "Forgot Password?", ofColor: AppColors.customRed, withBackgroundColor: .clear, textAlignment: .right)
        button.addTarget(self, action: #selector(forgotPasswordBtnPressed), for: .touchUpInside)
        return button
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton().createCustomButton(withTitle: "Log In", ofColor: AppColors.customWhite, withBackgroundColor: AppColors.customBlue)
        button.addTarget(self, action: #selector(loginBtnPressed), for: .touchUpInside)
        return button
    }()
    
    private let newUserButton: UIButton = {
        let button = UIButton().createCustomButton(withTitle: "Create new user", ofColor: AppColors.customWhite, withBackgroundColor: AppColors.customRed)
        button.addTarget(self, action: #selector(newUserBtnPressed), for: .touchUpInside)
        return button
    }()
    
    private let guestButton: UIButton = {
        let button = UIButton().createCustomButton(withTitle: "Continue as guest", ofColor: AppColors.customWhite, withBackgroundColor: .lightGray)
        button.addTarget(self, action: #selector(guestButtonBtnPressed), for: .touchUpInside)
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
    @objc func forgotPasswordBtnPressed() {
        
    }
    @objc func loginBtnPressed() {
        guard let email = emailTextField.text, email.isNotEmpty,
            let password = passwordTextField.text, password.isNotEmpty else { return }
        
        activityIndicator.startAnimating()
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                debugPrint(error)
                return
            }
            self.activityIndicator.stopAnimating()
            self.dismiss(animated: true, completion: nil)
        }
    }
    @objc func newUserBtnPressed() {
        navigationController?.pushViewController(RegisterVC(), animated: true)
    }
    @objc func guestButtonBtnPressed() {
        
    }
    
    // MARK: - Helper functions
    func configureUI() {
        edgesForExtendedLayout = []
        navigationController?.navigationBar.barTintColor = AppColors.customRed
        navigationController?.navigationBar.barStyle = .black
        
        view.addSubview(backgroundImageView)
        backgroundImageView.anchor(top: view.topAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor)
        
        let stack = UIStackView(arrangedSubviews: [loginLabel, emailTextField, passwordTextField, forgotPasswordButton, loginButton, newUserButton, guestButton])
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 15
        view.addSubview(stack)
        stack.anchor(top: view.topAnchor, trailing: view.trailingAnchor, leading: view.leadingAnchor, topPadding: 20, trailingPadding: 20, leadingPadding: 20)
        
        view.addSubview(activityIndicator)
        activityIndicator.anchor(centerY: stack.centerYAnchor, centerX: stack.centerXAnchor, centerYPadding: -7)
    }
}

