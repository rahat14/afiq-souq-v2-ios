//
//  recivieResp.swift
//  Afiq Souq
//
//  Created by GAMEKILLER on 4/21/21.
//

import Foundation
class ResetPassRecivied : Codable {
    let id: Int?
    let dateCreated, dateCreatedGmt, dateModified, dateModifiedGmt: String?
    let email, firstName, lastName, role: String?
    let username: String?

    init(id: Int?, dateCreated: String?, dateCreatedGmt: String?, dateModified: String?, dateModifiedGmt: String?, email: String?, firstName: String?, lastName: String?, role: String?, username: String?) {
        self.id = id
        self.dateCreated = dateCreated
        self.dateCreatedGmt = dateCreatedGmt
        self.dateModified = dateModified
        self.dateModifiedGmt = dateModifiedGmt
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.role = role
        self.username = username
    }
}
