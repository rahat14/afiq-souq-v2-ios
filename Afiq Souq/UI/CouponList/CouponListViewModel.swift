//
//  CouponListViewModel.swift
//  Afiq Souq
//
//  Created by GAMEKILLER on 4/19/21.
//

import Foundation

class CouponListViewModel: ObservableObject {
    
    @Published  var  couponList : [CouponModel] = []
    @Published var  isLoading : Bool = false
    
    init(){
        loadCouponList()
    }
    
    func loadCouponList() {
        isLoading = true
        
        NetworkManager.shared.getCouponsList(){result  in
            
            switch(result){
            case .success(let coupons):
                // save the data"
                // self?.saveUser(user: userDeatils)
                
            
                DispatchQueue.main.async {
                    
                    self.couponList.append(contentsOf: coupons)
                    self.isLoading = false
                    
                   
                    
                }
                
                
            case .failure(let errror ):
                DispatchQueue.main.async {
                    print(errror)
                    self.isLoading = false
                }
                
            }
            
    }
        
        
    }
    
    
}
