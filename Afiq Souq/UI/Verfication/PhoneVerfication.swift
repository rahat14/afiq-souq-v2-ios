//
//  PhoneVerfication.swift
//  Afiq Souq
//
//  Created by GAMEKILLER on 3/27/21.
//

import SwiftUI

struct PhoneVerfication: View {
    
    

    let userModel: RegRespSend?
    
    @Environment(\.presentationMode) var presentation
    @ObservedObject  var OtpVM :  OtpViewModel
    
    init(usermodel : RegRespSend?){
        self.userModel = usermodel
        self.OtpVM = OtpViewModel(user: userModel)
       
    }
    
    
    var body: some View {
        
//        if(OtpVM.isLoading){
//
//           // ProgressView("Registering User…")
//
 //      }else {
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
                    
                    Text("")
                        .font(Font.custom("sf_pro", size: 20))
                        .lineLimit(1)
                    
                    
                    Spacer()
                    
                    
                    
                    
                }
                .padding([.all] , 5)
                .frame(height: 40 , alignment: .center)
                .background(Color(.white))
        
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
                                    
                                
                                
                                
                                
                                TextField("1 2 3 4 5 6" , text: $OtpVM.otp)
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
                                
                                NavigationLink(destination: DashBoardUIView().navigationBarBackButtonHidden(true).navigationBarHidden(true), tag: 1, selection: $OtpVM.triggerNextPage) {
                                    
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
                                        OtpVM.verifyFirebaseCode()
                                        
                                    })
                            
                            }
                            Spacer()
                            
                            Text("Resend Code")
                                .font(.system(size: 20))
                                .foregroundColor(Color(cyanColor))
                                .bold()
                                .padding(.bottom , 15).onTapGesture(perform: {
                                    
                                    OtpVM.sendOtp()
                                })
                        }
        
                        VStack(alignment: .center){
                            
                            HUDProgressView(placeholder: "Registering User", show: $OtpVM.isLoading)
                            
                            
                            
                        }.edgesIgnoringSafeArea(.all)
                    }
              
                    
            }.alert(isPresented: $OtpVM.isError) {
                Alert(title: Text("Important message"), message: Text(OtpVM.errorMsg), dismissButton: .default(Text("Got it!")))
            }
      //  }
        
    }
    
    
}

struct PhoneVerfication_Previews: PreviewProvider {
    static var previews: some View {
        PhoneVerfication(usermodel: nil)
    }

}
