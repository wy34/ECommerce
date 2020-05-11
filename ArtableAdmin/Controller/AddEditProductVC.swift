//
//  AddEditProductsVC.swift
//  ArtableAdmin
//
//  Created by William Yeung on 5/9/20.
//  Copyright © 2020 William Yeung. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage

class AddEditProductVC: UIViewController {
 
    // MARK: - Properties
    var selectedCategory: Category!
    var productToEdit: Product?
    
    
    private lazy var productNameTextField: RoundIndentedTextfield = {
        let tf = RoundIndentedTextfield().withPlaceholder("Product Name")
        tf.widthAnchor.constraint(equalToConstant: view.frame.width * 0.9).isActive = true
        return tf
    }()
    
    private lazy var productPriceTextField: RoundIndentedTextfield = {
        let tf = RoundIndentedTextfield().withPlaceholder("Product Price")
        tf.keyboardType = .decimalPad
        tf.widthAnchor.constraint(equalToConstant: view.frame.width * 0.9).isActive = true
        return tf
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel().createTitleLabels(withText: "Enter Description Below", ofColor: AppColors.customBlue)
        label.heightAnchor.constraint(equalToConstant: view.frame.height * 0.03).isActive = true
        return label
    }()
    
    private lazy var descriptionTextView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .lightGray
        tv.widthAnchor.constraint(equalToConstant: view.frame.width * 0.9).isActive = true
        tv.heightAnchor.constraint(equalToConstant: view.frame.height * 0.10).isActive = true
        return tv
    }()
    
    private lazy var addImageLabel: UILabel = {
        let label = UILabel().createTitleLabels(withText: "Tap to add image", ofColor: AppColors.customBlue)
        label.heightAnchor.constraint(equalToConstant: view.frame.height * 0.03).isActive = true
        return label
    }()
    
    private lazy var imageView: PickerImageView = {
        let imageView = PickerImageView()
        imageView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.25).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: view.frame.width * 0.5).isActive = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(imgTapped))
        tap.numberOfTouchesRequired = 1
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tap)
        
        return imageView
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        return Indicator()
    }()
    
    private let addCategoryBtn: UIButton = {
        let button = UIButton().createCustomButton(withTitle: "Add Product", ofColor: .white, withBackgroundColor: AppColors.customBlue)
        button.addTarget(self, action: #selector(addProductClicked), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBaseUI()
        checkIfEditing()
    }
    
    // MARK: - Setup UI Functions
    func setupBaseUI() {
        view.backgroundColor = .white
        edgesForExtendedLayout = []
        
        let stack = UIStackView(arrangedSubviews: [productNameTextField, productPriceTextField, descriptionLabel, descriptionTextView, addImageLabel, imageView, activityIndicator])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.alignment = .center
        stack.spacing = 15
        
        view.addSubview(stack)
        stack.anchor(top: view.topAnchor, trailing: view.trailingAnchor, leading: view.leadingAnchor, topPadding: 15, trailingPadding: 10, leadingPadding: 10)
        
        view.addSubview(addCategoryBtn)
        addCategoryBtn.anchor(trailing: view.trailingAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailingPadding: 15, bottomPadding: 30, leadingPadding: 15)
    }
    
    // MARK: - Selector functions
    @objc func addProductClicked() {
        guard let productName = productNameTextField.text, productName.isNotEmpty,
               let productPrice = productPriceTextField.text, productPrice.isNotEmpty,
               let description = descriptionTextView.text, description.isNotEmpty,
               let image = imageView.image else {
                    simpleAlert(title: "Error", message: "Please fill out all fields")
                    return
                }
        
        activityIndicator.startAnimating()
        
        guard let imageData = image.jpegData(compressionQuality: 0.2) else { return }
        
        let imageRef = Storage.storage().reference().child("/productImages/\(productName).jpeg")
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        
        imageRef.putData(imageData, metadata: metaData) { (metadata, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
                self.simpleAlert(title: "Error", message: "Unable to upload image to storage.")
                return
            }
            
            imageRef.downloadURL { (url, error) in
                if let error = error {
                    debugPrint(error.localizedDescription)
                    self.simpleAlert(title: "Error", message: "Unable to download url")
                    return
                }
                
                guard let url = url else { return }
                
                self.uploadDocument(url: url.absoluteString)
                
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    @objc func imgTapped() {
        launchImagePicker()
    }
    
    // MARK: - Helper functions
    func uploadDocument(url: String) {
        var docRef: DocumentReference!
        var productData = Product(name: productNameTextField.text!, id: "", category: selectedCategory.id, price: Double(productPriceTextField.text!)!, productDescription: descriptionTextView.text!, imageUrl: url, timeStamp: Timestamp(), stock: 0)
        
        
        if let productToEdit = productToEdit {
            docRef = Firestore.firestore().collection("products").document(productToEdit.id)
            productData.id = productToEdit.id
        } else {
            docRef = Firestore.firestore().collection("products").document()
            productData.id = docRef.documentID
        }
        
        let data = Product.modelToData(product: productData)
        
        docRef.setData(data, merge: true) { (error) in
            if let error = error {
                debugPrint(error.localizedDescription)
                self.simpleAlert(title: "Error", message: "Unable to create document")
                return
            }
            
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    func checkIfEditing() {
        if let productToEdit = productToEdit {
            productNameTextField.text = productToEdit.name
            productPriceTextField.text = String(productToEdit.price)
            descriptionTextView.text = productToEdit.productDescription
            addCategoryBtn.setTitle("Save Changes", for: .normal)
        
            if let url = URL(string: productToEdit.imageUrl) {
                imageView.contentMode = .scaleAspectFill
                imageView.kf.setImage(with: url)
            }
        }
    }
}
    
 // MARK: - UIImagePickerController and UINavigationController Delegate
extension AddEditProductVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func launchImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let originalImage = info[.originalImage] as? UIImage else { return }
        imageView.image = originalImage
        imageView.contentMode = .scaleAspectFill
        dismiss(animated: true, completion: nil)
        
    }
}
