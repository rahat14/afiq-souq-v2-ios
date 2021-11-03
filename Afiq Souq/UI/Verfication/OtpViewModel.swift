//
//  OtpViewModel.swift
//  Afiq Souq
//
//  Created by GAMEKILLER on 3/27/21.
//

import Foundation
import Firebase
class OtpViewModel: ObservableObject {
    @Published var otp : String = ""
    var userModel : RegRespSend?
    var otpCode : String = "000"
    @Published var isError : Bool  = false
    @Published var isLoading : Bool = false
    @Published var triggerNextPage : Int? = 0
    @Published var errorMsg = "Error Happend !! Check Data You Entered !!!"
    @Published var countryCode : String = ""
    
    init(user : RegRespSend?) {
        self.userModel = user
        prinData()
        
    }
    
    func  prinData() {
        
        if(userModel == nil ){
            //print("Model is Empty ")
        }
        else {
            self.sendOtp()
        }
    }
    
   
    
    func verifyFirebaseCode()  {
        
        let verificationID = UserDefaults.standard.string(forKey: "authVerificationID") ?? self.otpCode
        print("verofocat -> " + verificationID)
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: self.otp)
        
        self.isLoading = true
        Auth.auth().signIn(with: credential){
            (result , err ) in
            if let error = err {
                self.isLoading = false
                print("" + error.localizedDescription)
                self.isError = true
                self.errorMsg = error.localizedDescription
                return
            }
                self.doRegistration()
            
            
       
        }
    }
    
    func sendOtp()  {
        Auth.auth().settings?.isAppVerificationDisabledForTesting = false
        
        let number = userModel?.billing.phone ?? ""    //"+8801516185792"
        
        PhoneAuthProvider.provider().verifyPhoneNumber(number, uiDelegate: nil ){ (CODE, err) in
            
            if let eror  = err{
                self.isError = true
                print("sending Error " + eror.localizedDescription)
                self.errorMsg = eror.localizedDescription
                return
            }
            self.otpCode = CODE ?? ""
            
            UserDefaults.standard.set(CODE, forKey: "authVerificationID")
            print("CODE" + self.otpCode)
            
        
        }
        
        
    }
    
    func sentOtp() {
        otpCode = generateRandomNumber(numDigits: 5)
        
        let num = (userModel?.billing.phone ?? "" )
        
        // ask for otp
        let session = URLSession.shared
        let stringUrl = "http://66.45.237.70/api.php?username=afiqsouq2021&password=12afiqsouq3434$&number=" + num + "&message=afiqsouq.com OTP is " + otpCode
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
    
    
    func generateRandomNumber(numDigits : Int ) -> String{
        var place = 1
        var finalNumber = 0;
        for _ in 1...numDigits{
            place *= 10
            let randomNumber = arc4random_uniform(10)
            finalNumber += Int(randomNumber) * place
        }
        
        return String(finalNumber)
    }
    
    func checkOtp() {
        if(otp == otpCode){
      
          doRegistration()
//            let jsonData = try! JSONEncoder().encode(userModel)
//            let jsonString = String(data: jsonData, encoding: .utf8)!
//            print(jsonData)
//            print(jsonString)
            
        }else {
            print("Code DIDNOT MATCH")
        }
    }
    
    func doRegistration() {
        print("registering....")
        isLoading = true
        NetworkManager.shared.RegisterUser(for: userModel!){
            
            [weak self] result in
            guard self != nil else {return}
            
            switch(result){
            case .success( let u ):
                // save the data
                // self?.saveUser(user: userDeatils)
              
                DispatchQueue.main.async {
                    
//                    let use = CustomerDetailsResponse.init(id: u.id, dateCreatedGmt: "", dateModified: "", dateModifiedGmt: "", email: u.email, firstName: userModel?.firstName, lastName: userModel?.lastName, role: u.role, username: u.username, billing: userModel?.billing, shipping: userModel?.shipping)
                    
                    var data : CustomerDetailsResponse = u
                    
                    data.billing.address1 = self?.userModel?.billing.address1 ?? ""
                    
                    let use =  CustomerDetailsResponse.init(id: u.id , dateCreatedGmt: "", dateModified: "", dateModifiedGmt: "", email: u.email, firstName: self?.userModel?.firstName ?? "" , lastName: self?.userModel?.lastName ?? "", role: u.role, username: u.username, billing: data.billing, shipping: data.billing)
                  
                    self?.saveUser(user: use)
                }
                
            case .failure(let errror ):
                DispatchQueue.main.async {
                    self?.isLoading = false
                    self?.isError =     true
                    self?.errorMsg = errror.localizedDescription
                   
                }
                print(errror)
            }
            
        }
        
    }
    func  CalltrggerNextPage() {
        self.isLoading = false
        self.triggerNextPage = 1
    
    }
    
    func saveUser(user : CustomerDetailsResponse) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(user) {
            let defaults = UserDefaults.standard
            print(encoded)
            defaults.set(encoded, forKey: "user")
        }
        
        DispatchQueue.main.async {
            self.CalltrggerNextPage()
           
        }
    }
    
    
    
}
