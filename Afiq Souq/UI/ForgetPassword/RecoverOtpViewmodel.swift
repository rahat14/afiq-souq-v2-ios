//
//  RecoverOtpViewmodel.swift
//  Afiq Souq
//
//  Created by GAMEKILLER on 4/25/21.
//

import Foundation

class RecoverOtPViewModel: ObservableObject {
    
    @Published  var userEnteredOtp : String = ""
    @Published  var OTP : String = ""
    @Published var triggerNextPage : Int? = 0
    @Published var isLoading : Bool = false
    @Published var showError  : Bool = false
    @Published var msg : String = ""
    @Published var newPassword : String = ""
    @Published var showAlert  : Bool = false
    var userId : Int  = 0
    
    init(id : Int ){
        sentOtp()
        userId = id
        //print(userId)
    }
    
    func sentOtp() {
        OTP = generateRandomNumber(numDigits: 5)
        let num = "01516185792"
        
        // ask for otp
        let session = URLSession.shared
        let stringUrl = "http://66.45.237.70/api.php?username=afiqsouq2021&password=12afiqsouq3434$&number=" + num + "&message=afiqsouq.com OTP is " + OTP
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
        
        
        if(OTP == userEnteredOtp){
      
       //   doRegistration()
            self.showAlert = true 
            //resetPassword()
            
        }else {
            
            self.showError = true
            self.msg = "Code Does Not Match !!!"
        }
    }
    
    
    func resetPassword() {
        
        self.isLoading = true
        
                 
        NetworkManager.shared.UpdatePassword(for: userId , new_password: newPassword ){result  in
            
           
            switch(result){
            case .success( let data ):
                // save the data"
                // self?.saveUser(user: userDeatils)
                
                DispatchQueue.main.async {
                    
                    self.isLoading = false
                    self.triggerNextPage = 1
                    
                    //print(data.id )

                }
                
                
            case .failure(let errror ):
                DispatchQueue.main.async {
                    print(errror)
                    self.isLoading = false
                    self.msg = "Something Went Wrong Try Again"
                    self.showError = true
                    
                    
                }
                
            }
            
    }
        
    }
}
