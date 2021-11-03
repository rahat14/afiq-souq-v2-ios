//
//  infinteViewModel.swift
//  Afiq Souq
//
//  Created by GAMEKILLER on 5/25/21.
//

import Foundation



class infinteViewModel: ObservableObject{
    var  ProductList : [Product] = []
    @Published var page = 2
    @Published var loadMore : Bool = true
    init(){
        
        self.loadProductList(page: page)
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
        NetworkManager.shared.getProductList(for: page , p_count: 30){
            
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
                  
                    
                }
                
                
                
            case .failure(let errror ):
                DispatchQueue.main.async {
                    print(errror)
                    
                }
                
            }
            
        }
        
        
    }
    

}


