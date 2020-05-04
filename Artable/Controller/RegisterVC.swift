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
        return UILabel().createTitleLabels(withText: "Register", ofColor: AppColors.customRed)
    }()
    
    private let usernameTextField: UITextField = {
        return UITextField().create(withPlaceholder: "username")
    }()
    
    private let emailTextField: UITextField = {
        return UITextField().create(withPlaceholder: "email")
    }()
    
    private let passwordTextField: PasswordTextField = {
        let tf = PasswordTextField()
        tf.placeholder = "password"
        tf.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return tf
    }()
    
    private let confirmPasswordTextField: PasswordTextField = {
        let tf = PasswordTextField()
        tf.placeholder = "confirm password"
        tf.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return tf
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton().createCustomButton(withTitle: "Register", ofColor: AppColors.customWhite, withBackgroundColor: AppColors.customBlue)
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
        guard let username = usernameTextField.text, username.isNotEmpty,
            let email = emailTextField.text, email.isNotEmpty,
            let  password = passwordTextField.text, password.isNotEmpty else { return }
        
        activityIndicator.startAnimating()
        
        guard let authUser = Auth.auth().currentUser else { return }
        
        let credential = EmailAuthProvider.credential(withEmail: email, password: password)
        authUser.link(with: credential) { (result, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
                self.handleFireAuthError(error: error)
                self.activityIndicator.stopAnimating()
                return
            }
            
            self.activityIndicator.stopAnimating()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func textFieldDidChange(_ textfield: UITextField) {
        guard let password = passwordTextField.text else { return }
        
        if textfield == confirmPasswordTextField {
            passwordTextField.passwordCheckImageView.isHidden = false
            confirmPasswordTextField.passwordCheckImageView.isHidden = false
        } else {
            if password == "" {
                confirmPasswordTextField.text = ""
                passwordTextField.passwordCheckImageView.isHidden = true
                confirmPasswordTextField.passwordCheckImageView.isHidden = true
            }
        }
        
        if passwordTextField.text == confirmPasswordTextField.text {
            passwordTextField.passwordCheckImageView.image = #imageLiteral(resourceName: "green_check")
            confirmPasswordTextField.passwordCheckImageView.image = #imageLiteral(resourceName: "green_check")
        } else {
            passwordTextField.passwordCheckImageView.image = #imageLiteral(resourceName: "red_check")
            confirmPasswordTextField.passwordCheckImageView.image = #imageLiteral(resourceName: "red_check")
        }
    }

    // MARK: - Helper functions
    func configureUI() {
        edgesForExtendedLayout = []
        navigationController?.navigationBar.tintColor = .white
        
        view.addSubview(backgroundImage)
        backgroundImage.anchor(top: view.topAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor)
        
        
        let stack = UIStackView(arrangedSubviews: [registerLabel, usernameTextField, emailTextField, passwordTextField, confirmPasswordTextField, registerButton])
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 15
        view.addSubview(stack)
        stack.anchor(top: view.topAnchor, trailing: view.trailingAnchor, leading: view.leadingAnchor, topPadding: 20, trailingPadding: 20, leadingPadding: 20)
        
        view.addSubview(activityIndicator)
        activityIndicator.anchor(top: stack.bottomAnchor, centerX: view.centerXAnchor, topPadding: 30, height: 15, width: 15)
    }
    
}
