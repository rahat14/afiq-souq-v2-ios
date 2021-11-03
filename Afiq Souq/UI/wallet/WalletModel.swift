//
//  WalletModel.swift
//  Afiq Souq
//
//  Created by GAMEKILLER on 4/20/21.
//

import Foundation

// MARK: - WalletItem
class WalletItem : Codable {
    let transactionID, blogID, userID, type: String?
    let amount, balance, currency, details: String?
    let createdBy, deleted, date: String?

    init(transactionID: String?, blogID: String?, userID: String?, type: String?, amount: String?, balance: String?, currency: String?, details: String?, createdBy: String?, deleted: String?, date: String?) {
        self.transactionID = transactionID
        self.blogID = blogID
        self.userID = userID
        self.type = type
        self.amount = amount
        self.balance = balance
        self.currency = currency
        self.details = details
        self.createdBy = createdBy
        self.deleted = deleted
        self.date = date
    }
}
