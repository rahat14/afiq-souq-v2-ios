//
//  ReviewListViewModel.swift
//  Afiq Souq
//
//  Created by GAMEKILLER on 4/24/21.
//

import Foundation

class ReviewListViewModel : ObservableObject {
    
    @Published var  list : [ReviewModel] = []
    @Published var isLoading : Bool = false
    @Published var totalRating : Double = 0.00
    @Published var p_id = 0
    
    init( id : Int ){
        
        loadAllReview(id: id)
        
    }
    
    
    func loadAllReview(id : Int  )  {
        p_id = id
        isLoading = true
        // here we load products
       
        
        NetworkManager.shared.getReviewList(for: id){
            [weak self] result in
            guard self != nil else {return}
            
            switch(result){
            case .success(let catList):
                // save the data"
                // self?.saveUser(user: userDeatils)
                
                //now fillter line items
                
               
                
                DispatchQueue.main.async { [self] in
                    self?.isLoading = false
                  
                        var totalRatings = 0
                        
                    self?.list.append(contentsOf: catList)
                    
                    for item in catList
                    {
                        totalRatings = totalRatings + (item.rating ?? 0 )
                        
                    }
                    
                    
                    if(Double(totalRatings) == 0 ){
                        self?.totalRating  = 0
                    }else {
                        self?.totalRating  = Double(totalRatings / catList.count)
                    }
                   
                        
                    }
                    
            case .failure( let error ):
                DispatchQueue.main.async {
                    self?.isLoading = false
                    print(error)
                    
                }
            }
                
                
           
            
        }
}

}
