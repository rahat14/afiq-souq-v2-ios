//
//  ProfileUIView.swift
//  Afiq Souq
//
//  Created by GAMEKILLER on 4/19/21.
//

import SwiftUI

struct ProfileUIView: View {
    @Environment(\.presentationMode) var presentation
 
    @StateObject var RegVM = ProfileViewModel()
    
    var body: some View {
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
                
                Text("Profile")
                    .font(Font.custom("sf_pro", size: 17))
                    .lineLimit(1)
                
                
                Spacer()
                
              
                    
                
            }.padding([.leading , .trailing , .top] , 5)
            .frame(height: 40 , alignment: .center).background(Color(.white))
           
            ScrollView{
                VStack(){
                    ZStack(alignment : .top){
                        Rectangle()
                            .foregroundColor(Color(cyanColor))
                            .frame(maxWidth: .infinity ,
                                   maxHeight: 180)
                            .cornerRadius(50 ,
                                          corners: .topLeft)
                            .cornerRadius(50 ,
                                          corners: .topRight)
                            
                            .padding([.leading,.trailing] , 13)
                        
                        VStack(){
                            HStack{
                                Text("My Profile")
                                    .font(.custom("sf_pro", size: 20))
                                    .padding(.top , 10)
                                Spacer()
                            }
                            
                            HStack{
                                TextField("Your First Name"  , text : $RegVM.fname)
                                    .frame(height: 55)
                                    .cornerRadius(16)
                                    .textFieldStyle(PlainTextFieldStyle())
                                    .padding([.leading , .trailing ] , 4)
                                    .font(.system(
                                            size: 20))
                                    .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray))
                                    .padding([.leading , .trailing ] , 1)
                                    .padding(.bottom,5)
                                    .disabled(true)
                                Spacer()
                                
                                TextField("Your Last Name"  , text : $RegVM.sname  )
                                    .frame(height: 55)
                                    .cornerRadius(16)
                                    .textFieldStyle(PlainTextFieldStyle())
                                    .padding([.leading , .trailing ] , 4)
                                    .font(.system(
                                            size: 20))
                                    .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray))
                                    .padding([.trailing ] , 1)
                                    .padding(.bottom,5)
                                    .disabled(true)
                            }
                            TextField("Enter Mail", text: $RegVM.mail )
                                .frame(height: 55)
                                .cornerRadius(16)
                                .autocapitalization(UITextAutocapitalizationType.none)
                                
                                .textFieldStyle(PlainTextFieldStyle())
                                .padding([.leading , .trailing ] , 4)
                                .font(.system(
                                        size: 20))
                                .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray))
                                .padding([.leading , .trailing ] , 1)
                                .padding(.bottom , 7)
                                .disabled(true)
                            
                            TextField("Enter Phone", text: $RegVM.phone )
                                .frame(height: 55)
                                .cornerRadius(16)
                                .textFieldStyle(PlainTextFieldStyle())
                                .padding([.leading , .trailing ] , 4)
                                .font(.system(
                                        size: 20))
                                .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray))
                                .padding([.leading , .trailing ] , 1)
                                .padding(.bottom , 7)
                                .disabled(true)
                            
                         
                            
                            TextField("Enter Your District", text: $RegVM.district )
                                .frame(height: 55)
                                .cornerRadius(16)
                                .textFieldStyle(PlainTextFieldStyle())
                                .padding([.leading , .trailing ] , 4)
                                .font(.system(
                                        size: 20))
                                .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray))
                                .padding([.leading , .trailing ] , 1)
                                .padding(.bottom , 7)
                                .disabled(true)
                            
                            ZStack(alignment: .top){
                                
                                TextEditor(text : $RegVM.delivery_address) .font(.system(size: 20))
                                    .padding(.top)
                                
                                HStack{
                                    if(RegVM.isdeliverAddressEmpty()){
                                        Text("Enter Your Delivery Address")
                                            
                                            .foregroundColor(.gray)
                                            .font(.system(size: 20))
                                        
                                        
                                    }
                                    Spacer()
                                }
                                .padding(.top)
                                
                                
                                Text("eeeeee").opacity(0)
                                    .padding(.all , 8 )
                            }.frame(minHeight: 100)
                            .cornerRadius(16)
                            .textFieldStyle(PlainTextFieldStyle())
                            .padding([.leading , .trailing ] , 4)
                            .disableAutocorrection(true)
                            .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray))
                            .padding([.leading , .trailing ] , 1)
                            .padding(.bottom , 7)
                            
                        
                           
                                          
                        }
                        .frame(minHeight : 0 ,  maxHeight: .infinity).padding(.leading)
                        .padding(.trailing, 10)
                        .cornerRadius(12)
                        .background(Color.white).padding(.top  ,15)
                        .padding(.bottom ,30)
                        
                        
                        
                    }
                }
            }.frame(minWidth: 0 , maxWidth: .infinity ,
                    minHeight: 0 , maxHeight: .infinity)
        }
      
    }
}

struct ProfileUIView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileUIView()
    }
}
