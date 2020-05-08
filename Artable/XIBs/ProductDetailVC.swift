//
//  ProductDetailVC.swift
//  Artable
//
//  Created by William Yeung on 5/7/20.
//  Copyright © 2020 William Yeung. All rights reserved.
//

import UIKit

class ProductDetailVC: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var bgView: UIVisualEffectView!
    
    var product: Product!
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        productTitle.text = product.name
        productDescription.text = product.productDescription
        
        if let url = URL(string: product.imageUrl) {
            productImage.kf.setImage(with: url)
        }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        if let price = formatter.string(from: product.price as NSNumber) {
            productPrice.text = price
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissProduct(_:)))
        tap.numberOfTouchesRequired = 1
        bgView.addGestureRecognizer(tap)
    }
    
    // MARK: - Selector functions
    @objc func dismissProduct() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - IBAction Functions
    @IBAction func addCartClicked(_ sender: Any) {
       dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dismissProduct(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
