//
//  LoginViewModel.swift
//  Afiq Souq
//
//  Created by GAMEKILLER on 3/5/21.
//

import Foundation
import Combine
class LoginViewModel: ObservableObject{
    @Published var mail : String = ""
    @Published var pass : String = ""
    @Published var prompt : String = ""
    @Published var isLoading : Bool = false
    @Published var showAlert : Bool = false
    @Published var triggerDashBoard: Int? = 0
     var isLogin : Bool = false
    
    
    private var loginSubscriber: AnyCancellable? = nil
    
    let session = URLSession(configuration: .default)
    
    deinit {
        loginSubscriber?.cancel()
    }
    // checking the data is valid
    func isValidData() -> Bool {
        
        if(!mail.isEmpty && !pass.isEmpty){
            
            // make the network calll
            prompt = ""
            return true
        }else {
            // data is empty
             prompt = "please Fill The Data Properly"
            showAlert = true 
            return false
        }
        
        
    }
    
    func SignUp() {
        prompt =  ""
        if(isValidData()){
            isLoading = true
            // Trigger network call here
            self.loginSubscriber = self.doSignIn()?
                .sink(receiveCompletion: {completion in
                    switch completion {
                    case.finished:
                        break
                    case .failure(let error) : if(error.localizedDescription.contains("data")){
                        self.isLoading = false
                        self.prompt = "User Not Found"
                        self.showAlert = true
                    }
                    else {
                        
                        self.isLoading = false
                        self.prompt = error.localizedDescription
                    
                        self.showAlert = true
                    }
                    }
                }, receiveValue: {
                    LoginResponse in
                    if LoginResponse == nil  {
                        
                    }
                    else {
                       // print(LoginResponse.user)
                        DispatchQueue.main.async {
                            self.isLoading = true
                           
                        }
                        self.getTheDeatilsForUser(id: LoginResponse.user.id)
                        //TODO makeCallForDetils
                        
                        
                    }
                })
            
            
            
            
        }
        else {
            prompt = "Data is empty"
        }
        
    }
    
    func doSignIn()-> AnyPublisher<LoginResponse, Error>? {
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
    
    func getTheDeatilsForUser(id : Int)  {
        
        NetworkManager.shared.getUserInfo(for: id) {
            [weak self] result in
            guard self != nil else {return}
            
            switch(result){
            case .success( let userDeatils):
                print("Billing  adress Details -> " + userDeatils.billing.address1 )
                // save the data
                self?.saveUser(user: userDeatils)
            case .failure(let errror ):
                
                self?.isLoading = false
                print(errror)
            }
        }
}
    func saveUser(user : CustomerDetailsResponse) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(user) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "user")
        }
        
        DispatchQueue.main.async {
            self.isLoading = false
            
            self.triggerDashBoard = 11 
           
        }
    }
    
    func loadUser() -> CustomerDetailsResponse? {
        let defaults = UserDefaults.standard
        if let savedPerson = defaults.object(forKey: "user") as? Data {
            let decoder = JSONDecoder()
            if let loadedPerson = try? decoder.decode(CustomerDetailsResponse.self, from: savedPerson) {
                print(loadedPerson)
                return loadedPerson
            }else {
                
                return nil
            }
        }
        else {
            return nil
        }
        
        
        
    }
    
    func isUserLogin() -> Bool {
         let user = loadUser()
        if(user == nil){
            
            isLogin = false
            
        }else {
            isLogin = true
        }
        
        return isLogin  
    }
    
   
}
