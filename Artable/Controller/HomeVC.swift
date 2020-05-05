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
    
    let backgroundImage: UIImageView = {
        return UIImageView().setUpBackground(withImage: #imageLiteral(resourceName: "bg_cat3"), ofAlpha: 0.2)
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
        
        if Auth.auth().currentUser == nil {
            Auth.auth().signInAnonymously { (result, error) in
                if let error = error {
                    debugPrint(error.localizedDescription)
                    Auth.auth().handleFireAuthError(error: error, vc: self)
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let user = Auth.auth().currentUser, !user.isAnonymous {
            navigationItem.leftBarButtonItem?.title = "Logout"
        } else {
            navigationItem.leftBarButtonItem?.title = "Login"
        }
    }
    
    // MARK: - Helper functions
    func setupNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(loginPressed))
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
    
    // MARK: - Selectors
    @objc func loginPressed() {
        let nextScreen = UINavigationController(rootViewController: LoginVC())
        nextScreen.modalPresentationStyle = .fullScreen
        
        guard let user = Auth.auth().currentUser else { return }
        
        if user.isAnonymous {
            self.present(nextScreen, animated: true, completion: nil)
        } else {
            do {
                try Auth.auth().signOut()
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
}

    // MARK: - CollectionView delegate methods
extension HomeVC {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.categoryCell, for: indexPath) as? CategoryCell {
            cell.categoryLabel.backgroundColor = .green
            return cell
        }
        
        return UICollectionViewCell()
    }
}

extension HomeVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        let cellWidth = (width - 50) / 2
        let cellHeight = cellWidth * 1.5
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
