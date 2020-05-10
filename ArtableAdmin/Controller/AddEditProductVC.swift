//
//  AddEditProductsVC.swift
//  ArtableAdmin
//
//  Created by William Yeung on 5/9/20.
//  Copyright © 2020 William Yeung. All rights reserved.
//

import UIKit

class AddEditProductVC: UIViewController {
    var selectedCategory: Category!
    var productToEdit: Product?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}
