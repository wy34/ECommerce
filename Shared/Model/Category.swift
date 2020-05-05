//
//  Category.swift
//  Artable
//
//  Created by William Yeung on 5/5/20.
//  Copyright © 2020 William Yeung. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct Category {
    var name: String
    var id: String
    var imageUrl: String
    var isActive: Bool = true
    var timeStamp: Timestamp
}
