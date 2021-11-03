//
//  Api.swift
//  Afiq Souq
//
//  Created by GAMEKILLER on 3/5/21.
//

import Foundation
import Combine

protocol AllApiFetchable {
    
    func userLogin(
        forUsername username: String ,
        forPassword password: String
        
    ) -> AnyPublisher<LoginResponse, ApiError>
    
    
}

class DataFetcher {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
}

//MARK : Alll API
extension DataFetcher: AllApiFetchable {
    // userLogin
    func userLogin(
        forUsername username: String ,
        forPassword password: String
    ) -> AnyPublisher<LoginResponse, ApiError> {
        return forecast(with: makeLoginComponents(withUsername: username, withPassword: password))
    }
    
    
    private func forecast<T>(
        with urlReq: URLRequest
    ) -> AnyPublisher<T, ApiError> where T: Decodable {
        guard urlReq.url != nil else {
            let error = ApiError.network(description: "Couldn't create URL")
            return Fail(error: error).eraseToAnyPublisher()
        }
        return session.dataTaskPublisher(for: urlReq)
            .mapError { error in
                .network(description: error.localizedDescription)
            }
            .flatMap(maxPublishers: .max(1)) { pair in
                decode(pair.data)
            }
            .eraseToAnyPublisher()
    }
    
    
    
    
}

// MARK: - AFiq Souq API
private extension DataFetcher {
    struct Api {
        static let scheme = "https"
        static let host = "https://afiqsouq.com"
        static let path = "/api/user/generate_auth_cookie"
        static let key_user = "ck_174c19562ef4a473934f3cec2eeeae1900662d2e"
        static let key_pass = "cs_799bcbd98605696b4a71eca9703f308fa5cd0dca"
        
    }
    
    func makeLoginComponents(
        withUsername username: String ,
        withPassword password: String
    ) -> URLRequest {
        var components = URLComponents()
        components.scheme = Api.scheme
        components.host = Api.host
        components.path = Api.path
        
     
//
//        components.queryItems = [
//            URLQueryItem(name: "username", value: username),
//            URLQueryItem(name: "password", value: password)
//
//        ]
        
        var req = URLRequest(url: (components.url)!)
    
       // req.setValue("AUTH", forHTTPHeaderField: "AUTH")
            
        req.httpMethod = "POST"
        let body = "username=\(username)&password=\(password)"
        req.httpBody = body.data(using: .utf8)
        
        
        // adding headers
        
        let basicCred = Api.key_user + ":" + Api.key_pass.data(using: .utf8)!.base64EncodedString()
        let headers = [
            "Authorization": "Basic \(basicCred)",
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        
        req.allHTTPHeaderFields = headers
        req.timeoutInterval = 1000
        
        print(req.url ?? "default link")
        
        print(req.debugDescription)
        return req
    }
    
}
