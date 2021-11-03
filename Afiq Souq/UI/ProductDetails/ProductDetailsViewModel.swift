//
//  ProductDetailsViewModel.swift
//  Afiq Souq
//
//  Created by GAMEKILLER on 4/10/21.
//

import Foundation
import RealmSwift

class ProductDetailsViewModel: ObservableObject{
    
    @Published  var singleProductItem : Product
    var unitPrice : Double = 0.0
    @Published var  qty : Int = 1
    @Published var showError : Bool = false
    @Published var CartCount : String = "0"
    var imageList : [String] = []
    var imageLINK : String = ""
    var nextPage : Int? = 0
    var details : String = ""
    
    init(product : Product) {
        self.singleProductItem = product
        
        //prinData())
        //   getCartItems()
        loadImageList(item: product)
        
    }
    
    //    init(realm: Realm) {
    //      ingredientResults = realm.objects(IngredientDB.self)
    //        .filter("bought = false")
    //      boughtIngredientResults = realm.objects(IngredientDB.self)
    //        .filter("bought = true")
    //    }
    func loadImageList(item: Product) {
        getCartCount()
        let productImageArray : [ProductImage] = item.images ?? []
        
        for item in productImageArray{
            
            imageList.append(item.src ?? "")
            imageLINK = item.src ?? ""
        }
        
        
        
       // print(imageLINK)
        
        
    }
    func addToCart(isBuyNow : Bool)  {
        
        // add to  relam offline databae
        objectWillChange.send()
        
        do {
            let realm = try Realm()
            
            let cartDb = CartDbMOdel()
            cartDb.id = UUID().hashValue
            cartDb.title = singleProductItem.name ?? ""
            cartDb.image = singleProductItem.images?[0].src ?? "image"
            cartDb.quantity = qty
            cartDb.var_id = 0
            cartDb.product_id = Int(singleProductItem.id ?? 0 )
            cartDb.stock_limit_qty = 0
            cartDb.unit_price  = unitPrice
            cartDb.sub_total  = (unitPrice * Double(qty))
            
            try realm.write {
                realm.add(cartDb)
            }
            getCartCount()
            if(isBuyNow){
                // trigger next page
                nextPage = 1
            }
            
            
        } catch let error {
            // Handle error
            print(error.localizedDescription)
        }
        
    }
    
    func increment()  {
        
        qty = qty + 1
        
    }
    
    func decrement()  {
        
        if(qty > 1 ){
            
            qty = qty - 1
        }
        
    }
    
    func  getProductPrice()-> String {
        var  price = ""
        
        
        if(singleProductItem.salePrice == "" || ((singleProductItem.salePrice?.isEmpty) != nil) ){
            
            price = singleProductItem.salePrice ?? "0"
            unitPrice = Double(price) ?? 0.0
            
        }else {
            price = singleProductItem.price ?? "0"
            
            unitPrice = Double(price) ?? 0.0
        }
        
        
        return price
        
    }
    
    
    //    func getCartItems() {
    //
    //
    //        // 2
    //        do{
    //            let realm = try Realm()
    //
    //         let ingredientResults = realm.objects(CartDbMOdel.self)
    //
    //            print(ingredientResults)
    //
    ////            // 3
    ////            boughtIngredientResults = realm.objects(IngredientDB.self)
    ////              .filter("bought = true")
    //        }
    //        catch let error {
    //          // Handle error
    //            print(error.localizedDescription)
    //        }
    //    }
    
    
    
    func CheckIfProductExists(id : String )  {
        
        
        // 2
        do{
            let realm = try Realm()
            
            let ingredientResults = realm.objects(CartDbMOdel.self).filter("product_id == " + id)
            
            if(ingredientResults.count > 0){
                
                print("Item Exists")
                
                self.showError = true
                
            }else {
                // insert data
                
                addToCart(isBuyNow:  false)
                
            }
            
            //            // 3
            //            boughtIngredientResults = realm.objects(IngredientDB.self)
            //              .filter("bought = true")
        }
        catch let error {
            // Handle error
            print(error.localizedDescription)
        }
        
    }
    
    
    func getCartCount() {
        var cartList : [CartDbMOdel] = []
        
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
        
        self.CartCount =  String(cartList.count)
    }
    
    
}
