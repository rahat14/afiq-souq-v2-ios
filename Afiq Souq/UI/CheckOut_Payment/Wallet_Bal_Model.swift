//
//  Wallet_Bal_Model.swift
//  Afiq Souq
//
//  Created by GAMEKILLER on 4/28/21.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let walletResponse = try? newJSONDecoder().decode(WalletResponse.self, from: jsonData)

import Foundation

// MARK: - WalletResponse
class WalletResponse: Codable {
    var id: Int?
    var response: String?

    init(id: Int?, response: String?) {
        self.id = id
        self.response = response
    }
}
