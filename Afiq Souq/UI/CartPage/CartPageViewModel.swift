//
//  CartPageViewModel.swift
//  Afiq Souq
//
//  Created by GAMEKILLER on 4/11/21.
//

import Foundation
import RealmSwift

class CartPageViewModel: ObservableObject{
    
    @Published  var  couponList : [CouponModel] = []
     var  cartList: [CartDbMOdel] = []
    var  isloaded :  Bool = false
    var deliveryCharge : Double = 0
    @Published var  disCount : Double = 0
    @Published var isLoading : Bool = false
    @Published var showError : Bool  = false
    @Published var isCodeUsed : Bool = false
    @Published var msg : String  = ""
    
    func loadCartItems() -> [CartDbMOdel]   {
        
        
            do{
                let realm = try Realm()
                
             let ingredientResults = realm.objects(CartDbMOdel.self)
               
                
                cartList =  ingredientResults.map(CartDbMOdel.init)
                
          //      setData(cartList)
                
                print(cartList.count)
            
            }
            
            catch let error {
              // Handle error
                print(error.localizedDescription)
                cartList = []
            }
        
        
        return cartList
    }
    

    
    func getTotlaPrice() -> String   {
        
        let user = loadUser()
        
        var total_price : Double =  0.0
        
        
        for item  in cartList {
            
            total_price = total_price + (Double(item.quantity) * item.unit_price)
        }
        
        
        /// adding delivery price
        
        // Dhaka AND Chitagong is Same
        
        if(user?.billing.state.lowercased() == "dhaka" || user?.billing.state.lowercased() == "chittagong"){
            
            
            self.deliveryCharge = 60
            
        }else {
          
            self.deliveryCharge = 130
        }
        
    
     
       return String(total_price)
        
    }
    
    func getFinalTotlaPrice() -> String   {
        
     //   let user = loadUser()
        
        var total_price : Double =  0.0
        
        
        for item  in cartList {
            
            total_price = total_price + (Double(item.quantity) * item.unit_price)
        }
        
        
        /// adding delivery price
        
        
    
     
       return String(((total_price - disCount ) + deliveryCharge  ) )
        
    }
    
    
    
    func update(
      ingredientID: Int,
      quantity: Int
  ) {
      objectWillChange.send()
      do {
        let realm = try Realm()
        try realm.write {
          realm.create(
            CartDbMOdel.self,
            value: [
              "id": ingredientID,
              "quantity": quantity
            ],
            update: .modified)
            
            print("UPDATE")
        }
      } catch let error {
        // Handle error
        print(error.localizedDescription)
      }
    }
    
    func delete(cartId: Int) {
      // 1
      objectWillChange.send()
      // 2
        do {
            let realm = try Realm()
            
        let  cartList = realm.objects(CartDbMOdel.self)
            
      guard let ingredientDB = cartList.first(
        where: { $0.id == cartId })
        else { return }

        try realm.write {
          realm.delete(ingredientDB)
        print("delteed")
        }
      } catch let error {
        // Handle error
        print(error.localizedDescription)
      }
    }
    
    func loadCouponList(code : String ) {
        isLoading = true
        
        NetworkManager.shared.getCouponsCode(for: code.lowercased() ){result  in
            
            switch(result){
            case .success(let coupons):
                // save the data"
                // self?.saveUser(user: userDeatils)
                
            
                DispatchQueue.main.async {
                    
                  //  self.couponList.append(contentsOf: coupons)
                    self.isLoading = false
                    if(coupons.count > 0 ){
                        
                        self.showError = false
                        
                        let coupon = coupons[0]
                        
                       
                        
                        self.calucalateCoupon(item: coupon)
                        
                        
                    }else {
                        self.msg = "Coupon Code Not Found!!"
                        self.showError = true 
                        
                    }
                    
                   
                    
                }
                
                
            case .failure(let errror ):
                DispatchQueue.main.async {
                    print(errror)
                    self.isLoading = false
                }
                
            }
            
    }
        
        
    }
    func calucalateCoupon(item : CouponModel) {
        
        let  totalPrice  : Double = Double(getTotlaPrice()) ?? 0
        let minimumAmount : Double = Double((item.minimumAmount ?? "")) ?? 0
        
        if(totalPrice < minimumAmount ){
            self.showError = true
            self.msg = "To Avail this Coupon Please Spend at Least Bdt "  + (item.minimumAmount ?? "")
            self.isCodeUsed = false
        }else {
            
            self.disCount = Double( (item.amount ?? "0")) ?? 0
            
            self.isCodeUsed = true
        }
        
    }
    
//    func increment()  {
//        
//        qty = qty + 1
//        
//    }
//    
//    func decrement()  {
//        
//        if(qty > 1 ){
//            
//            qty = qty - 1
//        }
//        
//    }
    
    
    
}


