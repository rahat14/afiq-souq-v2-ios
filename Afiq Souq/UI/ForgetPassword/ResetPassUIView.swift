//
//  ResetPassUIView.swift
//  Afiq Souq
//
//  Created by GAMEKILLER on 4/24/21.
//

import SwiftUI

struct ResetPassUIView: View {
    
    @State var isLoading : Bool = false
    @State var showError  : Bool = false
    @State var msg : String = "Please Enter Your Email Address"
    @State var email : String = ""
    @State var triggerNextPage : Int? = 0
    @State var  USER_ID : Int? = 0
    @State var   customer : CustomerDetailsResponse? = nil
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        VStack{
    
                ZStack{
                    VStack{
                       
                        HStack{
                            
                            Button(action: {
                                
                                
                                self.presentation.wrappedValue.dismiss()
                                
                                
                            }) {
                                HStack {
                                    
                                    Image(systemName: "arrow.left")
                                        .font(.title3)
                                        .foregroundColor(Color(cyanColor))
                                    
                                }
                                
                            }
                            
                            Spacer()
                            
                            Text("Forget Password")
                                .font(Font.custom("sf_pro", size: 17))
                                .lineLimit(1)
                            
                            
                            Spacer()
                            
                          
                                
                            
                        }.padding([.leading , .trailing , .top] , 5)
                        .frame(height: 40 , alignment: .center).background(Color(.white))
                        VStack{
                            Image("lock")
                            
                                .resizable()
                                .frame(maxWidth: 80 ,
                                       maxHeight: 100).padding(.bottom,4)
                                .padding(.top , 10)
                                .padding(.bottom, 10)
                                
                                
                            
                            Text("Forget Password ? ")
                                .font(.system(size: 20))
                                .bold()
                                .foregroundColor(Color(cyanColor))
                                .padding(10)
                            
                            Text("Please Enter The Email Address regestered on Your Account ")
                                .multilineTextAlignment(.center)
                                .font(.system(size: 16))
                                .foregroundColor(Color(.gray))
                                .padding()
                                
                            
                            
                            
                            
                            TextField("Your Email Addresss" , text: $email)
                                .frame(width: 300  , height: 55 , alignment: Alignment.center)
                                .cornerRadius(16)
                                .multilineTextAlignment(TextAlignment.center)
                                .textFieldStyle(PlainTextFieldStyle())
                                .padding([.leading , .trailing ] , 6)
                                .font(.system(
                                        size: 19))
                        
                                .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray))
                                .padding([.leading , .trailing ] , 16)
                                .padding(.top,25)
                                .autocapitalization(.none)
                            
                                
                                
                          
                            
                        }
                       
                        HStack{
                            
                            NavigationLink(destination: RecoverOTPUIView(USERID: customer?.id ?? 0 ).navigationBarHidden(true)
                             , tag: 1, selection: $triggerNextPage ) {
                                
                                    EmptyView()
                                
                                
                            }
                            Text("Reset Password ")
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity)
                                .font(.system(
                                        size: 18))
                                .padding(12)
                                .background(Color(cyanColor))
                                .cornerRadius(15)
                                .foregroundColor(.white)
                                .padding(.top , 20)
                                .padding(19)
                                .onTapGesture(perform: {
                                    
                                    
                                    
                                    let mail : String = email
                                    
                                    if(mail.isEmpty){
                                        
                                        self.msg = "Please Enter Email Address"
                                        self.showError = true
                                        
                                        
                                    }else {
                                        self.isLoading = true
                                        NetworkManager.shared.searchUser(for: mail){
                                           result in
                                            switch(result){
                                            case .success(let catList):
                                                // save the data"
                                                // self?.saveUser(user: userDeatils)
                                                
                                                //now fillter line items
                                                
                                               
                                                
                                                DispatchQueue.main.async { [self] in
                                                    self.isLoading = false
                                                  
                                                    if(catList.count == 0 ){
                                                        
                                                        self.msg = "There is no Account With This Mail"
                                                        self.showError = true
                                                        
                                                        
                                                    }else {
                                                        
                                                       
                                                        customer = catList[0]
                                                   
                                                      
                                                        
                                                        self.triggerNextPage = 1
                                                        
                                                    }
                                                    
                                                        
                                                    }
                                                    
                                            case .failure( let error ):
                                                DispatchQueue.main.async {
                                                    self.isLoading = false
                                                    print(error)
                                                    
                                                }
                                            }
                                    }
                                    
                                    
                                            
                                            
                                       
                                        
                                    }
                                })
                        
                        }
                        Spacer()
                        
                        Text("")
                            .font(.system(size: 20))
                            .foregroundColor(Color(cyanColor))
                            .bold()
                            .padding(.bottom , 15).onTapGesture(perform: {
                                
                               
                            })
                    }
    
                    VStack(alignment: .center){
                        
                        HUDProgressView(placeholder: "Checking User Account ", show: $isLoading)
                        
                        
                        
                    }.edgesIgnoringSafeArea(.all)
                }
          
                
        }.alert(isPresented: $showError) {
            Alert(title: Text("Important message"), message: Text(msg), dismissButton: .default(Text("Got it!")))
        }
    }
}




struct ResetPassUIView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPassUIView()
    }
}
