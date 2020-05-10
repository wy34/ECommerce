//
//  AdminProductsVC.swift
//  ArtableAdmin
//
//  Created by William Yeung on 5/9/20.
//  Copyright © 2020 William Yeung. All rights reserved.
//

import UIKit

class AdminProductsVC: ProductVC {

    
    var selectedProduct: Product?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
    }
    
    // MARK: - Setup UI functions
    func setupNavBar() {
        let addCategoryButton = UIBarButtonItem(title: "Edit Category", style: .plain, target: self, action: #selector(editCategory))
        let newProductButton = UIBarButtonItem(title: "+ Product", style: .plain, target: self, action: #selector(newProduct))
        navigationItem.rightBarButtonItems = [addCategoryButton, newProductButton]
    }
    
    // MARK: - Selector functions
    @objc func editCategory() {
        navigationController?.pushViewController(AddEditCategoryVC.shared, animated: true)
    }
    
    @objc func newProduct() {
        navigationController?.pushViewController(AddEditProductsVC.shared, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedProduct = products[indexPath.row]
        navigationController?.pushViewController(AddEditProductsVC.shared, animated: true)
    }
}
