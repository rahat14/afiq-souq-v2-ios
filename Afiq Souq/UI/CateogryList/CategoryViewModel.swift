//
//  CategoryViewModel.swift
//  Afiq Souq
//
//  Created by GAMEKILLER on 4/17/21.
//

import Foundation
import RealmSwift

class CategoryViewModel: ObservableObject{
    
    var cartList : [CartDbMOdel] = []
  @Published   var categoryList : [CategoryModel] = []
    
    init(){
        loadAllParentCategories()
    }
    
    func loadAllParentCategories()  {
        
        // here we load products
        NetworkManager.shared.getCateogryList(for: "50"){
            
            [weak self] result in
            guard self != nil else {return}
            
            switch(result){
            case .success(let catList):
                // save the data"
                // self?.saveUser(user: userDeatils)
                
                DispatchQueue.main.async { [self] in
                    
                    self?.categoryList = catList
                    
                }
                
                
            case .failure(let errror ):
                DispatchQueue.main.async {
                    print(errror)
                    
                }
                
            }
            
        }
}
    
    
    
    func getCartCount() -> String {
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
    
   
}
