//
//  ProductListViewModel.swift
//  Afiq Souq
//
//  Created by GAMEKILLER on 4/8/21.
//

import Foundation
class ProductListViewModel: ObservableObject{
     var  mainProductList : [Product] = []
    var categorycode : Int
    @Published var page = 1
    @Published var loadMore : Bool = false
   
    
    
    init(item : Int ) {
        self.categorycode = item
        //prinData()
        loadProductList(page: page)
   
    }
    
    func loadMoreProduct() {
        
        
        if(loadMore == false ){
            self.page = page + 1
        print("loading -> " + String(page))
        loadProductList(page: page )
        
        }else {
            print("We Are ALready loading Here !!!")
        }
    }
    
    
    func loadProductList( page : Int )  {
        
        // here we load products
        
        loadMore = true
        let code = categorycode
        
        NetworkManager.shared.getProductFromCateogry(for: code, per_page: 20, page: page){
            
            [weak self] result in
            guard self != nil else {return}
            
            switch(result){
            case .success(let productList):
                // save the data
                // self?.saveUser(user: userDeatils)
                
                DispatchQueue.main.async { [self] in
                    
                    self?.mainProductList.append(contentsOf: productList)
                    
                   
                    self?.loadMore = false
                    
                }
                
                
                
            case .failure(let errror ):
                DispatchQueue.main.async {
                    print(errror)
                    
                }
                
            }
            
        }
        
        
    }
    
    
    
    
    
}
