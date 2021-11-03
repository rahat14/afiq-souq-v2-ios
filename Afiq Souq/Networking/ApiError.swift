//
//  ApiError.swift
//  Afiq Souq
//
//  Created by GAMEKILLER on 3/5/21.
//

import Foundation

enum ApiError: Error {
  case parsing(description: String)
  case network(description: String)
    
}
enum GFError: String, Error {
    
    case invalidUsername = "This username created an invalid request. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection"
    case invalidResponse = "Invalid response from the server. Please try again"
    case invalidData = "The data recieved from the server was invalid. Please try again"
    case unableToFavorite = "There was an error favoriting this user. Please try again."
    case alreadyInFavorites = "You've already favorited this user. You must REALLY like them."
    case invalideUrl  = "URL INVALID."
    
}
