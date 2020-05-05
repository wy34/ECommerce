//
//  Firebase+utils.swift
//  Artable
//
//  Created by William Yeung on 5/5/20.
//  Copyright © 2020 William Yeung. All rights reserved.
//

import Foundation
import Firebase

extension Auth {
    func handleFireAuthError(error: Error, vc: UIViewController) {
        if let errorCode = AuthErrorCode(rawValue: error._code) {
            let alert = UIAlertController(title: "Error", message: errorCode.errorMessage, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(okAction)
            vc.present(alert, animated: true, completion: nil)
        }
    }
}

extension AuthErrorCode {
    var errorMessage: String {
        switch self {
        case .emailAlreadyInUse:
            return "The email is already in use with another account. Pick another email!"
        case .invalidEmail:
            return "Invalid email"
        default:
            return "Sorry, something went wrong."
        }
    }
}
