// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let productItem = try ProductItem(json)

import Foundation

// MARK: - ProductItem
class ProductItem : Codable {
    let id: Int?
    let name, slug: String?
    let permalink: String?
    let dateCreated, dateCreatedGmt, dateModified, dateModifiedGmt: String?
    let type, status: String?
    let featured: Bool?
    let catalogVisibility, productItemDescription, shortDescription, sku: String?
    let price, regularPrice, salePrice: String?
    let onSale, purchasable: Bool?
    let totalSales: Int?
    let shippingRequired, shippingTaxable: Bool?
    let shippingClass: String?
    let shippingClassID: Int?
    let reviewsAllowed: Bool?
    let averageRating: String?
    let ratingCount, parentID: Int?
    let images: [Product_Image]?
    let stockStatus: String?

    init(id: Int?, name: String?, slug: String?, permalink: String?, dateCreated: String?, dateCreatedGmt: String?, dateModified: String?, dateModifiedGmt: String?, type: String?, status: String?, featured: Bool?, catalogVisibility: String?, productItemDescription: String?, shortDescription: String?, sku: String?, price: String?, regularPrice: String?, salePrice: String?, onSale: Bool?, purchasable: Bool?, totalSales: Int?, shippingRequired: Bool?, shippingTaxable: Bool?, shippingClass: String?, shippingClassID: Int?, reviewsAllowed: Bool?, averageRating: String?, ratingCount: Int?, parentID: Int?, images: [Product_Image]?, stockStatus: String?) {
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
        self.productItemDescription = productItemDescription
        self.shortDescription = shortDescription
        self.sku = sku
        self.price = price
        self.regularPrice = regularPrice
        self.salePrice = salePrice
        self.onSale = onSale
        self.purchasable = purchasable
        self.totalSales = totalSales
        self.shippingRequired = shippingRequired
        self.shippingTaxable = shippingTaxable
        self.shippingClass = shippingClass
        self.shippingClassID = shippingClassID
        self.reviewsAllowed = reviewsAllowed
        self.averageRating = averageRating
        self.ratingCount = ratingCount
        self.parentID = parentID
        self.images = images
        self.stockStatus = stockStatus
    }
}

// MARK: - Image
class Product_Image : Codable {
    let id: Int?
    let dateCreated, dateCreatedGmt, dateModified, dateModifiedGmt: String?
    let src: String?
    let name, alt: String?

    init(id: Int?, dateCreated: String?, dateCreatedGmt: String?, dateModified: String?, dateModifiedGmt: String?, src: String?, name: String?, alt: String?) {
        self.id = id
        self.dateCreated = dateCreated
        self.dateCreatedGmt = dateCreatedGmt
        self.dateModified = dateModified
        self.dateModifiedGmt = dateModifiedGmt
        self.src = src
        self.name = name
        self.alt = alt
    }
}
