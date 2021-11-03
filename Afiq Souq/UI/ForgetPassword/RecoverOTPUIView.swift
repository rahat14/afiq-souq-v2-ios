//
//  RecoverOTPUIView.swift
//  Afiq Souq
//
//  Created by GAMEKILLER on 4/25/21.
//

import SwiftUI

struct RecoverOTPUIView: View {
    @Environment(\.presentationMode) var presentation
 

    @StateObject var VM :  RecoverOtPViewModel
    
    init(USERID : Int ){
        
            _VM = StateObject(wrappedValue: RecoverOtPViewModel(id: USERID))
                
        
    }
    
    var body: some View {
        VStack{
                ZStack{
                    VStack{
                        VStack{
                            Image("phone_icon")
                            
                                .resizable()
                                .frame(maxWidth: 100 ,
                                       maxHeight: 120).padding(.bottom,4)
                                .padding(.top , 10)
                                .padding(.bottom, 10)
                                
                                
                            
                            Text("You Will receive a 6 digits OTP code ")
                                .font(.system(size: 28))
                                .bold()
                                .padding(.bottom , 20)
                            
                            Text("A 6 digit verification code has been sent to your phone ")
                                .font(.system(size: 17))
                                .foregroundColor(Color(cyanColor))
                                .bold()
                                .padding(.bottom , 15)
                                
                            
                            
                        
                            TextField("1 2 3 4 5 6" , text: $VM.userEnteredOtp)
                                .frame(width: 300  , height: 55 , alignment: Alignment.center)
                                .cornerRadius(16)
                                .multilineTextAlignment(TextAlignment.center)
                                .textFieldStyle(PlainTextFieldStyle())
                                .padding([.leading , .trailing ] , 4)
                                .font(.system(
                                        size: 25))
                        
                                .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray))
                                .padding([.leading , .trailing ] , 16)
                                .padding(.top,25)
                          
                            
                        }
                       
                        HStack{
                            
                            NavigationLink(destination: LoginUIView().navigationBarBackButtonHidden(true).navigationBarHidden(true), tag: 1, selection: $VM.triggerNextPage) {
                                
                                    EmptyView()
                                
                                
                            }
                            Text("Verify")
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity)
                                .font(.title2)
                                .padding(10)
                                .background(Color(cyanColor))
                                .cornerRadius(15)
                                .foregroundColor(.white)
                                .padding(.top , 20)
                                .padding(10)
                                .onTapGesture(perform: {
                                    
                                    VM.checkOtp()
                                })
                        
                        }
                        Spacer()
                        
                        Text("Resend Code")
                            .font(.system(size: 20))
                            .foregroundColor(Color(cyanColor))
                            .bold()
                            .padding(.bottom , 15).onTapGesture(perform: {
                                
                               
                                VM.sentOtp()
                                
                                
                            })
                    }
    
                    VStack(alignment: .center){
                        
                        HUDProgressView(placeholder: "Changing Password..", show: $VM.isLoading)
                        
                        
                        
                    }.edgesIgnoringSafeArea(.all)
                    
                    if $VM.showAlert.wrappedValue {
                               ZStack() {
                                Color.white
                                
                                   VStack {
                                       //your custom layout text fields buttons
                                    
                                    Text("Enter Your New Password...")
                                        .font(.title3)
                                    
                                        TextField("password" , text: $VM.newPassword)
                                            .frame(width: 280  , height: 50 , alignment: Alignment.center)
                                            .cornerRadius(16)
                                            .multilineTextAlignment(TextAlignment.center)
                                            .textFieldStyle(PlainTextFieldStyle())
                                            .padding([.leading , .trailing ] , 4)
                                            .font(.system(
                                                    size: 25))
                                    
                                            .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray))
                                            .padding([.leading , .trailing ] , 16)
                                            .padding(.top,25)
                                    
                                    
                                    Text("Update Password")
                                        .fontWeight(.bold)
                                        .frame(maxWidth: .infinity)
                                        .font(.title2)
                                        .padding(10)
                                        .background(Color(cyanColor))
                                        .cornerRadius(12)
                                        .foregroundColor(.white)
                                        .padding(.top , 20)
                                        .padding(10)
                                        .onTapGesture(perform: {
                                            //
                                            
                                            VM.showAlert.toggle()
                                            VM.resetPassword()
                                            
                                        })
                                    
                                      
                                   }.padding()
                               }
                               .frame(width: 350, height: 220,alignment: .center)
                               .cornerRadius(20).shadow(radius: 20)
                           }
                    
                }
          
                
        }.alert(isPresented: $VM.showError) {
            Alert(title: Text("Important message"), message: Text(VM.msg), dismissButton: .default(Text("Try Again")))
        }
    }
}

struct RecoverOTPUIView_Previews: PreviewProvider {
    static var previews: some View {
        RecoverOTPUIView(USERID: 1221)
    }
}
