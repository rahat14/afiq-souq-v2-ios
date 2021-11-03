//
//  ResetPasswordViewModel.swift
//  Afiq Souq
//
//  Created by GAMEKILLER on 4/21/21.
//

import Foundation
import Combine

class ResetPassWordViewViewModel : ObservableObject {
    var alertProvider = AlertProvider()
    
    @Published var oldPass : String = ""
    @Published var newPass : String = ""
    @Published var cofirmPass : String = ""
    
    @Published var  msg : String = ""
    
    @Published var isPassError : Bool = false
    
    @Published var isPassChanged : Bool = false
    
    @Published var isLoading  : Bool = false
     var userId = 00
    
    
    private var loginSubscriber: AnyCancellable? = nil
    
    let session = URLSession(configuration: .default)
    
    deinit {
        loginSubscriber?.cancel()
    }
    
    
    func checkAllPass(){
        
        let user : CustomerDetailsResponse? = loadUser()
        
        userId = user?.id ?? 0 
        
        // 1st try to login with the user
        if(cofirmPass.isEmpty || newPass.isEmpty || oldPass.isEmpty){
            
            self.msg = "Your Both New Password Need To Be Same!!"
            self.isPassError = true
           
        }
        
      else if(cofirmPass == newPass  ){
        
            isLoading = true
            // triggir login
            // Trigger network call here
            self.loginSubscriber = self.doSignIn(mail: (user?.email ?? "" ) , pass: oldPass )?
                .sink(receiveCompletion: {completion in
                    switch completion {
                    case.finished:
                        break
                    case .failure(let error) : if(error.localizedDescription.contains("data")){
                        self.isLoading = false
                        self.isPassError = true
                        self.msg = "Your Old  Password is Worng "
                    }
                    else {
                        
                        self.isLoading = false
                        self.msg = error.localizedDescription
                    }
                    }
                }, receiveValue: {
                    LoginResponse in
                   
                       // print(LoginResponse.user)
                        DispatchQueue.main.async {
                          
                           
                            var user = "u"
                            user = LoginResponse.status ?? "u"
                            
                            
                            
                            if(user == "u"){
                                
                                self.isLoading = false
                                self.isPassError = true
                                self.msg = "your Old Password Is Worng"
                            }else {
                                self.isLoading = true
                                self.resetPassword()
                                
                            }
                        
                        
                      
                        //TODO makeCallForDetils
                        
                        
                    }
                })
            
            
        
            
            
        }
        
        else {
           
            DispatchQueue.main.async {
                self.msg = "Your Both New Password Need To Be Same!!"
                self.isPassError = true
               
            }
          
            
        }
        

    }
    
    func doSignIn(mail : String , pass : String )-> AnyPublisher<LoginResponse, Error>? {
        print(Paths.host)
        

        // show loader
        
        let urlComponents = URLComponents(string: Paths.host+Paths.Login_Path)
        
        
        var req = getCommonUrlRequest(url: (urlComponents?.url)!)
        req.httpMethod = "POST"
        let body = "username=\(mail)&password=\(pass)"
        req.httpBody = body.data(using: .utf8)
        
        
        print(req.url ??  "teest ")
        
        // calin
        return  session.dataTaskPublisher(for: req).handleEvents(
            receiveSubscription: {_ in
                print("we loading.....")
            }, receiveOutput: {_ in
                print("data  Recived !!")
            }, receiveCompletion: {
                _ in
                print("data  Recived  Done !!")
            }, receiveCancel: {
                print("cancel")
            })
            .tryMap{ data, response ->
                Data in guard
                    let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200
            else {
                    let res = response as? HTTPURLResponse
                    
                    print(res?.statusCode ?? 44)
                    
                    
                    throw NetworkApiService.APIFailureCondition.InvalidServer
            }
            
          

            
            return data
            }
            .retry(1)
            .decode(type: LoginResponse.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
        
        
        
        
        
        
        
        
        
        
        
    }
    
    
    
    func resetPassword() {
                 
        NetworkManager.shared.UpdatePassword(for: userId , new_password: newPass ){result  in
            
           
            switch(result){
            case .success( _):
                // save the data"
                // self?.saveUser(user: userDeatils)
                
                DispatchQueue.main.async {
                    
                    self.isLoading = false
                    self.isPassChanged = true
                    
                        
               
                    
                }
                
                
            case .failure(let errror ):
                DispatchQueue.main.async {
                    print(errror)
                    self.isLoading = false
                    self.msg = "Something Went Wrong Try Again"
                    self.isPassError = true
                    
                    
                }
                
            }
            
    }
        
    }
    
    
    
}
