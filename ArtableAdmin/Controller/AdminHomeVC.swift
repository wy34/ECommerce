//
//  ViewController.swift
//  ArtableAdmin
//
//  Created by William Yeung on 4/28/20.
//  Copyright © 2020 William Yeung. All rights reserved.
//

import UIKit
import Firebase

class AdminHomeVC: HomeVC {
  
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Overridden methods
    override func setupNavBar() {
        super.setupNavBar()
        navigationItem.leftBarButtonItem?.isEnabled = false
        title = "admin"
        navigationItem.rightBarButtonItems = [UIBarButtonItem(title: "Add Category", style: .plain, target: self, action: #selector(addCategory))]
    }
    
    // MARK: - Selectors
    @objc func addCategory() {
        let screenToGoTo = AddEditCategoryVC()
        navigationController?.pushViewController(screenToGoTo, animated: true)
    }
}
