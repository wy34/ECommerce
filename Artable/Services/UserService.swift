//
//  UserService.swift
//  Artable
//
//  Created by William Yeung on 5/11/20.
//  Copyright © 2020 William Yeung. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

let UserService = _UserService()

final class _UserService {
    var user = User()
    var favorites = [Product]()
    let auth = Auth.auth()
    let db = Firestore.firestore()
    var userListener: ListenerRegistration? = nil
    var favsListener: ListenerRegistration? = nil
    
    var isGuest: Bool {
        guard let authUser = auth.currentUser else { return true }
        
        if authUser.isAnonymous {
            return true
        } else {
            return false
        }
    }
    
    func getCurrentUser() {
        // checks that there is a current user
        guard let authUser = auth.currentUser else { return }
        // goes to that specific user's location on firestore using its id
        let userRef: DocumentReference = db.collection("users").document(authUser.uid)
        // add a listener at that specific document's location
        userListener = userRef.addSnapshotListener({ (snap, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
                return
            }
            
            guard let data = snap?.data() else { return }
            self.user = User.init(data: data)
            print(self.user)
        })
        
        let favsRef = userRef.collection("favorites")
        favsListener =  favsRef.addSnapshotListener({ (snap, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
                return
            }
            
            snap?.documents.forEach({ (document) in
                let favorite = Product.init(data: document.data())
                self.favorites.append(favorite)
            })
        })
    }
    
    func logoutUser() {
        userListener?.remove()
        userListener = nil
        favsListener?.remove()
        favsListener = nil
        user = User()
        favorites.removeAll()
    }
}
