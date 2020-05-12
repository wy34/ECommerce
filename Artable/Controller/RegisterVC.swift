//
//  RegisterVC.swift
//  Artable
//
//  Created by William Yeung on 4/28/20.
//  Copyright © 2020 William Yeung. All rights reserved.
//

import UIKit
import FirebaseFirestore
import Firebase

class RegisterVC: UIViewController {
    
    // MARK: - Properties
    private let backgroundImage: UIImageView = {
        return UIImageView().setUpBackground(withImage: #imageLiteral(resourceName: "bg_right1"))
    }()
    
    private let registerLabel: UILabel = {
        return UILabel().createTitleLabels(withText: "Register", ofColor: AppColors.customRed)
    }()
    
    private let usernameTextField: RoundIndentedTextfield = {
        return RoundIndentedTextfield().withPlaceholder("username")
    }()
    
    private let emailTextField: RoundIndentedTextfield = {
        return RoundIndentedTextfield().withPlaceholder("email")
    }()
    
    private let passwordTextField: PasswordTextField = {
        let tf = PasswordTextField().withPlaceholder("password")
        tf.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return tf
    }()
    
    private let confirmPasswordTextField: PasswordTextField = {
        let tf = PasswordTextField().withPlaceholder("confirm password")
        tf.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return tf
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton().createCustomButton(withTitle: "Register", ofColor: AppColors.customWhite, withBackgroundColor: AppColors.customBlue)
        button.addTarget(self, action: #selector(handleRegisterPressed), for: .touchUpInside)
        return button
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        return Indicator()
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
            let  password = passwordTextField.text, password.isNotEmpty else {
                simpleAlert(title: "Error", message: "Please fill out all fields.")
                return
        }
        
        guard let confirmedPass = confirmPasswordTextField.text, confirmedPass == password else {
            simpleAlert(title: "Error", message: "Passwords do not match")
            return
        }
        
        activityIndicator.startAnimating()
        
        guard let authUser = Auth.auth().currentUser else { return }
        
        let credential = EmailAuthProvider.credential(withEmail: email, password: password)
        
        authUser.link(with: credential) { (result, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
                Auth.auth().handleFireAuthError(error: error, vc: self)
                self.activityIndicator.stopAnimating()
                return
            }
            
            guard let firUser = result?.user else { return }
            let artUser = User.init(id: firUser.uid, email: email, username: username, stripeId: "")
            self.createFirestoreUser(user: artUser)
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
    
    func createFirestoreUser(user: User) {
        let userRef: DocumentReference = Firestore.firestore().collection("users").document()
        
        let data = User.modelToData(user: user)
        
        userRef.setData(data) { (error) in
            if let error = error {
                debugPrint(error.localizedDescription)
                self.simpleAlert(title: "Error", message: "Unable to set user data")
                return
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        }
        
    }
    
}
