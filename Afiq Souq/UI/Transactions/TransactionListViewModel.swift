//
//  TransactionListViewModel.swift
//  Afiq Souq
//
//  Created by GAMEKILLER on 4/22/21.
//

import Foundation

class TransactionListViewModel: ObservableObject{
    
    @Published var  items : [LineItem] = []
    
    @Published var isLoading  : Bool = false
    
    var orderModels : [OldCartModel] = []
    
    
    
    
    init(){
        loadAllOldOrderList()
    }
    
    func loadAllOldOrderList()  {
        isLoading = true
        // here we load products
        let user : CustomerDetailsResponse? = loadUser()
        
        NetworkManager.shared.getOldOrderList(for: user?.id ?? 0){
            [weak self] result in
            guard self != nil else {return}
            
            switch(result){
            case .success(let catList):
                // save the data"
                // self?.saveUser(user: userDeatils)
                
                //now fillter line items
                
               
                
                DispatchQueue.main.async { [self] in
                    self?.isLoading = false
                    self?.orderModels = catList
                    
                    for item in catList{
                        
                        for it in item.lineItems{
                            
                            it.sku = item.dateCreated
                            
                        }
                        
                        
                        
                        self?.items.append(contentsOf: item.lineItems)
                      
                        
                    }
                    
                }
                
                
            case .failure(let errror ):
                DispatchQueue.main.async {
                    self?.isLoading = false
                    print(errror)
                    
                }
                
            }
            
        }
}
    
}
