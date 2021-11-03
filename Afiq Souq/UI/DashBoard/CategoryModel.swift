//
//  CategoryModel.swift
//  Afiq Souq
//
//  Created by GAMEKILLER on 4/16/21.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let category = try Category(json)
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let category = try Category(json)

import Foundation

// MARK: - Category
class CategoryModel : Codable , Identifiable {
    let id: Int?
    let name, slug: String?
    let parent: Int?
    let categoryDescription, display: String?
    let image: CategoryImage?

    init(id: Int?, name: String?, slug: String?, parent: Int?, categoryDescription: String?, display: String?, image: CategoryImage?) {
        self.id = id
        self.name = name
        self.slug = slug
        self.parent = parent
        self.categoryDescription = categoryDescription
        self.display = display
        self.image = image
    }
}

// MARK: - Image
class CategoryImage : Codable {
    let id: Int?
    let dateCreated, dateCreatedGmt, dateModified, dateModifiedGmt: String?
    let src: String?
    let name: String?

    init(id: Int?, dateCreated: String?, dateCreatedGmt: String?, dateModified: String?, dateModifiedGmt: String?, src: String?, name: String?) {
        self.id = id
        self.dateCreated = dateCreated
        self.dateCreatedGmt = dateCreatedGmt
        self.dateModified = dateModified
        self.dateModifiedGmt = dateModifiedGmt
        self.src = src
        self.name = name
    }
}
