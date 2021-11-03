//
//  NetworkManager.swift
//  Afiq Souq
//
//  Created by GAMEKILLER on 3/12/21.
//

import Foundation
class NetworkManager {
    static let shared = NetworkManager() // singleton
    //let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    // typealias completionHandler = (Result<[Follower], GFError>) -> Void
    
    //    func getFollowers(for username: String, page: Int, completed: @escaping (Result<[Follower], GFError>) -> Void) {
    //        let endPoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"
    //
    //        guard let url = URL(string: endPoint) else {
    //            completed(Result.failure(.invalidUsername))
    //            return
    //        }
    //
    //        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
    //            if let _ = error {
    //                completed(Result.failure(.unableToComplete))
    //            }
    //
    //            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
    //                completed(Result.failure(.invalidResponse))
    //                return
    //            }
    //
    //            guard let data = data else {
    //                completed(Result.failure(.invalidData))
    //                return
    //            }
    //
    //            do {
    //                let decoder = JSONDecoder()
    //                decoder.keyDecodingStrategy = .convertFromSnakeCase // specifies the type of decoding
    //                let followers = try decoder.decode([Follower].self, from: data)
    //                completed(Result.success(followers))
    //            } catch {
    //                completed(Result.failure(.invalidData))
    //            }
    //
    //        }
    //        task.resume()
    //    }
    //
    
    func getHeaders() -> String  {
        let basicCred = Paths.key_user + ":" + Paths.key_pass.data(using: .utf8)!.base64EncodedString()
        _ = [
            "Authorization": "Basic \(basicCred)",
            "Content-Type": "application/json"
        ]
        let loginString = "\(Paths.key_user):\(Paths.key_pass)"
        guard let loginData = loginString.data(using: String.Encoding.utf8) else {
            return ""
        }
        let base64LoginString = loginData.base64EncodedString()
        
        return base64LoginString
    }
    
    func  RegisterUser(for userDetails : RegRespSend , completed: @escaping (Result<CustomerDetailsResponse, GFError>) -> Void) {
        
        
        let endPoint = Paths.host + Paths.apiPath +  Paths.REG_PATH
        
        
        
        guard let url = URL(string: endPoint) else {
            completed(Result.failure(.invalidUsername))
            return
        }
        print(url)
        
        var req = URLRequest(url: url)
        
        req.httpMethod = "POST"
        
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        req.setValue("Basic \(self.getHeaders())", forHTTPHeaderField: "Authorization")
        
        let jsonData = try! JSONEncoder().encode(userDetails)
        let jsonString = String(data: jsonData, encoding: .utf8)!
        //  let JsonData2 = try! JSONEncoder().encode(jsonString)
        //  print(jsonString)
        // insert json data to the request
        req.httpBody = jsonString.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: req) { (data, response, error) in
            if let _ = error {
                completed(Result.failure(.unableToComplete))
            }
            
            let res = response as? HTTPURLResponse
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 201 else {
                print(res?.statusCode ?? 00)
                completed(Result.failure(.invalidResponse))
                
                return
            }
            
            
            
            guard let data = data else {
                
                completed(Result.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                //decoder.keyDecodingStrategy = .convertFromSnakeCase // specifies the type of decoding
                decoder.dateDecodingStrategy = .iso8601
                let user = try decoder.decode(CustomerDetailsResponse.self, from: data)
                completed(Result.success(user))
            } catch  {
                
                completed(Result.failure(.invalidData))
            }
        }
        task.resume()
        
        
    }
    
