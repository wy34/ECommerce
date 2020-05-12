//
//  HomeVC.swift
//  Artable
//
//  Created by William Yeung on 4/29/20.
//  Copyright © 2020 William Yeung. All rights reserved.
//

import UIKit
import Firebase

class HomeVC: UICollectionViewController {
    // MARK: - Properties
    var categories = [Category]()
    var selectedCategory: Category!
    var db: Firestore!
    var listener: ListenerRegistration!
    
    let backgroundImage: UIImageView = {
        let imageView = UIImageView().setUpBackground(withImage: #imageLiteral(resourceName: "bg_cat3"), ofAlpha: 0.2)
        imageView.layer.zPosition = -5
        return imageView
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        return Indicator()
    }()
    // MARK: - Lifecycle
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupBaseUI()
        setupCollectionView()
        
        db = Firestore.firestore()
        setupInitialAnonUser()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setCategoriesListener()
        
        if let user = Auth.auth().currentUser, !user.isAnonymous {
            navigationItem.leftBarButtonItem?.title = "Logout"
            if UserService.userListener == nil {
                UserService.getCurrentUser()
            }
        } else {
            navigationItem.leftBarButtonItem?.title = "Login"
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        listener.remove()
        categories.removeAll()
        collectionView.reloadData()
    }
    
    // MARK: - Firebase helper functions
    func setupInitialAnonUser() {
        if Auth.auth().currentUser == nil {
            Auth.auth().signInAnonymously { (result, error) in
                if let error = error {
                    debugPrint(error.localizedDescription)
                    Auth.auth().handleFireAuthError(error: error, vc: self)
                }
            }
        }
    }
    
    func setCategoriesListener() {
        listener = db.categories.addSnapshotListener({ (snap, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
                return
            }
            
            snap?.documentChanges.forEach({ (change) in
                let data = change.document.data()
                let category = Category.init(data: data)
                
                switch change.type {
                case .added:
                    self.onDocumentAdded(change: change, category: category)
                case .modified:
                    self.onDocumentModified(change: change, category: category)
                case .removed:
                    self.onDocumentRemoved(change: change)
                }
            })
        })
    }
    
    // MARK: - UI Setup functions
    func setupNavBar() {
        let shoppingCartButton = UIBarButtonItem(image: #imageLiteral(resourceName: "bar_button_cart"), style: .plain, target: self, action: #selector(shoppingCartPressed))
        let favoriteButton = UIBarButtonItem(image: #imageLiteral(resourceName: "bar_button_star"), style: .plain, target: self, action: #selector(favoritePressed))
        navigationItem.rightBarButtonItems = [shoppingCartButton, favoriteButton]
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(loginPressed))
        navigationController?.navigationBar.tintColor = AppColors.customWhite
        navigationController?.navigationBar.barTintColor = AppColors.customBlue
        title = "artable"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: AppColors.customWhite, NSAttributedString.Key.font: UIFont(name: "Futura", size: 26)]
    }
    
    func setupCollectionView() {
        collectionView.backgroundColor = .clear
        collectionView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: Identifiers.categoryCell)
    }
    
    func setupBaseUI() {
        view.backgroundColor = .white
        
        view.addSubview(backgroundImage)
        backgroundImage.anchor(top: view.topAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor)
        
        view.addSubview(activityIndicator)
        activityIndicator.anchor(centerY: view.centerYAnchor, centerX: view.centerXAnchor, height: 15, width: 15)
    }
    
    // MARK: - Selector functions
    @objc func loginPressed() {
        let nextScreen = UINavigationController(rootViewController: LoginVC())
        nextScreen.modalPresentationStyle = .fullScreen
        
        guard let user = Auth.auth().currentUser else { return }
        
        if user.isAnonymous {
            self.present(nextScreen, animated: true, completion: nil)
        } else {
            do {
                try Auth.auth().signOut()
                UserService.logoutUser()
                Auth.auth().signInAnonymously { (result, error) in
                    if let error = error {
                        debugPrint(error)
                        Auth.auth().handleFireAuthError(error: error, vc: self)
                    }
                    self.present(nextScreen, animated: true, completion: nil)
                }
            } catch {
                debugPrint(error)
            }
        }
    }
    
    @objc func shoppingCartPressed() {
        
    }
    
    @objc func favoritePressed() {
        
    }
}

// MARK: - CollectionView delegate methods
extension HomeVC {
    func onDocumentAdded(change: DocumentChange, category: Category) {
        let newIndex = Int(change.newIndex)
        categories.insert(category, at: newIndex)
        collectionView.insertItems(at: [IndexPath(item: newIndex, section: 0)])
    }
    
    func onDocumentModified(change: DocumentChange, category: Category) {
        if change.newIndex == change.oldIndex {
            let index = Int(change.newIndex)
            categories[index] = category
            collectionView.reloadItems(at: [IndexPath(item: index, section: 0)])
        } else {
            let oldIndex = Int(change.oldIndex)
            let newIndex = Int(change.newIndex)
            categories.remove(at: oldIndex)
            categories.insert(category, at: newIndex)
            collectionView.moveItem(at: IndexPath(item: oldIndex, section: 0), to: IndexPath(item: newIndex, section: 0))
        }
    }
    
    func onDocumentRemoved(change: DocumentChange) {
        let oldIndex = Int(change.oldIndex)
        categories.remove(at: oldIndex)
        collectionView.deleteItems(at: [IndexPath(item: oldIndex, section: 0)])
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.categoryCell, for: indexPath) as? CategoryCell {
            cell.configureCell(category: categories[indexPath.item])
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCategory = categories[indexPath.item]
        let screenToGoTo = ProductVC()
        screenToGoTo.selectedCategory = self.selectedCategory
        navigationController?.pushViewController(screenToGoTo, animated: true)
    }
}

extension HomeVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 20, bottom: 15, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        let cellWidth = (width - 65) / 2
        let cellHeight = cellWidth * 1.65
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
}




















//   func fetchDocument() {
//        let docRef = db.collection("categories").document("b4jKhZtj4zVRsjIAW8lN")
//        docRef.addSnapshotListener { (snap, error) in
//            self.categories.removeAll()
//            guard let data = snap?.data() else { return }
//            let newCategory = Category.init(data: data)
//            self.categories.append(newCategory)
//            self.collectionView.reloadData()
//        }
////
////        docRef.getDocument { (snap, error) in
////            guard let data = snap?.data() else { return }
////            let newCategory = Category.init(data: data)
////            self.categories.append(newCategory)
////            self.collectionView.reloadData()
////        }
//    }
//
//    func fetchCollection() {
//        let collectionRef = db.collection("categories")
//
//        listener = collectionRef.addSnapshotListener { (snap, error) in
//            guard let documents = snap?.documents else  { return }
//
//            print(snap?.documentChanges.count)
//
//            self.categories.removeAll()
//            for document in documents {
//                let data = document.data()
//                let newCategory = Category.init(data: data)
//                self.categories.append(newCategory)
//            }
//            self.collectionView.reloadData()
//        }
//
////        collectionRef.getDocuments { (snap, error) in
////            guard let documents = snap?.documents else  { return }
////            for document in documents {
////                let data = document.data()
////                let newCategory = Category.init(data: data)
////                self.categories.append(newCategory)
////            }
////            self.collectionView.reloadData()
////        }
//    }
