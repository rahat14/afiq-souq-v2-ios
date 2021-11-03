//
//  AddressPaymentViewModel.swift
//  Afiq Souq
//
//  Created by GAMEKILLER on 4/12/21.
//

import Foundation
import RealmSwift
import SSLCommerzSDK
import UIKit
class AddressPaymentViewModel: ObservableObject , SSLCommerzDelegate {
    //class AddressPaymentViewModel: ObservableObject{
    var ssl: SSLCommerz?
    var totalAmount : Double = 0.0
    var delivery_address : String = ""
    var name  : String = ""
    var ph : String = ""
    var user : CustomerDetailsResponse? = nil
    var cartList : [CartDbMOdel] = []
    @Published var showPaymentBox : Bool = false
    @Published var msg : String = ""
    @Published var ErrorMsg : String = ""
    @Published var ShowError : Bool = false
    @Published var isLoading: Bool = false
    var walletBal : Double   = 0
    var cartTotal : Double = 0
    var CouponCode : String = ""
    var iCodeUsed : Bool = false
    @Published var canPayment : Bool = false
    @Published var triggerNext : Int?  =  0
    @Published var transId  : Int  =  0 
    
    init(total_amount : String , isCodeUsed : Bool , code : String) {
        
        self.totalAmount = Double(total_amount) ?? 0.0
        self.CouponCode = code
        self.iCodeUsed = isCodeUsed
        getDeliveryAddress()
        
    }
    
    
    func getDeliveryAddress()  {
        // load the delivery address for the cache
        
        //print(loadedPerson)
        
        let loadedPerson : CustomerDetailsResponse? = loadUser()
        
        
        user = loadedPerson
        
        delivery_address =  loadedPerson?.shipping.address1 ?? ""
        
        name = (loadedPerson?.firstName ?? " ") + (loadedPerson?.lastName ?? ""  )
        
        ph = loadedPerson?.billing.phone ?? " "
        
        print("data " + delivery_address)
        
        
        
        
        
        //  return delivery_address
    }
    
    
    // isPaid Refers to  COD if value set to false
    // isPaid Refers to Paid if Value set to true
    
