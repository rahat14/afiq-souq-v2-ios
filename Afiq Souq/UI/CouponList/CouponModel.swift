//
//  CouponModel.swift
//  Afiq Souq
//
//  Created by GAMEKILLER on 4/19/21.
//

import Foundation
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let couponModel = try CouponModel(json)

import Foundation

// MARK: - CouponModel
class CouponModel : Codable {
    let id: Int?
    let code, amount, dateCreated, dateCreatedGmt: String?
    let dateModified, dateModifiedGmt, discountType, couponModelDescription: String?
    let dateExpires, dateExpiresGmt: String?
    let usageCount: Int?
    let individualUse: Bool?
    let usageLimit, usageLimitPerUser: Int?
    let freeShipping, excludeSaleItems: Bool?
    let minimumAmount, maximumAmount: String?
    let usedBy: [String]?

    init(id: Int?, code: String?, amount: String?, dateCreated: String?, dateCreatedGmt: String?, dateModified: String?, dateModifiedGmt: String?, discountType: String?, couponModelDescription: String?, dateExpires: String?, dateExpiresGmt: String?, usageCount: Int?, individualUse: Bool?, usageLimit: Int?, usageLimitPerUser: Int?, freeShipping: Bool?, excludeSaleItems: Bool?, minimumAmount: String?, maximumAmount: String?, usedBy: [String]?) {
        self.id = id
        self.code = code
        self.amount = amount
        self.dateCreated = dateCreated
        self.dateCreatedGmt = dateCreatedGmt
        self.dateModified = dateModified
        self.dateModifiedGmt = dateModifiedGmt
        self.discountType = discountType
        self.couponModelDescription = couponModelDescription
        self.dateExpires = dateExpires
        self.dateExpiresGmt = dateExpiresGmt
        self.usageCount = usageCount
        self.individualUse = individualUse
        self.usageLimit = usageLimit
        self.usageLimitPerUser = usageLimitPerUser
        self.freeShipping = freeShipping
        self.excludeSaleItems = excludeSaleItems
        self.minimumAmount = minimumAmount
        self.maximumAmount = maximumAmount
        self.usedBy = usedBy
    }
}
