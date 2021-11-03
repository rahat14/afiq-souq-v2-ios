//
//  CreateOrderModel.swift
//  Afiq Souq
//
//  Created by GAMEKILLER on 4/27/21.
//

import Foundation
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let createOrderModel = try? newJSONDecoder().decode(CreateOrderModel.self, from: jsonData)


// MARK: - CreateOrderModel
class CreateOrderModel: Codable {
    var customerID, status, paymentMethod, paymentMethodTitle: String?
    var setPaid: Bool?
    var billing, shipping: Ing?
    var lineItems: [pItem]?
    var couponLines: [CouponLine]?
    var shippingLines : [ShippingLine]?
    
    enum CodingKeys: String, CodingKey {
        case customerID = "customer_id"
        case status
        case paymentMethod = "payment_method"
        case paymentMethodTitle = "payment_method_title"
        case setPaid = "set_paid"
        case billing, shipping
        case lineItems = "line_items"
        case couponLines = "coupon_lines"
        case shippingLines = "shipping_lines"
    }

    init(customerID: String?, status: String?, paymentMethod: String?, paymentMethodTitle: String?, setPaid: Bool?, billing: Ing?, shipping: Ing?, lineItems: [pItem]? ,couponLines: [CouponLine]? , shippingLines : [ShippingLine]?) {
        self.customerID = customerID
        self.status = status
        self.paymentMethod = paymentMethod
        self.paymentMethodTitle = paymentMethodTitle
        self.setPaid = setPaid
        self.billing = billing
        self.shipping = shipping
        self.lineItems = lineItems
        self.couponLines = couponLines
        self.shippingLines = shippingLines
        
    }
    
  
}

// MARK: - LineItem
class pItem: Codable {
    var productID, quantity, variationID: Int?

    enum CodingKeys: String, CodingKey {
        case productID = "product_id"
        case quantity
        case variationID = "variation_id"
    }

    init(productID: Int?, quantity: Int?, variationID: Int?) {
        self.productID = productID
        self.quantity = quantity
        self.variationID = variationID
    }
}


class CouponLine: Codable {
    var code: String?

    init(code: String?) {
        self.code = code
    }
}



// MARK: - ShippingLine
class ShippingLine: Codable {
    var methodID, methodTitle, total: String?

    enum CodingKeys: String, CodingKey {
        case methodID = "method_id"
        case methodTitle = "method_title"
        case total
    }

    init(methodID: String?, methodTitle: String?, total: String?) {
        self.methodID = methodID
        self.methodTitle = methodTitle
        self.total = total
    }
}

