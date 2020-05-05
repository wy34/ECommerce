//
//  ViewController.swift
//  Artable
//
//  Created by William Yeung on 5/5/20.
//  Copyright © 2020 William Yeung. All rights reserved.
//

import UIKit

class ProductVC: UIViewController {
    
    // MARK: - Properties
    let tableView = UITableView()
    
    let backgroundImage: UIImageView = {
        return UIImageView().setUpBackground(withImage: #imageLiteral(resourceName: "bg_cat3"), ofAlpha: 0.2)
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBaseUI()
        setupTableView()
    }
    
    // MARK: - Helper functions
    func setupBaseUI() {
        view.addSubview(backgroundImage)
        backgroundImage.anchor(top: view.topAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor)
        
        view.addSubview(tableView)
        tableView.anchor(top: view.topAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailingPadding: 10, leadingPadding: 10)
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
    }
}

    // MARK: - Tableview delegate methods
extension ProductVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
}
