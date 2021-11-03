//
//  WalletViewModel.swift
//  Afiq Souq
//
//  Created by GAMEKILLER on 4/20/21.
//

import Foundation
import SSLCommerzSDK
import UIKit
class WalletViewModel : ObservableObject , SSLCommerzDelegate  {
    //class WalletViewModel : ObservableObject   {
    @Published var walletItemList : [WalletItem] = []
    @Published var isLoading : Bool  = false
    @Published var is_Loading : Bool  = false
    @Published var  walletNumber : String = ""
    @Published var isWorking : Bool =  false
    @Published var isTriggerNextPage : Bool =  false
    @Published var showPaymentBox : Bool = false
    var amount_ : Int = 0
    var ssl: SSLCommerz?
    var userID : Int = 0
    
    init(){
        loadWalletItems()
        loadWalletBal()
    }
    
    func loadWalletItems(){
        
        let user : CustomerDetailsResponse? = loadUser()
        
        userID = user?.id ?? 0
        
        
        isLoading = true
        
        NetworkManager.shared.getWalletItemList(for: userID){result  in
            
            switch(result){
            case .success(let trans):
                // save the data"
                // self?.saveUser(user: userDeatils)
                
                DispatchQueue.main.async {
                    
                    self.walletItemList.append(contentsOf: trans)
                    
                }
                
                
            case .failure(let errror ):
                DispatchQueue.main.async {
                    print(errror)
                    self.isLoading = false
                }
                
            }
            
        }
        
        
    }
    func loadWalletBal(){
        
        isLoading = true
        
        NetworkManager.shared.getWalletBallence(for: userID){result  in
            
            switch(result){
            case .success(let wallentBALANCE):
                // save the data"
                // self?.saveUser(user: userDeatils)
                
                
                DispatchQueue.main.async {
                    
                    self.walletNumber = wallentBALANCE
                    print(wallentBALANCE)
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
    
    
    
    
    func AdjustWalletBalance(amount : Int){
        
        self.is_Loading = true
        
        let amount : String = String(amount)
        
        let usr : CustomerDetailsResponse? = loadUser()
        
        NetworkManager.shared.adjustWalletBalance(for: usr?.id ?? 0 , amount: amount, type: "credit", details: "product_purchased"){result  in
            
            switch(result){
            case .success(let wallentBALANCE):
                // save the data"
                // self?.saveUser(user: userDeatils)
                
                
                DispatchQueue.main.async {
                    
                    //self.isLoading = false
                    
                    if(wallentBALANCE.response?.lowercased() == "success"){
                        
                        
                        let newPayment = paymnetMODEL.init(method: NULL_METHOD , total: -10, isPaid: false)
                        
                        savePayment(pay: newPayment)
                        
                        self.is_Loading = false
                        
                        self.loadWalletBal()
                        
                    }else {
                        self.is_Loading = false
                        print("error in respnse ")
                    }
                    
                    
                    
                }
                
                
            case .failure(let errror ):
                DispatchQueue.main.async {
                    print(errror)
                    self.is_Loading = false
                }
                
            }
            
        }
        
        
    }
    
    
    func createPayment(amount : Double) {
        
        amount_ = Int(amount)
        
        
        let user = loadUser()
        
        let  transID = currentTimeInMilliSeconds()
        
        ssl = SSLCommerz.init(integrationInformation: .init(storeID: STORE_ID, storePassword: STORE_PASS,
                                                            totalAmount: amount, currency: "BDT", transactionId: transID, productCategory: "wallet"),
                              emiInformation: nil, customerInformation: .init(customerName: user?.firstName ?? "cus", customerEmail:
                                                                                user?.email ?? "cus", customerAddressOne: user?.billing.address1 ?? "cus", customerCity: user?.billing.city ?? "cus", customerPostCode: "111",
                                                                              customerCountry: "BD", customerPhone: user?.billing.phone ?? "cus"), shipmentInformation: nil,
                              productInformation: nil, additionalInformation: nil)
        
        
        ssl?.delegate = self
        
        ssl?.start(in: (UIApplication.shared.windows.first?.rootViewController)!, shouldRunInTestMode: false)
    }
    
    func transactionCompleted(withTransactionData transactionData: TransactionDetails?){
        
        
        AdjustWalletBalance(amount: amount_)
        
    }
    
    
    
    
    
    
}


