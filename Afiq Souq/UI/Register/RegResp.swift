//
//  File.swift
//  Afiq Souq
//
//  Created by GAMEKILLER on 4/5/21.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let regRespSend = try RegRespSend(json)

import Foundation

// MARK: - RegRespSend
class RegRespSend : Codable {
    let shipping, billing: Inge
    let role, lastName, email, dateModified: String
    let username, firstName, password: String

    init(shipping: Inge, billing: Inge, role: String, lastName: String, email: String, dateModified: String, username: String, firstName: String, password: String) {
        self.shipping = shipping
        self.billing = billing
        self.role = role
        self.lastName = lastName
        self.email = email
        self.dateModified = dateModified
        self.username = username
        self.firstName = firstName
        self.password = password
    }
}

// MARK: - Ing
class Inge :Codable {
    let phone, city, country, address1: String
    let lastName, company, postcode, email: String
    let address2, state, firstName: String

    init(phone: String, city: String, country: String, address1: String, lastName: String, company: String, postcode: String, email: String, address2: String, state: String, firstName: String) {
        self.phone = phone
        self.city = city
        self.country = country
        self.address1 = address1
        self.lastName = lastName
        self.company = company
        self.postcode = postcode
        self.email = email
        self.address2 = address2
        self.state = state
        self.firstName = firstName
    }
}

