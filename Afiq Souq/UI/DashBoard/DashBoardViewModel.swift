//
//  DashBoardViewModel.swift
//  Afiq Souq
//
//  Created by GAMEKILLER on 4/9/21.
//

import Foundation
import RealmSwift
import SwiftUI

class DashBoardViewModel: ObservableObject{
    var  ProductList : [Product] = []
    @Published var  categoryList: [CategoryModel] = []
    var  a: [CategoryModel] = []
    var  b: [CategoryModel] = []
    var  c: [CategoryModel] = []
    @Published var comboOfferList : [Product] = []
    var  electronicsList : [Product] = []
    var  health_beautyList : [Product] = []
    @Published var searching : Bool = false
    @Published var  searchProductList : [Product] = []
    @Published var page = 1
    @Published var loadMore : Bool = true
    @Published  var scrollOffset : CGFloat = .zero
    @Published var  bottomVisible : Bool = false
    
    init() {
        //        alamoLoadElectronics()
        DispatchQueue.global(qos: .utility).async(qos : .default) { [self] in
            loadCategories()
           // loadElectronics()//
          //  loadBeatuy()
         // loadComboOfferProductList(page: 1)
           // self.loadProductList(page: 1)
            
        }
        DispatchQueue.global(qos: .utility).async(qos : .default) { [self] in
            //loadCategories()
           loadElectronics()//
          // loadBeatuy()
          loadComboOfferProductList(page: 1)
           // self.loadProductList(page: 1)
            
        }
        
        DispatchQueue.global(qos: .utility).async(qos : .default) { [self] in
          //  loadCategories()
          //  loadElectronics()//
          //  loadBeatuy()
         // loadComboOfferProductList(page: 1)
            self.loadProductList(page: 1)
            
        }
    }
    
    
    func loadMoreProduct() {
        
        
        if(loadMore == false ){
            self.page = page + 1
            print("loading -> " + String(page))
            
            DispatchQueue.global(qos: .utility).async(qos : .userInitiated) { [self] in
                self.loadProductList(page: page )
            }
        }else {
            print("We Are ALready loading Here !!!")
        }
    }
    
    
    func loadProductList( page : Int )  {
        
        // here we load products
        DispatchQueue.main.async { [self] in
            
            self.loadMore = true
            
        }
        NetworkManager.shared.getProductList(for: page , p_count: 20){
            
            [weak self] result in
            guard self != nil else {return}
            
            switch(result){
            case .success(let productList):
                // save the data
                // self?.saveUser(user: userDeatils)
                
                DispatchQueue.main.async { [self] in
                    
                    self?.ProductList.append(contentsOf: productList)
                    
                    print(self?.ProductList.count ?? -1 )
                    self?.loadMore = false
                    self?.bottomVisible = true
                    
                }
                
                
                
            case .failure(let errror ):
                DispatchQueue.main.async {
                    print(errror)
                    
                }
                
            }
            
        }
        
        
    }
    
    func testPrint(test: Double)  {
        print(test)
    }
    
    func loadComboOfferProductList( page : Int )  {
        
        
        NetworkManager.shared.getComboOfferProductList(for: page){
            
            [weak self] result in
            guard self != nil else {return}
            
            switch(result){
            case .success(let productList):
                // save the data
                // self?.saveUser(user: userDeatils)
                
                DispatchQueue.main.async { [self] in
                    
                    self?.comboOfferList.append(contentsOf: productList)
                    
                    
                }
                
                
                
            case .failure(let errror ):
                DispatchQueue.main.async {
                    print(errror)
                    
                }
                
            }
            
        }
        
        
    }
    func loadCategories()  {
        
        // here we load products
        
        
        NetworkManager.shared.getCateogryList(for: "12"){
            
            [weak self] result in
            guard self != nil else {return}
            
            switch(result){
            case .success(let catList):
                // save the data"
                // self?.saveUser(user: userDeatils)
                
                
                DispatchQueue.main.async { [self] in
                    
                    self?.categoryList.append(contentsOf: catList)
                    
                    
                    var i  = 0
                    for item in catList {
                        
                        if(i < 4){
                            self?.a.append(item)
                        }else if (i < 8 ){
                            
                            self?.b.append(item)
                        }
                        else {
                            self?.c.append(item)
                        }
                        
                        i = i + 1 
                        
                    }
                    
                    
                    
                }
                
                
            case .failure(let errror ):
                DispatchQueue.main.async {
                    print(errror)
                    
                }
                
            }
            
        }
        
        
    }
    
    
    func loadBeatuy() {
        NetworkManager.shared.getProductFromCateogry(for: 330, per_page: 10, page: 1){
            
            [weak self] result in
            guard self != nil else {return}
            
            switch(result){
            case .success(let productList):
                
                DispatchQueue.main.async { [self] in
                    
                    self?.health_beautyList.append(contentsOf: productList)
                }
                
                
                
            case .failure(let errror ):
                DispatchQueue.main.async {
                    print(errror)
                    
                }
                
            }
            
        }
    }
    
    
    func loadElectronics() {
        NetworkManager.shared.getProductFromCateogry(for: 440, per_page: 10, page: 1){
            
            [weak self] result in
            guard self != nil else {return}
            
            switch(result){
            case .success(let productList):
                
                self?.loadProductList(page: 1)
                DispatchQueue.main.async { [self] in
                    
                    self?.electronicsList.append(contentsOf: productList)
                    
                }
                
                
                
            case .failure(let errror ):
                DispatchQueue.main.async {
                    print(errror)
                    
                }
                
            }
            
        }
    }
    
    
    func loadElectroList() {
        
        if(electronicsList.count == 0 ){
            
            loadElectronics()
        }
        
    }
    
