//
//  User.swift
//  Categorize
//
//  Created by Joshua Seitz on 6/16/24.
//

import Foundation
import FirebaseFirestoreSwift
import FirebaseAuth

struct User: Identifiable, Codable {
    @DocumentID var id: String?
    var displayName: String?
    var email: String?
    var createdAt: Date?
    var updatedAt: Date?
    
    enum CodingKeys: String, CodingKey {
        case id
        case displayName
        case email
        case createdAt
        case updatedAt
    }

    init(displayName: String?, email: String?) {
        self.displayName = displayName
        self.email = email
        self.createdAt = Date()
        self.updatedAt = Date()
    }

    mutating func update(displayName: String?, email: String?) {
        self.displayName = displayName
        self.email = email
        self.updatedAt = Date()
    }

    init(firebaseUser: FirebaseAuth.User) {
        self.id = firebaseUser.uid
        self.displayName = firebaseUser.displayName
        self.email = firebaseUser.email
        self.createdAt = Date()  // You can update this with actual creation date if available
        self.updatedAt = Date()
    }
}
