//
//  CategoryDetailsViewModel.swift
//  Afiq Souq
//
//  Created by GAMEKILLER on 4/17/21.
//

import Foundation

class CategoryDetailsViewModel: ObservableObject{
    
    var categoryItem : Int
    @Published var subCateList : [CategoryModel] = []
    @Published  var  mainProductList : [Product] = []
    var catList : [CategoryModel] = []
    var loadMore  = false
    var page = 1
    var lastKey =  0  // here 0 means normal 1 means search was activiated
    @Published  var searching : Bool  = false
    
    @Published  var loading : Bool  = false
    
    init(item : Int ) {
        self.categoryItem = item
        //prinData()
        loadAllSubCategories(catModel: item)
        loadProductList( search: "",page: page)
        
    }
    
    
    func loadAllSubCategories(catModel : Int )  {
        
        
        let   id : String = String(catModel )
        
        print(id)
        // here we load products
        NetworkManager.shared.getSubCateogryList(for: "50", exclude: "15", parent: id ){
            
            [weak self] result in
            guard self != nil else {return}
            
            switch(result){
            case .success(let catList):
                // save the data"
                // self?.saveUser(user: userDeatils)
                
                
                
                DispatchQueue.main.async { [self] in
                    self?.subCateList.removeAll()
                    self?.subCateList.append(contentsOf: catList)
                    
                }
                
                
            case .failure(let errror ):
                DispatchQueue.main.async {
                    print(errror)
                    
                }
                
            }
            
        }
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
    
}