    func getUserInfo(for userId: Int, completed: @escaping (Result<CustomerDetailsResponse, GFError>) -> Void) {
        let endPoint = Paths.host + Paths.apiPath + "/customers/" + "\(userId)"
        
        guard let url = URL(string: endPoint) else {
            completed(Result.failure(.invalidUsername))
            return
        }
        
        // create our own urlReq as for adder
        print(url)
        var req = URLRequest(url: url)
        
        req.setValue("Basic \(self.getHeaders())", forHTTPHeaderField: "Authorization")
        
        //print("HEADERS \n \(req.allHTTPHeaderFields)")
        let task = URLSession.shared.dataTask(with: req) { (data, response, error) in
            if let _ = error {
                completed(Result.failure(.unableToComplete))
            }
            
            let res = response as? HTTPURLResponse
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                
                print(res?.statusCode ?? 00)
                completed(Result.failure(.invalidResponse))
                
                return
            }
            
            
            
            guard let data = data else {
                
                completed(Result.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                //decoder.keyDecodingStrategy = .convertFromSnakeCase // specifies the type of decoding
                decoder.dateDecodingStrategy = .iso8601
                let user = try decoder.decode(CustomerDetailsResponse.self, from: data)
                completed(Result.success(user))
            } catch  {
                
                completed(Result.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    
    
    func getProductList(for page: Int , p_count: Int, completed: @escaping (Result<[Product], GFError>) -> Void) {
        let endPoint = Paths.host + Paths.apiPath + "/products" + "?page=" + String(page) + "&status=publish&per_page=" + String(p_count)
        guard let url = URL(string: endPoint) else {
            completed(Result.failure(.invalideUrl))
            return
        }
        
        // create our own urlReq as for adder
        print(url)
        var req = URLRequest(url: url)
        
        req.setValue("Basic \(self.getHeaders())", forHTTPHeaderField: "Authorization")
        let sessionCOnfig = URLSessionConfiguration.default
        sessionCOnfig.timeoutIntervalForRequest = 500
        sessionCOnfig.timeoutIntervalForResource = 500
        
        
        let sseesion = URLSession(configuration: sessionCOnfig)
        
        //print("HEADERS \n \(req.allHTTPHeaderFields)")
        let task = sseesion.dataTask(with: req) { (data, response, error) in
            if let _ = error {
                completed(Result.failure(.unableToComplete))
            }
            
            let res = response as? HTTPURLResponse
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                
                print(res?.statusCode ?? 00)
                completed(Result.failure(.invalidResponse))
                
                return
            }
            
            
            
            guard let data = data else {
                
                completed(Result.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase // specifies the type of decoding
                decoder.dateDecodingStrategy = .iso8601
                let products  : [Product] = try decoder.decode([Product].self, from: data)
                completed(Result.success(products))
            }
            catch let jsonError as NSError {
                print("JSON decode failed: \(jsonError.localizedDescription)")
                
                completed(Result.failure(.invalidData))
            }
            catch  {
                
                completed(Result.failure(.invalidData))
            }
            
        }
        task.resume()
    }
    
    
    func getCateogryList( for per_page : String , completed: @escaping (Result<[CategoryModel], GFError>) -> Void) {
        let endPoint = Paths.host + Paths.apiPath + "/products/categories?parent=0&per_page=" + per_page
        guard let url = URL(string: endPoint) else {
            completed(Result.failure(.invalideUrl))
            return
        }
        
        // create our own urlReq as for adder
        print(url)
        var req = URLRequest(url: url)
        
        req.setValue("Basic \(self.getHeaders())", forHTTPHeaderField: "Authorization")
        
        //print("HEADERS \n \(req.allHTTPHeaderFields)")
        let task = URLSession.shared.dataTask(with: req) { (data, response, error) in
            if let _ = error {
                completed(Result.failure(.unableToComplete))
            }
            
            let res = response as? HTTPURLResponse
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                
                print(res?.statusCode ?? 00)
                completed(Result.failure(.invalidResponse))
                
                return
            }
            
            
            
            guard let data = data else {
                
                completed(Result.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                //decoder.keyDecodingStrategy = .convertFromSnakeCase // specifies the type of decoding
                decoder.dateDecodingStrategy = .iso8601
                let categories   : [CategoryModel] = try decoder.decode([CategoryModel].self, from: data)
                completed(Result.success(categories))
            }
            catch let jsonError as NSError {
                print("JSON decode failed: \(jsonError.localizedDescription)")
                
                completed(Result.failure(.invalidData))
            }
            catch  {
                
                completed(Result.failure(.invalidData))
            }
            
        }
        task.resume()
    }
    
    
    
    
    func getComboOfferProductList(for page: Int, completed: @escaping (Result<[Product], GFError>) -> Void) {
        let endPoint = Paths.host + Paths.apiPath + "/products" + "?category=325&status=publish&per_page=10"
        guard let url = URL(string: endPoint) else {
            completed(Result.failure(.invalideUrl))
            return
        }
        
        // create our own urlReq as for adder
        print(url)
        var req = URLRequest(url: url)
        
        req.setValue("Basic \(self.getHeaders())", forHTTPHeaderField: "Authorization")
        let sessionCOnfig = URLSessionConfiguration.default
        sessionCOnfig.timeoutIntervalForRequest = 500
        sessionCOnfig.timeoutIntervalForResource = 500
        
        
        let sseesion = URLSession(configuration: sessionCOnfig)
        
        
        //print("HEADERS \n \(req.allHTTPHeaderFields)")
        let task = sseesion.dataTask(with: req) { (data, response, error) in
            if let _ = error {
                completed(Result.failure(.unableToComplete))
            }
            
            let res = response as? HTTPURLResponse
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                
                print(res?.statusCode ?? 00)
                completed(Result.failure(.invalidResponse))
                
                return
            }
            
            
            
            guard let data = data else {
                
                completed(Result.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase // specifies the type of decoding
                decoder.dateDecodingStrategy = .iso8601
                let products  : [Product] = try decoder.decode([Product].self, from: data)
                completed(Result.success(products))
            }
            catch let jsonError as NSError {
                print("JSON decode failed: \(jsonError.localizedDescription)")
                
                completed(Result.failure(.invalidData))
            }
            catch  {
                
                completed(Result.failure(.invalidData))
            }
            
        }
        task.resume()
    }
    
    func getProductFromCateogry( for  cat_code : Int , per_page : Int  , page : Int  , completed: @escaping (Result<[Product], GFError>) -> Void) {
        
        var endPoint = ""
        
        
        
       if (cat_code == new_arrivals){
            endPoint = Paths.host + Paths.apiPath + "/products?orderby=date&order=desc" + "&per_page=" + String(per_page) + "&page=" + String(page)
        }else {
            
            endPoint = Paths.host + Paths.apiPath + "/products?category=" + String(cat_code)  + "&per_page=" + String(per_page) + "&page=" + String(page)
        }
        
        
        
        guard let url = URL(string: endPoint) else {
            completed(Result.failure(.invalideUrl))
            return
        }
        
        // create our own urlReq as for adder
        print(url)
        var req = URLRequest(url: url)
        
        req.setValue("Basic \(self.getHeaders())", forHTTPHeaderField: "Authorization")
        
        let sessionCOnfig = URLSessionConfiguration.default
        sessionCOnfig.timeoutIntervalForRequest = 500
        sessionCOnfig.timeoutIntervalForResource = 500
        
        let sseesion = URLSession(configuration: sessionCOnfig)
        
        
        
        //print("HEADERS \n \(req.allHTTPHeaderFields)")
        let task = sseesion.dataTask(with: req) { (data, response, error) in
            if let _ = error {
                completed(Result.failure(.unableToComplete))
            }
            
            let res = response as? HTTPURLResponse
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                
                print(res?.statusCode ?? 00)
                completed(Result.failure(.invalidResponse))
                
                return
            }
            
            
            
            guard let data = data else {
                
                completed(Result.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase // specifies the type of decoding
                decoder.dateDecodingStrategy = .iso8601
                let products   : [Product] = try decoder.decode([Product].self, from: data)
                completed(Result.success(products))
            }
            catch let jsonError as NSError {
                print("JSON decode failed: \(jsonError.localizedDescription)")
                
                completed(Result.failure(.invalidData))
            }
            catch  {
                
                completed(Result.failure(.invalidData))
            }
            
        }
        task.resume()
    }
    
    func getProductSearch(for q: String, completed: @escaping (Result<[Product], GFError>) -> Void) {
        
        let search  = q.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
     
        let endPoint = Paths.host + Paths.apiPath + "/products" + "?search=" + search + "&status=publish&per_page=60&page=1"
        guard let url = URL(string: endPoint) else {
            completed(Result.failure(.invalideUrl))
            return
        }
        
        // create our own urlReq as for adder
        print(url)
        var req = URLRequest(url: url)
        
        req.setValue("Basic \(self.getHeaders())", forHTTPHeaderField: "Authorization")
        
        //print("HEADERS \n \(req.allHTTPHeaderFields)")
        let task = URLSession.shared.dataTask(with: req) { (data, response, error) in
            if let _ = error {
                completed(Result.failure(.unableToComplete))
            }
            
            let res = response as? HTTPURLResponse
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                
                print(res?.statusCode ?? 00)
                completed(Result.failure(.invalidResponse))
                
                return
            }
            
            
            
            guard let data = data else {
                
                completed(Result.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase // specifies the type of decoding
                decoder.dateDecodingStrategy = .iso8601
                let products  : [Product] = try decoder.decode([Product].self, from: data)
                completed(Result.success(products))
            }
            catch let jsonError as NSError {
                print("JSON decode failed: \(jsonError.localizedDescription)")
                
                completed(Result.failure(.invalidData))
            }
            catch  {
                
                completed(Result.failure(.invalidData))
            }
            
        }
        task.resume()
    }
    
    func getSubCateogryList( for per_page : String , exclude : String ,parent : String , completed: @escaping (Result<[CategoryModel], GFError>) -> Void) {
        let endPoint = Paths.host + Paths.apiPath + "/products/categories?parent=" + parent   + "&per_page=" + per_page + "&exclude=" + exclude
        guard let url = URL(string: endPoint) else {
            completed(Result.failure(.invalideUrl))
            return
        }
        
        // create our own urlReq as for adder
        print(url)
        var req = URLRequest(url: url)
        
        req.setValue("Basic \(self.getHeaders())", forHTTPHeaderField: "Authorization")
        
        //print("HEADERS \n \(req.allHTTPHeaderFields)")
        let task = URLSession.shared.dataTask(with: req) { (data, response, error) in
            if let _ = error {
                completed(Result.failure(.unableToComplete))
            }
            
            let res = response as? HTTPURLResponse
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                
                print(res?.statusCode ?? 00)
                completed(Result.failure(.invalidResponse))
                
                return
            }
            
            
            
            guard let data = data else {
                
                completed(Result.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase // specifies the type of decoding
                decoder.dateDecodingStrategy = .iso8601
                let categories   : [CategoryModel] = try decoder.decode([CategoryModel].self, from: data)
                completed(Result.success(categories))
            }
            catch let jsonError as NSError {
                print("JSON decode failed: \(jsonError.localizedDescription)")
                
                completed(Result.failure(.invalidData))
            }
            catch  {
                
                completed(Result.failure(.invalidData))
            }
            
        }
        task.resume()
    }
    
    
    func getOldOrderList(for page: Int, completed: @escaping (Result<[OldCartModel], GFError>) -> Void) {
        let endPoint = Paths.host + Paths.apiPath + "/orders" + "?customer=" + String(page)
        guard let url = URL(string: endPoint) else {
            completed(Result.failure(.invalideUrl))
            return
        }
        
        // create our own urlReq as for adder
        print(url)
        var req = URLRequest(url: url)
        
        req.setValue("Basic \(self.getHeaders())", forHTTPHeaderField: "Authorization")
        
        //print("HEADERS \n \(req.allHTTPHeaderFields)")
        let task = URLSession.shared.dataTask(with: req) { (data, response, error) in
            if let _ = error {
                completed(Result.failure(.unableToComplete))
            }
            
            let res = response as? HTTPURLResponse
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                
                print(res?.statusCode ?? 00)
                completed(Result.failure(.invalidResponse))
                
                return
            }
            
            
            
            guard let data = data else {
                
                completed(Result.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
               // decoder.keyDecodingStrategy = .convertFromSnakeCase // specifies the type of decoding
                decoder.dateDecodingStrategy = .iso8601
                let oldCarts  : [OldCartModel] = try decoder.decode([OldCartModel].self, from: data)
                completed(Result.success(oldCarts))
            }
            catch let jsonError as NSError {
                print("JSON decode failed: \(jsonError.localizedDescription)")
                
                completed(Result.failure(.invalidData))
            }
            catch  {
                
                completed(Result.failure(.invalidData))
            }
            
        }
        task.resume()
    }
    
    func CancelAOrder(for order_id: Int, completed: @escaping (Result<OldCartModel, GFError>) -> Void) {
        let endPoint = Paths.host + Paths.apiPath + "/orders/" + String(order_id)
        guard let url = URL(string: endPoint) else {
            completed(Result.failure(.invalideUrl))
            return
        }
        
        // create our own urlReq as for adder
        print(url)
        var req = URLRequest(url: url)
        req.httpMethod = "PUT"
        req.setValue("Basic \(self.getHeaders())", forHTTPHeaderField: "Authorization")
        
        // cancel ta order now
        
        
        
        let para:NSMutableDictionary = NSMutableDictionary()
        para.setValue("cancelled", forKey: "status")
        let jsonData = try! JSONSerialization.data(withJSONObject: para, options: JSONSerialization.WritingOptions.prettyPrinted)
        let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
        print(jsonString)
        
        req.httpBody = "status=cancelled".data(using: String.Encoding.utf8)
        
        
        //print("HEADERS \n \(req.allHTTPHeaderFields)")
        let task = URLSession.shared.dataTask(with: req) { (data, response, error) in
            if let _ = error {
                completed(Result.failure(.unableToComplete))
            }
            
            let res = response as? HTTPURLResponse
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                
                print(res?.statusCode ?? 00)
                completed(Result.failure(.invalidResponse))
                
                return
            }
            
            
            
            guard let data = data else {
                
                completed(Result.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase // specifies the type of decoding
                decoder.dateDecodingStrategy = .iso8601
                let oldCarts  : OldCartModel = try decoder.decode(OldCartModel.self, from: data)
                completed(Result.success(oldCarts))
            }
            catch let jsonError as NSError {
                print("JSON decode failed: \(jsonError.localizedDescription)")
                
                completed(Result.failure(.invalidData))
            }
            catch  {
                
                completed(Result.failure(.invalidData))
            }
            
        }
        task.resume()
    }
    
    
    func getCouponsList( completed: @escaping (Result<[CouponModel], GFError>) -> Void) {
        let endPoint = Paths.host + Paths.apiPath + "/coupons" + ""
        guard let url = URL(string: endPoint) else {
            completed(Result.failure(.invalideUrl))
            return
        }
        
        // create our own urlReq as for adder
        print(url)
        var req = URLRequest(url: url)
        
        req.setValue("Basic \(self.getHeaders())", forHTTPHeaderField: "Authorization")
        
        //print("HEADERS \n \(req.allHTTPHeaderFields)")
        let task = URLSession.shared.dataTask(with: req) { (data, response, error) in
            if let _ = error {
                completed(Result.failure(.unableToComplete))
            }
            
            let res = response as? HTTPURLResponse
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                
                print(res?.statusCode ?? 00)
                completed(Result.failure(.invalidResponse))
                
                return
            }
            
            
            
            guard let data = data else {
                
                completed(Result.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase // specifies the type of decoding
                decoder.dateDecodingStrategy = .iso8601
                let oldCarts  : [CouponModel] = try decoder.decode([CouponModel].self, from: data)
                completed(Result.success(oldCarts))
            }
            catch let jsonError as NSError {
                print("JSON decode failed: \(jsonError.localizedDescription)")
                
                completed(Result.failure(.invalidData))
            }
            catch  {
                
                completed(Result.failure(.invalidData))
            }
            
        }
        task.resume()
    }
    
    func getWalletItemList(for userId: Int ,  completed: @escaping (Result<[WalletItem], GFError>) -> Void) {
        let endPoint = Paths.host + "/wp-json/wp/v3" + "/wallet/" + String(userId)
        guard let url = URL(string: endPoint) else {
            completed(Result.failure(.invalideUrl))
            return
        }
        
        // create our own urlReq as for adder
        print(url)
        var req = URLRequest(url: url)
        
        req.setValue("Basic \(self.getHeaders())", forHTTPHeaderField: "Authorization")
        
        let sessionCOnfig = URLSessionConfiguration.default
        sessionCOnfig.timeoutIntervalForRequest = 500
        sessionCOnfig.timeoutIntervalForResource = 500
        sessionCOnfig.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        
        let sseesion = URLSession(configuration: sessionCOnfig)
        
        //print("HEADERS \n \(req.allHTTPHeaderFields)")
        let task = sseesion.dataTask(with: req) { (data, response, error) in
            if let _ = error {
                completed(Result.failure(.unableToComplete))
            }
            
            let res = response as? HTTPURLResponse
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                
                print(res?.statusCode ?? 00)
                completed(Result.failure(.invalidResponse))
                
                return
            }
            
            
            
            guard let data = data else {
                
                completed(Result.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase // specifies the type of decoding
                decoder.dateDecodingStrategy = .iso8601
                let transactions  : [WalletItem] = try decoder.decode([WalletItem].self, from: data)
                completed(Result.success(transactions))
            }
            catch let jsonError as NSError {
                print("JSON decode failed: \(jsonError.localizedDescription)")
                
                completed(Result.failure(.invalidData))
            }
            catch  {
                
                completed(Result.failure(.invalidData))
            }
            
        }
        task.resume()
    }
    
    func UpdatePassword(for userID: Int , new_password : String , completed: @escaping (Result<ResetPassRecivied, GFError>) -> Void) {
        let endPoint = Paths.host + Paths.apiPath + "/customers/" + String(userID)
        guard let url = URL(string: endPoint) else {
            completed(Result.failure(.invalideUrl))
            return
        }
        
        // create our own urlReq as for adder
        print(url)
        var req = URLRequest(url: url)
        req.httpMethod = "PUT"
        req.setValue("Basic \(self.getHeaders())", forHTTPHeaderField: "Authorization")
        
        // cancel ta order now
        
        
        
        req.httpBody = ("password="+new_password).data(using: String.Encoding.utf8)
        
        
        //print("HEADERS \n \(req.allHTTPHeaderFields)")
        let task = URLSession.shared.dataTask(with: req) { (data, response, error) in
            if let _ = error {
                completed(Result.failure(.unableToComplete))
            }
            
            let res = response as? HTTPURLResponse
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                
                print(res?.statusCode ?? 00)
                completed(Result.failure(.invalidResponse))
                
                return
            }
            
            
            
            guard let data = data else {
                
                completed(Result.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase // specifies the type of decoding
                decoder.dateDecodingStrategy = .iso8601
                let customer  : ResetPassRecivied = try decoder.decode(ResetPassRecivied.self, from: data)
                completed(Result.success(customer))
            }
            catch let jsonError as NSError {
                print("JSON decode failed: \(jsonError.localizedDescription)")
                
                completed(Result.failure(.invalidData))
            }
            catch  {
                
                completed(Result.failure(.invalidData))
            }
            
        }
        task.resume()
    }
    
    //https://afiqsouq.com/wp-json/wp/v3/current_balance/13
    
    func getWalletBallence( for userId: Int , completed: @escaping (Result<String, GFError>) -> Void) {
        let endPoint = Paths.host + "/wp-json/wp/v3/current_balance/" + String(userId)
        guard let url = URL(string: endPoint) else {
            completed(Result.failure(.invalideUrl))
            return
        }
        
        // create our own urlReq as for adder
        print(url)
        var req = URLRequest(url: url)
        
        req.setValue("Basic \(self.getHeaders())", forHTTPHeaderField: "Authorization")
        
        let sessionCOnfig = URLSessionConfiguration.default
        sessionCOnfig.timeoutIntervalForRequest = 500
        sessionCOnfig.timeoutIntervalForResource = 500
        sessionCOnfig.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        
        let sseesion = URLSession(configuration: sessionCOnfig)
        
        //print("HEADERS \n \(req.allHTTPHeaderFields)")
        let task = sseesion.dataTask(with: req) { (data, response, error) in
            if let _ = error {
                completed(Result.failure(.unableToComplete))
            }
            
            let res = response as? HTTPURLResponse
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                
                print(res?.statusCode ?? 00)
                completed(Result.failure(.invalidResponse))
                
                return
            }
            
            
            
            guard let data = data else {
                
                completed(Result.failure(.invalidData))
                return
            }
            
            do {
                //  let decoder = JSONDecoder()
                //  decoder.keyDecodingStrategy = .convertFromSnakeCase // specifies the type of decoding
                //   decoder.dateDecodingStrategy = .iso8601
                let walletBal   =  String(decoding: data, as: UTF8.self)
                completed(Result.success(walletBal))
            }
           
            
        }
        task.resume()
    }
    
    func  CreateAReview (for review : ReviewModel , completed: @escaping (Result<ReviewModel, GFError>) -> Void) {
        
        
        let endPoint = Paths.host + Paths.apiPath +  "/products/reviews"
        
        
        
        guard let url = URL(string: endPoint) else {
            completed(Result.failure(.invalideUrl))
            return
        }
        print(url)
        
        var req = URLRequest(url: url)
        
        req.httpMethod = "POST"
        
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        req.setValue("Basic \(self.getHeaders())", forHTTPHeaderField: "Authorization")
        
        let jsonData = try! JSONEncoder().encode(review)
        let jsonString = String(data: jsonData, encoding: .utf8)!
        //  let JsonData2 = try! JSONEncoder().encode(jsonString)
        print(jsonString)
        // insert json data to the request
        req.httpBody = jsonString.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: req) { (data, response, error) in
            if let _ = error {
                completed(Result.failure(.unableToComplete))
            }
            
            let res = response as? HTTPURLResponse
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 201 else {
                print(res?.statusCode ?? 00)
                completed(Result.failure(.invalidResponse))
                
                return
            }
            
            
            
            guard let data = data else {
                
                completed(Result.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase // specifies the type of decoding
                decoder.dateDecodingStrategy = .iso8601
                let reviews = try decoder.decode(ReviewModel.self, from: data)
                completed(Result.success(reviews))
            } catch  {
                
                completed(Result.failure(.invalidData))
            }
        }
        task.resume()
        
        
    }
    
    func getReviewList(for itemId : Int ,  completed: @escaping (Result<[ReviewModel], GFError>) -> Void) {
        let endPoint = Paths.host + "/wp-json/wc/v3" + "/products/reviews?product=" + String(itemId)
        
        //products/reviews?product=5151
        guard let url = URL(string: endPoint) else {
            completed(Result.failure(.invalideUrl))
            return
        }
        
        // create our own urlReq as for adder
        print(url)
        var req = URLRequest(url: url)
        
        req.setValue("Basic \(self.getHeaders())", forHTTPHeaderField: "Authorization")
        
        //print("HEADERS \n \(req.allHTTPHeaderFields)")
        let task = URLSession.shared.dataTask(with: req) { (data, response, error) in
            if let _ = error {
                completed(Result.failure(.unableToComplete))
            }
            
            let res = response as? HTTPURLResponse
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                
                print(res?.statusCode ?? 00)
                completed(Result.failure(.invalidResponse))
                
                return
            }
            
            
            
            guard let data = data else {
                
                completed(Result.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase // specifies the type of decoding
                decoder.dateDecodingStrategy = .iso8601
                let reviews  : [ReviewModel] = try decoder.decode([ReviewModel].self, from: data)
                completed(Result.success(reviews))
            }
            catch let jsonError as NSError {
                print("JSON decode failed: \(jsonError.localizedDescription)")
                
                completed(Result.failure(.invalidData))
            }
            catch  {
                
                completed(Result.failure(.invalidData))
            }
            
        }
        task.resume()
    }
    
    
    func searchUser(for mail : String ,  completed: @escaping (Result<[CustomerDetailsResponse], GFError>) -> Void) {
        let endPoint = Paths.host + "/wp-json/wc/v3" + "/customers?email=" +  mail
        
        //products/reviews?product=5151
        guard let url = URL(string: endPoint) else {
            completed(Result.failure(.invalideUrl))
            return
        }
        
        // create our own urlReq as for adder
        print(url)
        var req = URLRequest(url: url)
        
        req.setValue("Basic \(self.getHeaders())", forHTTPHeaderField: "Authorization")
        
        //print("HEADERS \n \(req.allHTTPHeaderFields)")
        let task = URLSession.shared.dataTask(with: req) { (data, response, error) in
            if let _ = error {
                completed(Result.failure(.unableToComplete))
            }
            
            let res = response as? HTTPURLResponse
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                
                print(res?.statusCode ?? 00)
                completed(Result.failure(.invalidResponse))
                
                return
            }
            
            
            
            guard let data = data else {
                
                completed(Result.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
             //   decoder.keyDecodingStrategy = .convertFromSnakeCase // specifies the type of decoding
                decoder.dateDecodingStrategy = .iso8601
                let customers  : [CustomerDetailsResponse] = try decoder.decode([CustomerDetailsResponse].self, from: data)
                completed(Result.success(customers))
            }
            catch let jsonError as NSError {
                print("JSON decode failed: \(jsonError.localizedDescription)")
                
                completed(Result.failure(.invalidData))
            }
            catch  {
                
                completed(Result.failure(.invalidData))
            }
            
        }
        task.resume()
    }
    
    
    func  CreateOrder(for userDetails : CreateOrderModel , completed: @escaping (Result<OldCartModel, GFError>) -> Void) {
        
        

        let endPoint = Paths.host + Paths.apiPath + "/orders"
        
        let sessionCOnfig = URLSessionConfiguration.default
        sessionCOnfig.timeoutIntervalForRequest = 500
        sessionCOnfig.timeoutIntervalForResource = 500
        sessionCOnfig.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        let sseesion = URLSession(configuration: sessionCOnfig)
        
        
        
        guard let url = URL(string: endPoint) else {
            completed(Result.failure(.invalidUsername))
            return
        }
        print(url)
        
        var req = URLRequest(url: url)
        
        req.httpMethod = "POST"
        
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        req.setValue("Basic \(self.getHeaders())", forHTTPHeaderField: "Authorization")
        
        let jsonData = try! JSONEncoder().encode(userDetails)
        let jsonString = String(data: jsonData, encoding: .utf8)!
        //  let JsonData2 = try! JSONEncoder().encode(jsonString)
        //  print(jsonString)
        // insert json data to the request
        
        //print(jsonString)
        req.httpBody = jsonString.data(using: .utf8)
        
        let task = sseesion.dataTask(with: req) { (data, response, error) in
            if let _ = error {
                completed(Result.failure(.unableToComplete))
            }
            
            let res = response as? HTTPURLResponse
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 201 else {
                print(res?.statusCode ?? 00)
                completed(Result.failure(.invalidResponse))
                
                return
            }
            
            
            
            guard let data = data else {
                
                completed(Result.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
            //    decoder.keyDecodingStrategy = .convertFromSnakeCase // specifies the type of decoding
                decoder.dateDecodingStrategy = .iso8601
                let oldeOrder = try decoder.decode(OldCartModel.self, from: data)
                completed(Result.success(oldeOrder))
                
            }
            catch let jsonError as NSError {
                print("JSON decode failed: \(jsonError.localizedDescription)")
                
                completed(Result.failure(.invalidData))
            }
            catch  {
                
                completed(Result.failure(.invalidData))
            }
        }
        task.resume()
        
        
    }
    
    
    func adjustWalletBalance(for userId: Int , amount : String , type : String  ,details : String   ,  completed: @escaping (Result<WalletResponse, GFError>) -> Void) {
        let endPoint = Paths.host + "/wp-json/wp/v3" + "/wallet/" + String(userId) + "?type=" + type + "&details=" + details + "&amount=" + amount
        
        //print(endPoint)
        guard let url = URL(string: endPoint) else {
            completed(Result.failure(.invalideUrl))
            return
        }
        
        // create our own urlReq as for adder
        print(url)
        var req = URLRequest(url: url)
        
       
        
        req.setValue("Basic \(self.getHeaders())", forHTTPHeaderField: "Authorization")
        
        req.httpMethod = "POST"
        
        //print("HEADERS \n \(req.allHTTPHeaderFields)")
        let task = URLSession.shared.dataTask(with: req) { (data, response, error) in
            if let _ = error {
                completed(Result.failure(.unableToComplete))
            }
            
            let res = response as? HTTPURLResponse
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                
                print(res?.statusCode ?? 00)
                completed(Result.failure(.invalidResponse))
                
                return
            }
            
            
            
            guard let data = data else {
                
                completed(Result.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
               // decoder.keyDecodingStrategy = .convertFromSnakeCase // specifies the type of decoding
                decoder.dateDecodingStrategy = .iso8601
                let transactions  : WalletResponse = try decoder.decode(WalletResponse.self, from: data)
                completed(Result.success(transactions))
            }
            catch let jsonError as NSError {
                print("JSON decode failed: \(jsonError.localizedDescription)")
                
                completed(Result.failure(.invalidData))
            }
            catch  {
                
                completed(Result.failure(.invalidData))
            }
            
        }
        task.resume()
    }
    
    
    func getCouponsCode(for code : String , completed: @escaping (Result<[CouponModel], GFError>) -> Void) {
        let endPoint = Paths.host + Paths.apiPath + "/coupons" + "?code=" + code
        guard let url = URL(string: endPoint) else {
            completed(Result.failure(.invalideUrl))
            return
        }
        
        // create our own urlReq as for adder
        print(url)
        var req = URLRequest(url: url)
        
        req.setValue("Basic \(self.getHeaders())", forHTTPHeaderField: "Authorization")
        
        
        let sessionCOnfig = URLSessionConfiguration.default
        sessionCOnfig.timeoutIntervalForRequest = 500
        sessionCOnfig.timeoutIntervalForResource = 500
        sessionCOnfig.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        let sseesion = URLSession(configuration: sessionCOnfig)
        
        
        //print("HEADERS \n \(req.allHTTPHeaderFields)")
        let task = sseesion.dataTask(with: req) { (data, response, error) in
            if let _ = error {
                completed(Result.failure(.unableToComplete))
            }
            
            let res = response as? HTTPURLResponse
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                
                print(res?.statusCode ?? 00)
                completed(Result.failure(.invalidResponse))
                
                return
            }
            
            
            
            guard let data = data else {
                
                completed(Result.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase // specifies the type of decoding
                decoder.dateDecodingStrategy = .iso8601
                let oldCarts  : [CouponModel] = try decoder.decode([CouponModel].self, from: data)
                completed(Result.success(oldCarts))
            }
            catch let jsonError as NSError {
                print("JSON decode failed: \(jsonError.localizedDescription)")
                
                completed(Result.failure(.invalidData))
            }
            catch  {
                
                completed(Result.failure(.invalidData))
            }
            
        }
        task.resume()
    }
    
    func getProductSearchFromCateGory(for q: String , cateCode : Int , page  : Int , completed: @escaping (Result<[Product], GFError>) -> Void) {
      
        let search  = q.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
        
        let endPoint = Paths.host + Paths.apiPath + "/products" + "?search=" + search + "&status=publish&per_page=40&page=" + String(page) + "&category=" + String(cateCode)
        guard let url = URL(string: endPoint) else {
            completed(Result.failure(.invalideUrl))
            return
        }
        
        // create our own urlReq as for adder
        print(url)
        var req = URLRequest(url: url)
        
        req.setValue("Basic \(self.getHeaders())", forHTTPHeaderField: "Authorization")
        
        //print("HEADERS \n \(req.allHTTPHeaderFields)")
        let task = URLSession.shared.dataTask(with: req) { (data, response, error) in
            if let _ = error {
                completed(Result.failure(.unableToComplete))
            }
            
            let res = response as? HTTPURLResponse
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                
                print(res?.statusCode ?? 00)
                completed(Result.failure(.invalidResponse))
                
                return
            }
            
            
            
            guard let data = data else {
                
                completed(Result.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase // specifies the type of decoding
                decoder.dateDecodingStrategy = .iso8601
                let products  : [Product] = try decoder.decode([Product].self, from: data)
                completed(Result.success(products))
            }
            catch let jsonError as NSError {
                print("JSON decode failed: \(jsonError.localizedDescription)")
                
                completed(Result.failure(.invalidData))
            }
            catch  {
                
                completed(Result.failure(.invalidData))
            }
            
        }
        task.resume()
    }
    
    func getProductSearchFromMultipleCateGory(for q: String , cateCode : Int  , cateCode2 : Int , page  : Int , completed: @escaping (Result<[Product], GFError>) -> Void) {
      
        let search  = q.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
        
        let endPoint = Paths.host + Paths.apiPath + "/products" + "?search=" + search + "&status=publish&per_page=20&page=" + String(page) + "&category=" + String(cateCode) + "," + String(cateCode2)
        
        guard let url = URL(string: endPoint) else {
            completed(Result.failure(.invalideUrl))
            return
        }
        
        // create our own urlReq as for adder
        print(url)
        var req = URLRequest(url: url)
        
        req.setValue("Basic \(self.getHeaders())", forHTTPHeaderField: "Authorization")
        
        //print("HEADERS \n \(req.allHTTPHeaderFields)")
        let task = URLSession.shared.dataTask(with: req) { (data, response, error) in
            if let _ = error {
                completed(Result.failure(.unableToComplete))
            }
            
            let res = response as? HTTPURLResponse
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                
                print(res?.statusCode ?? 00)
                completed(Result.failure(.invalidResponse))
                
                return
            }
            
            
            
            guard let data = data else {
                
                completed(Result.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase // specifies the type of decoding
                decoder.dateDecodingStrategy = .iso8601
                let products  : [Product] = try decoder.decode([Product].self, from: data)
                completed(Result.success(products))
            }
            catch let jsonError as NSError {
                print("JSON decode failed: \(jsonError.localizedDescription)")
                
                completed(Result.failure(.invalidData))
            }
            catch  {
                
                completed(Result.failure(.invalidData))
            }
            
        }
        task.resume()
    }
    
    func addWalletBalance(for userId: Int , amount : String , type : String  ,details : String   ,  completed: @escaping (Result<WalletResponse, GFError>) -> Void) {
        let endPoint = Paths.host + "/wp-json/wp/v3" + "/wallet/" + String(userId) + "?type=" + type + "&details=" + details + "&amount=" + amount
        
        //print(endPoint)
        guard let url = URL(string: endPoint) else {
            completed(Result.failure(.invalideUrl))
            return
        }
        
        // create our own urlReq as for adder
        print(url)
        var req = URLRequest(url: url)
        
       
        
        req.setValue("Basic \(self.getHeaders())", forHTTPHeaderField: "Authorization")
        
        req.httpMethod = "POST"
        
        //print("HEADERS \n \(req.allHTTPHeaderFields)")
        let task = URLSession.shared.dataTask(with: req) { (data, response, error) in
            if let _ = error {
                completed(Result.failure(.unableToComplete))
            }
            
            let res = response as? HTTPURLResponse
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                
                print(res?.statusCode ?? 00)
                completed(Result.failure(.invalidResponse))
                
                return
            }
            
            
            
            guard let data = data else {
                
                completed(Result.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
               // decoder.keyDecodingStrategy = .convertFromSnakeCase // specifies the type of decoding
                decoder.dateDecodingStrategy = .iso8601
                let transactions  : WalletResponse = try decoder.decode(WalletResponse.self, from: data)
                completed(Result.success(transactions))
            }
            catch let jsonError as NSError {
                print("JSON decode failed: \(jsonError.localizedDescription)")
                
                completed(Result.failure(.invalidData))
            }
            catch  {
                
                completed(Result.failure(.invalidData))
            }
            
        }
        task.resume()
    }
    
    
    
}


