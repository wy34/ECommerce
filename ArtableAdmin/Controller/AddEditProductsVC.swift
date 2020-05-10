//
//  AddEditProductsVC.swift
//  ArtableAdmin
//
//  Created by William Yeung on 5/9/20.
//  Copyright © 2020 William Yeung. All rights reserved.
//

import UIKit

class AddEditProductsVC: UIViewController {
    
    static let shared = AddEditProductsVC()
    var selectedCategory: Category!
    var productToEdit: Product?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}
