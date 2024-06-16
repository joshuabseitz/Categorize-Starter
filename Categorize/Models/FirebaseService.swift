//
//  FirebaseService.swift
//  Categorize
//
//  Created by Joshua Seitz on 6/16/24.
//

import Foundation
import Foundation
import FirebaseAuth
import FirebaseFirestore

class FirebaseService {
    static let shared = FirebaseService()
    private let db = Firestore.firestore()

    private init() {}

    func fetchUserData(completion: @escaping (Result<User, Error>) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        db.collection("users").document(uid).getDocument { (document, error) in
            if let document = document, document.exists {
                do {
                    let user = try document.data(as: User.self)
                    completion(.success(user))
                } catch {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(error!))
            }
        }
    }

//    func saveUserData(_ user: User, completion: @escaping (Result<Void, Error>) -> Void) {
//        guard let uid = Auth.auth().currentUser?.uid else { return }
//
//        do {
//            try db.collection("users").document(uid).setData(from: user)
//            completion(.success(()))
//        } catch {
//            completion(.failure(error))
//        }
//    }

//    func fetchExpenses(completion: @escaping (Result<[Expense], Error>) -> Void) {
//        guard let uid = Auth.auth().currentUser?.uid else { return }
//
//        db.collection("users").document(uid).collection("expenses").getDocuments { (querySnapshot, error) in
//            if let querySnapshot = querySnapshot {
//                let expenses = querySnapshot.documents.compactMap { document in
//                    try? document.data(as: Expense.self)
//                }
//                completion(.success(expenses))
//            } else {
//                completion(.failure(error!))
//            }
//        }
//    }

//    func saveExpense(_ expense: Expense, completion: @escaping (Result<Void, Error>) -> Void) {
//        guard let uid = Auth.auth().currentUser?.uid else { return }
//
//        do {
//            try db.collection("users").document(uid).collection("expenses").addDocument(from: expense)
//            completion(.success(()))
//        } catch {
//            completion(.failure(error))
//        }
//    }
}