    func CreateOrder(isPaid : Bool , method : String  ){
        
        // load cart from cache
        
        
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
        
        
        if(cartList.isEmpty){
            
            // notify the UI  the problem
            
        }else {
            self.isLoading  = true
            // go with the order create
            var productList : [pItem]  = []
            
            for item in cartList {
                
                let singleOrder : pItem = pItem.init(productID: item.product_id, quantity: item.quantity, variationID: 0 )
                
                productList.append(singleOrder)
            }
            
            var order  : CreateOrderModel
            var couposList : [CouponLine] = []
            var shippinigList : [ShippingLine] = []
            var ship : ShippingLine
            let user = loadUser()
            if(user?.billing.state.lowercased() == "dhaka" || user?.billing.state.lowercased() == "chittagong"){
                
                //60
                
                shippinigList.append(ShippingLine.init(methodID: "flat_rate", methodTitle: "Flat rate", total: "60"))
                
                
            }else {
                
                // 130
                
                shippinigList.append(ShippingLine.init(methodID: "flat_rate", methodTitle: "Flat rate", total: "130"))
            }
            
            
            if(iCodeUsed == true ){
                
                // create co
                let  coupons :  CouponLine  =  CouponLine.init(code: CouponCode.lowercased())
                
                couposList.append(coupons)
                
                order  =
                    CreateOrderModel.init(customerID: String(user?.id ?? 0 ), status: "pending", paymentMethod: nil, paymentMethodTitle: method, setPaid: isPaid, billing: user?.billing, shipping: user?.shipping, lineItems: productList  , couponLines: couposList , shippingLines: shippinigList)
            }else {
                
                
                order  =
                    CreateOrderModel.init(customerID: String(user?.id ?? 0 ), status: "pending", paymentMethod: nil, paymentMethodTitle: method, setPaid: isPaid, billing: user?.billing, shipping: user?.shipping, lineItems: productList  , couponLines: nil , shippingLines: shippinigList)
            }
            
            
            
            
            NetworkManager.shared.CreateOrder(for: order){
                
                [weak self] result in
                guard self != nil else {return}
                
                switch(result){
                case .success(let order ):
                    // save the data
                    // self?.saveUser(user: userDeatils)
                    
                    self?.sendMsg(Ordernumber: order.id ?? 0 )
                    
                    DispatchQueue.main.async {
                        
                        
                        
                        self?.transId = order.id ?? 0
                        
                        self?.isLoading = false
                        
                        self?.triggerNext = 1
                        self?.ShowError = false
                        
                        
                    }
                    
                case .failure(let errror ):
                    DispatchQueue.main.async {
                        print(errror)
                        self?.isLoading = false
                        
                        self?.ErrorMsg = "Order Failed If You Used Coupon then Coupon Limit Exceed "
                        self?.ShowError = true
                        
                    }
                    
                }
                
            }
            
            
        }
        
        
    }
    
    
    func sendMsg(Ordernumber : Int ) {
        
        
        let num = user?.billing.phone ?? ""
        
        let msg = "Dear Customer, Your Order number " + String(Ordernumber) + " has been processed successfully.  Thank you for choosing AfiqSouq.Com services.Contact: 01833346966 Email:customercare@afiqsouq.com"
        
        
        // ask for otp
        let session = URLSession.shared
        let stringUrl = "http://66.45.237.70/api.php?username=afiqsouq2021&password=12afiqsouq3434$&number=" + num + "&message=" + msg
        let url = URL(string: stringUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let task = session.dataTask(with: url) { data, response, error in
            if error != nil {
                // OH NO! An error occurred...
                // handle error here
                
                return
            }
            
        }
        
        task.resume()
    }
    
    
    func createPayment() {
        
        
        let user = loadUser()
        
        let  transID = currentTimeInMilliSeconds()
        
        ssl = SSLCommerz.init(integrationInformation: .init(storeID: STORE_ID, storePassword: STORE_PASS,
                                                            totalAmount: totalAmount, currency: "BDT", transactionId: transID, productCategory: "product"),
                              emiInformation: nil, customerInformation: .init(customerName: user?.firstName ?? "cus", customerEmail:
                                                                                user?.email ?? "cus", customerAddressOne: user?.billing.address1 ?? "cus", customerCity: user?.billing.city ?? "cus", customerPostCode: "111",
                                                                              customerCountry: "BD", customerPhone: user?.billing.phone ?? "cus"), shipmentInformation: nil,
                              productInformation: nil, additionalInformation: nil)
        
        
        ssl?.delegate = self
        
        ssl?.start(in: (UIApplication.shared.windows.first?.rootViewController)!, shouldRunInTestMode: false)
        
    }
    
    func transactionCompleted(withTransactionData transactionData: TransactionDetails?){
        
        //    let   pay = loadPayment()
        
        //    print(pay?.total ?? 3)
        
        //  let user =  paymnetMODEL.init(method: (pay?.method ?? NULL_METHOD ) , total: (pay?.total ?? 0 ), isPaid: true )
        
        //print(user.total)
        
        // savePayment(pay: user)
        
        
        CreateOrder(isPaid: true, method: "ssl")
        
    }
    
    
    
    
    func loadWalletBal(){
        
        self.isLoading = true
        
        
        let usr : CustomerDetailsResponse? = loadUser()
        
        NetworkManager.shared.getWalletBallence(for: usr?.id ?? 0 ){result  in
            
            switch(result){
            case .success(let wallentBALANCE):
                // save the data"
                // self?.saveUser(user: userDeatils)
                
                
                DispatchQueue.main.async {
                    
                    let  walletBal = wallentBALANCE.replacingOccurrences(of: "\"", with: "")
                    
                    self.walletBal = Double(walletBal) ?? 0.0
                    
                    
                    
                    
                    if(self.walletBal >= self.totalAmount){
                        // we can show the payment dialogue
                        self.canPayment = true
                        
                        self.msg = "Would You like to Pay Total Of " + String(self.totalAmount) + " Bdt\n Your Current Balance is " + wallentBALANCE + " BDT."
                        
                        
                    }else {
                        // he cant pay he is low
                        self.canPayment = false
                        print(self.canPayment)
                        self.msg = "You Don't Have Enough Balance in your wallet. You Have only BDT: " + wallentBALANCE + "."
                    }
                    
                    self.isLoading = false
                    
                    self.showPaymentBox  = true
                    
                }
                
                
            case .failure(let errror ):
                DispatchQueue.main.async {
                    print(errror)
                    self.isLoading = false
                }
                
            }
            
        }
        
        
    }
    
    
    // MARK: create SSL CALL
    
    
    func createSSLCommerceCall(){
        
    }
    
    func AdjustWalletBalance( ){
        
        self.isLoading = true
        
        let amount : String = String(totalAmount)
        
        let usr : CustomerDetailsResponse? = loadUser()
        
        NetworkManager.shared.adjustWalletBalance(for: usr?.id ?? 0 , amount: amount, type: "debit", details: "product_purchased"){result  in
            
            switch(result){
            case .success(let wallentBALANCE):
                // save the data"
                // self?.saveUser(user: userDeatils)
                
                
                DispatchQueue.main.async {
                    
                    //self.isLoading = false
                    
                    if(wallentBALANCE.response?.lowercased() == "success"){
                        
                        self.CreateOrder(isPaid: true , method: "wallet")
                        print("Xreating Order here  ")
                        
                    }else {
                        self.isLoading = true
                        print("error in respnse ")
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
    
    
}


