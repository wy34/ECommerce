//
//  AdminProductsVC.swift
//  ArtableAdmin
//
//  Created by William Yeung on 5/9/20.
//  Copyright © 2020 William Yeung. All rights reserved.
//

import UIKit

class AdminProductVC: ProductVC {
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
        let screenToGoTo = AddEditCategoryVC()
        screenToGoTo.categoryToEdit = self.selectedCategory
        navigationController?.pushViewController(screenToGoTo, animated: true)
    }
    
    @objc func newProduct() {
        let screenToGoTo = AddEditProductVC()
        screenToGoTo.selectedCategory = selectedCategory
        navigationController?.pushViewController(screenToGoTo, animated: true)
    }
    
    // MARK: - Overridden Method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let screenToGoTo = AddEditProductVC()
        selectedProduct = products[indexPath.row]
        navigationController?.pushViewController(screenToGoTo, animated: true)
    }
}
