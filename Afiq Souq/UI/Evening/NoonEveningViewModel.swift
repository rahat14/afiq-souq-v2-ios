//
//  NoonEveningViewModel.swift
//  Afiq Souq
//
//  Created by GAMEKILLER on 5/9/21.
//

import Foundation
class NoonEveingViewmodel: ObservableObject{
    
    var categoryItem : Int
    @Published var subCateList : [CategoryModel] = []
    @Published  var  mainProductList : [Product] = []
    var catCodes  : [Int] = [ 381 , 356 , 707 , 942 , 440 , 118 , 330 , 341 , 708 , 118 , 2018 , 68 , 466 , 117 , 119 ]
    var catList : [CategoryModel] = []
    var loadMore  = false
    var page = 1
    var lastKey =  0  // here 0 means normal 1 means search was activiated
    @Published  var searching : Bool  = false
    
    @Published  var loading : Bool  = false
    
    init(item : Int ) {
        self.categoryItem = item
        //prinData()
        loadProductList( search: "",page: page)
        
    }
    

    func loadMoreProduct() {
        
        
        if(loadMore == false ){
            self.page = page + 1
            print("loading -> " + String(page))
            loadProductList(search : ""  , page: page )
            
        }else {
            print("We Are ALready loading Here !!!")
        }
    }
    
    
    func loadProductList(search : String   ,page : Int )  {
        
        // here we load products
        let p = page
        loadMore = true
        self.loading = true
        let code = categoryItem
        
        
        if(code == 398){
            NetworkManager.shared.getProductSearchFromCateGory(for: search, cateCode: code , page : p   ){
                
                [weak self] result in
                guard self != nil else {return}
                
                switch(result){
                case .success(let productList):
                    // save the data
                    // self?.saveUser(user: userDeatils)
                    
                    DispatchQueue.main.async { [self] in
                        
                        let count = search.count
                        print(count)
                        if(count == 0){
                            if(self?.lastKey == 1 ){
                                self?.loading = false
                                self?.mainProductList.removeAll()
                                self?.mainProductList.append(contentsOf: productList)
                                self?.lastKey = 0
                            }else {
                                self?.loading = false
                                self?.mainProductList.append(contentsOf: productList)
                                self?.lastKey = 0
                            }
                            
                        }else {
                            
                            self?.mainProductList.removeAll()
                            self?.mainProductList.append(contentsOf: productList)
                            self?.loading = false
                            self?.lastKey = 1
                        }
                        
                        self?.searching = false
                        self?.loadMore = false
                        self?.loading = false
                    }
                    
                    
                    
                case .failure(let errror ):
                    DispatchQueue.main.async {
                        print(errror)
                        
                    }
                    
                }
                
            }
      
        }
        else {
            NetworkManager.shared.getProductSearchFromMultipleCateGory(for: search, cateCode: catCodes.randomElement() ?? catCodes[2] , cateCode2: catCodes.randomElement() ?? catCodes[0]  , page : p   ){
                
                [weak self] result in
                guard self != nil else {return}
                
                switch(result){
                case .success(let productList):
                    // save the data
                    // self?.saveUser(user: userDeatils)
                    
                    DispatchQueue.main.async { [self] in
                        
                        let count = search.count
                        print(count)
                        if(count == 0){
                            if(self?.lastKey == 1 ){
                                self?.loading = false
                                self?.mainProductList.removeAll()
                                self?.mainProductList.append(contentsOf: productList)
                                self?.lastKey = 0
                             
                                
                            }else {
                                self?.loading = false
                                self?.mainProductList.append(contentsOf: productList)
                                self?.lastKey = 0
                            }
                            
                            if(self?.mainProductList.count  == 0){
                                self?.loadProductList(search: "", page: page)
                            }
                            
                        }else {
                            
                            self?.mainProductList.removeAll()
                            self?.mainProductList.append(contentsOf: productList)
                            self?.loading = false
                            self?.lastKey = 1
                        }
                        
                        self?.searching = false
                        self?.loadMore = false
                        self?.loading = false
                    }
                    
                    
                    
                case .failure(let errror ):
                    DispatchQueue.main.async {
                        print(errror)
                        
                    }
                    
                }
                
            }
        }
        
        
        
       
        
        
    }
    
}
