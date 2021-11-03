//
//  MasterViewController.swift
//  Afiq Souq
//
//  Created by GAMEKILLER on 5/10/21.
//

import Foundation
import  UIKit
import SwiftUI

//import  SSLCommerzSDK

class MasterViewController: UIViewController  {
  //  class MasterViewController: UIViewController,SSLCommerzDelegate  {
    
    // var ssl: SSLCommerz?
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @IBOutlet weak var back: UIButton!
    
    override func viewDidLoad() {
        
        
        
    }
    
    
    @IBAction func OnTap(_ sender: UIButton) {
        print("clics")
        
                let   pay = loadPayment()
        
                print(pay?.total ?? 3)
        
                let user =  paymnetMODEL.init(method: (pay?.method ?? NULL_METHOD ) , total: (pay?.total ?? 0 ), isPaid: true )
        
                print(user.total)
        
                savePayment(pay: user)
        
        
        //  UIHostingController( rootView: WalletUiIView())
        //_ = navigationController?.shouldPerformSegue(withIdentifier: <#T##String#>, sender: <#T##Any?#>)
        _ = navigationController?.popViewController(animated: true)
    }
//
//    func createPayment() {
//
//        ssl = SSLCommerz.init(integrationInformation: .init(storeID: "metac5c8299fbcbb15", storePassword: "metac5c8299fbcbb15@ssl",
//                                                            totalAmount: 1100.00, currency: "BDT", transactionId: "2343", productCategory: "asd"),
//                              emiInformation: nil, customerInformation: .init(customerName: "doe", customerEmail:
//                                                                                "ss@ss.com", customerAddressOne: "one", customerCity: "two", customerPostCode: "111",
//                                                                              customerCountry: "BD", customerPhone: "00000"), shipmentInformation: nil,
//                              productInformation: nil, additionalInformation: nil)
//
//
//        ssl?.delegate = self
//
//        ssl?.start(in: self, shouldRunInTestMode: true)
//    }
//
//    func transactionCompleted(withTransactionData transactionData: TransactionDetails?){
//
//        let   pay = loadPayment()
//
//        print(pay?.total ?? 3)
//
//        let user =  paymnetMODEL.init(method: (pay?.method ?? NULL_METHOD ) , total: (pay?.total ?? 0 ), isPaid: true )
//
//        print(user.total)
//
//        savePayment(pay: user)
//
//
//
//
//        _ = navigationController?.popViewController(animated: true)
//    }
    
}