    func loadHealth()  {
        if(health_beautyList.count == 0 ){
            loadBeatuy()
        }
    }
    
    
    
    func isCateEmpty() {
        if(categoryList.count == 0 ){
            loadCategories()
        }
    }
    
    func loadProductSearch(q : String )  {
        
        searching = true
        NetworkManager.shared.getProductSearch(for: q){
            
            [weak self] result in
            guard self != nil else {return}
            
            switch(result){
            case .success(let productList):
                
                DispatchQueue.main.async { [self] in
                    self?.searching = false
                    
                    self?.searchProductList = productList
                    // print(self?.searchProductList.count)
                }
                
                
                
            case .failure(let errror ):
                DispatchQueue.main.async {
                    
                    self?.searching = false
                    print(errror)
                    
                }
                
            }
            
        }
    }
    func getCartCount() -> String {
        
        var cartList : [CartDbMOdel] = []
        do{
            let realm = try Realm()
            
            
         let ingredientResults = realm.objects(CartDbMOdel.self)
           
            
             cartList =  ingredientResults.map(CartDbMOdel.init)
            
      //      setData(cartList)
            
          
        
        }
        
        catch let error {
          // Handle error
            print(error.localizedDescription)
           
        }
    
        return String(cartList.count)
    }
    
    //    func alamoLoadElectronics() {
    //        let  endPoint = Paths.host + Paths.apiPath + "/products?category=450"   + "&per_page=10"
    //        // let   headers : HTTPHeader = HTTPHeader.authorization(username: , password: Paths.key_pass)
    //        let headers: HTTPHeaders = [
    //            .authorization(username: Paths.key_user, password: Paths.key_pass),
    //            .accept("application/json")
    //        ]
    //
    //        let req = AF.request(endPoint , headers: headers )
    //
    //        //        req.responseDecodable(of:[Productss].self) { response in
    //        //            switch response.result {
    //        //            case .success:
    //        //                switch response.response?.statusCode {
    //        //                case 200:
    //        //                    //response.value is of type [Account]
    //        //                    print(response.value?.count)
    //        //                default:
    //        //                    //handle other cases
    //        //                    print("error")
    //        //                }
    //        //            case let .failure(error):
    //        //                //probably the decoding failed because your json doesn't match the expected format
    //        //                print("error" +  error.localizedDescription )
    //        //            }
    //        //        }
    //        req.responseJSON { response in
    //            //                   print("Response JSON: \(response.value)")
    //
    //            switch (response.result) {
    //
    //            case .success( _):
    //
    //                do {
    //
    //                    let decoder = JSONDecoder()
    //                    decoder.keyDecodingStrategy = .convertFromSnakeCase // specifies the type of decoding
    //                    decoder.dateDecodingStrategy = .iso8601
    //                    let products  : [Product] = try decoder.decode([Product].self, from:  Data(response.utf8))
    //
    //                    print(response)
    //
    //                } catch let error as NSError {
    //                    print("Failed to load: \(error.localizedDescription)")
    //                }
    //
    //            case .failure(let error):
    //                print("Request error: \(error.localizedDescription)")
    //
    //
    //            }
    //
    //
    //            //
    //            //        guard let data = response.data else { return }
    //
    //        }
    //    }
    //
    
    
    
}
