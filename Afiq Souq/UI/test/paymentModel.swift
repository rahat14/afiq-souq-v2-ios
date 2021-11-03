//
//  paymentModel.swift
//  Afiq Souq
//
//  Created by GAMEKILLER on 5/10/21.
//
import Foundation


class paymnetMODEL: Codable {
    let method, total: Int
    let isPaid : Bool  ;
    

    enum CodingKeys: String, CodingKey {
        case method
        case total
        case isPaid
    }

    init(method: Int, total: Int , isPaid : Bool) {
        self.method = method
        self.total = total
        self.isPaid = isPaid
    }
}
