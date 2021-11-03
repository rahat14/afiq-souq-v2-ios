//
//  OldOrdeListViewModel.swift
//  Afiq Souq
//
//  Created by GAMEKILLER on 4/19/21.
//

import Foundation

class oldOrderListViewModel: ObservableObject{
    
    @Published var  isLoading : Bool = false
    @Published var oldCartModelList : [OldCartModel] = []
    
    init(){
        loadAllOldOrderList()
    }
    
    func loadAllOldOrderList()  {
        isLoading = true
        // here we load products
        let uuser :  CustomerDetailsResponse? = loadUser()
        
        NetworkManager.shared.getOldOrderList(for: uuser?.id ?? 0  ){
            [weak self] result in
            guard self != nil else {return}
            
            switch(result){
            case .success(let catList):
                // save the data"
                // self?.saveUser(user: userDeatils)
                
                DispatchQueue.main.async { [self] in
                    self?.isLoading = false
                    self?.oldCartModelList = catList
                    
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
