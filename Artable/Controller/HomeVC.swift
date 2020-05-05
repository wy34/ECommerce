//
//  HomeVC.swift
//  Artable
//
//  Created by William Yeung on 4/29/20.
//  Copyright © 2020 William Yeung. All rights reserved.
//

import UIKit
import Firebase

private let reuseId = "cell"

class HomeVC: UICollectionViewController {
    // MARK: - Properties
    let backgroundImage: UIImageView = {
        let imageView = UIImageView().setUpBackground(withImage: #imageLiteral(resourceName: "bg_cat3"))
        imageView.alpha = 0.2
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
    
    func setupBaseUI() {
        view.backgroundColor = .white
        
        view.addSubview(backgroundImage)
        backgroundImage.anchor(top: view.topAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor)
        
        view.addSubview(activityIndicator)
        activityIndicator.anchor(centerY: view.centerYAnchor, centerX: view.centerXAnchor, height: 15, width: 15)
    }
    
    func setupCollectionView() {
        collectionView.backgroundColor = .clear
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseId)
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseId, for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
}

extension HomeVC: UICollectionViewDelegateFlowLayout {
    
}
