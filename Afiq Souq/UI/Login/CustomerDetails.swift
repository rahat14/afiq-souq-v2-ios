//
//  CustomerDetails.swift
//  Afiq Souq
//
//  Created by GAMEKILLER on 3/12/21.
//


//   let customerDetailsResponse = try? newJSONDecoder().decode(CustomerDetailsResponse.self, from: jsonData)

import Foundation

// MARK: - CustomerDetailsResponse
struct CustomerDetailsResponse: Codable {
    let id: Int
    let  dateCreatedGmt, dateModified, dateModifiedGmt: String
    let email, firstName, lastName, role: String
    let username: String
    var billing, shipping: Ing

    enum CodingKeys: String, CodingKey {
        case id
        case dateCreatedGmt = "date_created_gmt"
        case dateModified = "date_modified"
        case dateModifiedGmt = "date_modified_gmt"
        case email
        case firstName = "first_name"
        case lastName = "last_name"
        case role, username, billing, shipping
    }
}

// MARK: - Ing
struct Ing: Codable {
    var firstName, lastName, company, address1: String
    var address2, city, state, postcode: String
    let country: String
    let email, phone: String?

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case company
        case address1 = "address_1"
        case address2 = "address_2"
        case city, state, postcode, country, email, phone
    }
}
