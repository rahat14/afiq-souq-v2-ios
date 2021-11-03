//
//  OldOrderModel.swift
//  Afiq Souq
//
//  Created by GAMEKILLER on 4/19/21.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let oldCartModel = try OldCartModel(json)

import Foundation

// MARK: - OldCartModel
class OldCartModel :  Codable {
    var id, parentID: Int?
    var status, currency, version: String?
    var pricesIncludeTax: Bool?
    var discountTotal, discountTax, shippingTotal, shippingTax: String?
    var cartTax, total, totalTax: String?
    var customerID: Int?
    var  dateCreated : String?
    var orderKey: String?
    var billing, shipping: Ing?
    var paymentMethod, paymentMethodTitle, transactionID, customerNote: String?
    var cartHash, number: String?
    var lineItems: [LineItem]
    var couponLines: [CouponLines]?

    enum CodingKeys: String, CodingKey {
        case id
        case parentID = "parent_id"
        case status, currency, version
        case pricesIncludeTax = "prices_include_tax"
        case discountTotal = "discount_total"
        case discountTax = "discount_tax"
        case shippingTotal = "shipping_total"
        case shippingTax = "shipping_tax"
        case cartTax = "cart_tax"
        case total
        case totalTax = "total_tax"
        case customerID = "customer_id"
        case orderKey = "order_key"
        case billing, shipping
        case paymentMethod = "payment_method"
        case paymentMethodTitle = "payment_method_title"
        case transactionID = "transaction_id"
        case customerNote = "customer_note"
        case cartHash = "cart_hash"
        case number
        case lineItems = "line_items"
        case couponLines = "coupon_lines"
        case dateCreated = "date_created"
    }

    init(id: Int?, parentID: Int?, status: String?, currency: String?, version: String?, pricesIncludeTax: Bool?, discountTotal: String?, discountTax: String?, shippingTotal: String?, shippingTax: String?, cartTax: String?, total: String?, totalTax: String?, customerID: Int?, orderKey: String?, billing: Ing?, shipping: Ing?, paymentMethod: String?, paymentMethodTitle: String?, transactionID: String?, customerNote: String?, cartHash: String?, number: String?, lineItems: [LineItem], couponLines: [CouponLines]? , dateCreated : String?) {
        self.id = id
        self.parentID = parentID
        self.status = status
        self.currency = currency
        self.version = version
        self.pricesIncludeTax = pricesIncludeTax
        self.discountTotal = discountTotal
        self.discountTax = discountTax
        self.shippingTotal = shippingTotal
        self.shippingTax = shippingTax
        self.cartTax = cartTax
        self.total = total
        self.totalTax = totalTax
        self.customerID = customerID
        self.orderKey = orderKey
        self.billing = billing
        self.shipping = shipping
        self.paymentMethod = paymentMethod
        self.paymentMethodTitle = paymentMethodTitle
        self.transactionID = transactionID
        self.customerNote = customerNote
        self.cartHash = cartHash
        self.number = number
        self.lineItems = lineItems
        self.couponLines = couponLines
        self.dateCreated = dateCreated
    }
}



// MARK: - CouponLine
class CouponLines: Codable {
    var id: Int?
    var code, discount, discountTax: String?

    enum CodingKeys: String, CodingKey {
        case id, code, discount
        case discountTax = "discount_tax"
    }

    init(id: Int?, code: String?, discount: String?, discountTax: String?) {
        self.id = id
        self.code = code
        self.discount = discount
        self.discountTax = discountTax
    }
}

// MARK: - LineItem
class LineItem: Codable {
    var id: Int?
    var name: String?
    var productID, variationID, quantity: Int?
    var taxClass, subtotal, subtotalTax, total: String?
    var totalTax, sku: String?
    var price: Double?

    enum CodingKeys: String, CodingKey {
        case id, name
        case productID = "product_id"
        case variationID = "variation_id"
        case quantity
        case taxClass = "tax_class"
        case subtotal
        case subtotalTax = "subtotal_tax"
        case total
        case totalTax = "total_tax"
        case sku, price
    }

    init(id: Int?, name: String?, productID: Int?, variationID: Int?, quantity: Int?, taxClass: String?, subtotal: String?, subtotalTax: String?, total: String?, totalTax: String?, sku: String?, price: Double?) {
        self.id = id
        self.name = name
        self.productID = productID
        self.variationID = variationID
        self.quantity = quantity
        self.taxClass = taxClass
        self.subtotal = subtotal
        self.subtotalTax = subtotalTax
        self.total = total
        self.totalTax = totalTax
        self.sku = sku
        self.price = price
    }
}


