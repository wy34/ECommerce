//
//  HomeVC.swift
//  Artable
//
//  Created by William Yeung on 4/29/20.
//  Copyright © 2020 William Yeung. All rights reserved.
//

import UIKit
import Firebase

class HomeVC: UIViewController {
    // MARK: - Properties

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let _ = Auth.auth().currentUser {
            navigationItem.leftBarButtonItem?.title = "Logout"
        } else {
            navigationItem.leftBarButtonItem?.title = "Login"
        }
    }
    
    
    // MARK: - Helper functions
    func setupNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(loginPressed))
    }
    
    // MARK: - Selectors
    @objc func loginPressed() {
        if let _ = Auth.auth().currentUser {
            do {
                try Auth.auth().signOut()
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
       
        let nextScreen = UINavigationController(rootViewController: LoginVC())
        nextScreen.modalPresentationStyle = .fullScreen
        self.present(nextScreen, animated: true, completion: nil)
    }
}
