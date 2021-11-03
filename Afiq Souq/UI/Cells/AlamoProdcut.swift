//
//  AlamoProdcut.swift
//  Afiq Souq
//
//  Created by GAMEKILLER on 4/23/21.
//

import Foundation
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let alamoProduct = try AlamoProduct(json)


// MARK: - Product
class Productss: Decodable {
    var id: Int
    var name, slug: String
    var permalink: String
    var dateCreated, dateCreatedGmt, dateModified, dateModifiedGmt: String
    var type, status: String
    var featured: Bool
    var catalogVisibility, productDescription, shortDescription, sku: String
    var price, regularPrice, salePrice: String
    var onSale, purchasable: Bool
    var totalSales: Int
    var virtual, downloadable: Bool
    var downloadLimit, downloadExpiry: Int
    var externalURL, buttonText, taxStatus, taxClass: String
    var manageStock: Bool
    var stockQuantity, backorders: String
    var backordersAllowed, backordered, soldIndividually, shippingRequired: Bool
    var shippingTaxable: Bool
    var shippingClass: String
    var shippingClassID: Int
    var reviewsAllowed: Bool
    var averageRating: String
    var ratingCount: Int
    var images: [PImage]
    var priceHTML, stockStatus: String

    enum CodingKeys: String, CodingKey {
        case id, name, slug, permalink
        case dateCreated = "date_created"
        case dateCreatedGmt = "date_created_gmt"
        case dateModified = "date_modified"
        case dateModifiedGmt = "date_modified_gmt"
        case type, status, featured
        case catalogVisibility = "catalog_visibility"
        case productDescription = "description"
        case shortDescription = "short_description"
        case sku, price
        case regularPrice = "regular_price"
        case salePrice = "sale_price"
        case onSale = "on_sale"
        case purchasable
        case totalSales = "total_sales"
        case virtual, downloadable
        case downloadLimit = "download_limit"
        case downloadExpiry = "download_expiry"
        case externalURL = "external_url"
        case buttonText = "button_text"
        case taxStatus = "tax_status"
        case taxClass = "tax_class"
        case manageStock = "manage_stock"
        case stockQuantity = "stock_quantity"
        case backorders = "backorders"
        case backordersAllowed = "backorders_allowed"
        case backordered = "backordered"
        case soldIndividually = "sold_individually"
        case shippingRequired = "shipping_required"
        case shippingTaxable = "shipping_taxable"
        case shippingClass = "shipping_class"
        case shippingClassID = "shipping_class_id"
        case reviewsAllowed = "reviews_allowed"
        case averageRating = "average_rating"
        case ratingCount = "rating_count"
        case images = "images"
        case priceHTML = "price_html"
        case stockStatus = "stock_status"
    }

    init(id: Int, name: String, slug: String, permalink: String, dateCreated: String, dateCreatedGmt: String, dateModified: String, dateModifiedGmt: String, type: String, status: String, featured: Bool, catalogVisibility: String, productDescription: String, shortDescription: String, sku: String, price: String, regularPrice: String, salePrice: String, onSale: Bool, purchasable: Bool, totalSales: Int, virtual: Bool, downloadable: Bool, downloadLimit: Int, downloadExpiry: Int, externalURL: String, buttonText: String, taxStatus: String, taxClass: String, manageStock: Bool, stockQuantity: String, backorders: String, backordersAllowed: Bool, backordered: Bool, soldIndividually: Bool, shippingRequired: Bool, shippingTaxable: Bool, shippingClass: String, shippingClassID: Int, reviewsAllowed: Bool, averageRating: String, ratingCount: Int, images: [PImage], priceHTML: String, stockStatus: String) {
        self.id = id
        self.name = name
        self.slug = slug
        self.permalink = permalink
        self.dateCreated = dateCreated
        self.dateCreatedGmt = dateCreatedGmt
        self.dateModified = dateModified
        self.dateModifiedGmt = dateModifiedGmt
        self.type = type
        self.status = status
        self.featured = featured
        self.catalogVisibility = catalogVisibility
        self.productDescription = productDescription
        self.shortDescription = shortDescription
        self.sku = sku
        self.price = price
        self.regularPrice = regularPrice
        self.salePrice = salePrice
        self.onSale = onSale
        self.purchasable = purchasable
        self.totalSales = totalSales
        self.virtual = virtual
        self.downloadable = downloadable
        self.downloadLimit = downloadLimit
        self.downloadExpiry = downloadExpiry
        self.externalURL = externalURL
        self.buttonText = buttonText
        self.taxStatus = taxStatus
        self.taxClass = taxClass
        self.manageStock = manageStock
        self.stockQuantity = stockQuantity
        self.backorders = backorders
        self.backordersAllowed = backordersAllowed
        self.backordered = backordered
        self.soldIndividually = soldIndividually
        self.shippingRequired = shippingRequired
        self.shippingTaxable = shippingTaxable
        self.shippingClass = shippingClass
        self.shippingClassID = shippingClassID
        self.reviewsAllowed = reviewsAllowed
        self.averageRating = averageRating
        self.ratingCount = ratingCount
        self.images = images
        self.priceHTML = priceHTML
        self.stockStatus = stockStatus
    }
    
 
}


class PImage: Decodable {
    var id: Int
    var src: String
    var name, alt: String

    enum CodingKeys: String, CodingKey {
        case id
        case src, name, alt
    }

    init(id: Int, src: String, name: String, alt: String) {
        self.id = id
        self.src = src
        self.name = name
        self.alt = alt
    }
}




