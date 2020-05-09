//
//  ForgotPasswordVC.swift
//  Artable
//
//  Created by William Yeung on 5/4/20.
//  Copyright © 2020 William Yeung. All rights reserved.
//

import UIKit
import Firebase

class ForgotPasswordVC: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var emaiTextField: PasswordTextField!
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    // MARK: - IBActions
    @IBAction func cancelClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func resetClicked(_ sender: Any) {
        guard let email = emaiTextField.text, email.isNotEmpty else { return }
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if let error = error {
                debugPrint(error)
                Auth.auth().handleFireAuthError(error: error, vc: self)
                return
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
}

