//
//  LoginResponse.swift
//  Afiq Souq
//
//  Created by GAMEKILLER on 3/5/21.
//

import Foundation

// MARK: - LoginResponse
struct LoginResponse: Codable {
    let status : String?
    let  cookie, cookieAdmin, cookieName: String
    let user: User

    enum CodingKeys: String, CodingKey {
        case status, cookie
        case cookieAdmin = "cookie_admin"
        case cookieName = "cookie_name"
        case user
    }
}

// MARK: - User
struct User: Codable {
    let id: Int
    let username, nicename, email, url: String
    let registered, displayname, firstname, lastname: String
    let nickname, userDescription: String
    let capabilities: Capabilities
    let avatar: String?

    enum CodingKeys: String, CodingKey {
        case id, username, nicename, email, url, registered, displayname, firstname, lastname, nickname
        case userDescription = "description"
        case capabilities, avatar
    }
}

// MARK: - Capabilities
struct Capabilities: Codable {
    let customer: Bool
}


   

