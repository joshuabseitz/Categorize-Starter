//
//  Transaction.swift
//  Categorize
//
//  Created by Joshua Seitz on 6/16/24.
//

import Foundation
import FirebaseFirestoreSwift

struct Transaction: Identifiable, Codable {
    @DocumentID var id: String?
    var name: String
    var amount: Double
    var type: TransactionType
    var date: Date
    var notes: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case amount
        case type
        case date
        case notes
    }

    init(name: String, amount: Double, type: TransactionType, date: Date, notes: String? = nil) {
        self.name = name
        self.amount = amount
        self.type = type
        self.date = date
        self.notes = notes
    }
}

enum TransactionType: String, Codable {
    case expense
    case deposit
    case transfer
    case other
}
