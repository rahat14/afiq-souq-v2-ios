//
//  reviewModel.swift
//  Afiq Souq
//
//  Created by GAMEKILLER on 4/24/21.
//

import Foundation


// MARK: - ReviewModel
class ReviewModel : Codable  {
    var id, productID: Int?
    var review, reviewer, reviewerEmail: String?
    var rating: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case productID = "product_id"
        case review, reviewer
        case reviewerEmail = "reviewer_email"
        case rating
    }

    init(id: Int?, productID: Int?, review: String?, reviewer: String?, reviewerEmail: String?, rating: Int?) {
        self.id = id
        self.productID = productID
        self.review = review
        self.reviewer = reviewer
        self.reviewerEmail = reviewerEmail
        self.rating = rating
    }
}
