//
//  AddEditCategoryVC.swift
//  ArtableAdmin
//
//  Created by William Yeung on 5/8/20.
//  Copyright © 2020 William Yeung. All rights reserved.
//

import UIKit
import FirebaseStorage

class AddEditCategoryVC: UIViewController {
    
    // MARK: - Properties
    let categoryTitle: UILabel = {
        let label = UILabel().createTitleLabels(withText: "Category Label", ofColor: AppColors.customBlue)
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return label
    }()
    
    lazy var categoryTextField: UITextField = {
        let tf = UITextField().create(withPlaceholder: "Category Name")
        tf.widthAnchor.constraint(equalToConstant: view.frame.width - 30).isActive = true
        return tf
    }()
    
    let tapImageLabel: UILabel = {
        let label = UILabel().createTitleLabels(withText: "Tap image to add category image", ofColor: AppColors.customBlue)
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return label
    }()
    
    let imageView: PickerImageView = {
        return PickerImageView()
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        return Indicator()
    }()
    
    let addCategoryBtn: UIButton = {
        let button = UIButton().createCustomButton(withTitle: "Add Category", ofColor: .white, withBackgroundColor: AppColors.customBlue)
        button.addTarget(self, action: #selector(addCategoryClicked), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBaseUI()
    }
    
    // MARK: - Setup UI Functions
    func setupBaseUI() {
        view.backgroundColor = .white
        
        edgesForExtendedLayout = []
        
        let stack = UIStackView(arrangedSubviews: [categoryTitle, categoryTextField, tapImageLabel, imageView])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.alignment = .center
        stack.spacing = 15
        
        view.addSubview(stack)
        stack.anchor(top: view.topAnchor, trailing: view.trailingAnchor, leading: view.leadingAnchor, topPadding: 15, trailingPadding: 10, leadingPadding: 10)
        
        imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.35).isActive = true
        imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        
        
        view.addSubview(activityIndicator)
        activityIndicator.anchor(top: imageView.bottomAnchor, centerX: view.centerXAnchor, topPadding: 20, height: 25, width: 25)

        view.addSubview(addCategoryBtn)
        addCategoryBtn.anchor(trailing: view.trailingAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailingPadding: 15, bottomPadding: 30, leadingPadding: 15)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(imgTapped))
        tap.numberOfTouchesRequired = 1
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tap)
    }
    
    // MARK: - Helper functions
    func uploadImageThenDocument() {
        // imageView.image and categoryTextField.text are optional, and makesure that a categoryName is provided
        guard let image = imageView.image, let categoryName = categoryTextField.text, categoryName.isNotEmpty else {
            simpleAlert(title: "Error", message: "Must add category image and name")
            return
        }
        
        // turns jpeg image into a data object, small compressionQuality makes image quicker load
        guard let imageData = image.jpegData(compressionQuality: 0.2) else { return }
        
        // creates an address/folder
        let imageRef = Storage.storage().reference().child("/categoryImages/\(categoryName).jpg")
        
        // set metadata
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        // upload data
        imageRef.putData(imageData, metadata: metaData) { (metaData, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
                self.simpleAlert(title: "Error", message: "Unable to upload image")
                self.activityIndicator.stopAnimating()
                return
            }
            
            // once image is uploaded, retrieve the download url
            imageRef.downloadURL { (url, error) in
                if let error = error {
                    debugPrint(error.localizedDescription)
                    self.simpleAlert(title: "Error", message: "Unable to upload image")
                    self.activityIndicator.stopAnimating()
                    return
                }
                
                guard let url = url else { return }
                print(url)
                
            }
        }
        
    }
    
    func uploadDocument() {
        
    }
    
    // MARK: - Selector functions
    @objc func imgTapped() {
        launchImagePicker()
    }
    
    @objc func addCategoryClicked() {
        uploadImageThenDocument()
    }
    
}

// MARK: - ImagePickerController and NavigationController delegate methods
extension AddEditCategoryVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func launchImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
        imageView.contentMode = .scaleAspectFill
        imageView.image = image
        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
