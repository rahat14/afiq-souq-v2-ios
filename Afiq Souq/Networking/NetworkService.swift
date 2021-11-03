//
//  NetworkService.swift
//  Afiq Souq
//
//  Created by GAMEKILLER on 3/6/21.
//

import Foundation

class NetworkApiService {
    
    static let scheme = "https"
    
    static let key_user = "ck_174c19562ef4a473934f3cec2eeeae1900662d2e"
    static let key_pass = "cs_799bcbd98605696b4a71eca9703f308fa5cd0dca"
    
    
    enum APIFailureCondition: Error {
        case InvalidServer
        case DataError
        
        
    }
}

func getCommonUrlRequest(url: URL) -> URLRequest {
    //Request type
    
    //Setting common headers
 
    let basicCred = Paths.key_user + ":" + Paths.key_pass.data(using: .utf8)!.base64EncodedString()
    let headers = [
        "Authorization": "Basic \(basicCred)",
        "Content-Type": "application/x-www-form-urlencoded"
    ]
    
    var   request = URLRequest(url: url)
    
    request.allHTTPHeaderFields = headers
    request.timeoutInterval = 1000
    
    return request
}


