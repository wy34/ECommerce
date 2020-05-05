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
    
    @IBOutlet weak var emaiTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func cancelClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func resetClicked(_ sender: Any) {
        guard let email = emaiTextField.text, email.isNotEmpty else { return }
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if let error = error {
                debugPrint(error)
                self.handleFireAuthError(error: error)
                return
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
}

