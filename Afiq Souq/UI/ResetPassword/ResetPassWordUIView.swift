//
//  ResetPassWordUIView.swift
//  Afiq Souq
//
//  Created by GAMEKILLER on 4/20/21.
//

import SwiftUI
import FloatingLabelTextFieldSwiftUI
 

struct ResetPassWordUIView: View {
    @State var isError : Bool = false
    @Environment(\.presentationMode) var presentation
   
    @StateObject var ViewModel = ResetPassWordViewViewModel()
    
    
    var body: some View{
     //   Text("")

        
                ZStack{
        
        
                    VStack{
        
                        ZStack(alignment : .bottom){
                            Rectangle()
                                .foregroundColor(Color(cyanColor))
                                .frame(maxWidth: .infinity ,
                                       maxHeight: 400)
                                .cornerRadius(30 ,
                                              corners: .topLeft)
                                .cornerRadius(30 ,
                                              corners: .topRight)
        
                                .padding([.leading,.trailing] , 10)
        
        
        
        
                            ZStack{
                                Rectangle()
                                    .foregroundColor(Color(.white))
                                    .cornerRadius(16 ,
                                                  corners: .topLeft)
                                    .cornerRadius(16 ,
                                                  corners: .topRight)
        
                                    .alert(isPresented: $ViewModel.isPassError) {
        
                                     Alert(title: Text("Error"), message: Text(ViewModel.msg), dismissButton: .destructive(Text("Continue")) {
        
        
        
                                     })
        
        
                                         }
        
                                VStack(){
                                    HStack{
                                        Text("Change Your Password")
                                            .font(Font.custom("sf_pro", size: 20))
        
                                        Spacer()
        
        
                                    }.padding([.top , .leading])
        
                                    FloatingLabelTextField($ViewModel.oldPass, placeholder: "Old Password", editingChanged: { (isChanged) in
        
                                                   }) {
        
                                            }
                                            .isSecureTextEntry(true)
                                            .titleColor(.gray)
                                            .lineColor(.white)
                                            .selectedLineColor(.white)
                                            .titleFont(.system(size: 14))
                                            .cornerRadius(16)
        
                                            .padding([.leading , .trailing ] , 4)
                                            .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray))
                                            .padding([.leading , .trailing ] , 16)
                                            .padding(.bottom,5)
                                            .frame(height: 60)
        
        
                                    FloatingLabelTextField($ViewModel.newPass, placeholder: "New Password", editingChanged: { (isChanged) in
        
                                                   }) {
        
                                            }
                                            .isSecureTextEntry(true)
                                            .titleColor(.gray)
                                            .lineColor(.white)
                                            .selectedLineColor(.white)
                                            .titleFont(.system(size: 14))
                                            .cornerRadius(16)
        
                                            .padding([.leading , .trailing ] , 4)
                                            .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray))
                                            .padding([.leading , .trailing ] , 16)
                                            .padding(.bottom,5)
                                            .frame(height: 60)
        
                                    FloatingLabelTextField($ViewModel.cofirmPass, placeholder: "Confrim New Password", editingChanged: { (isChanged) in
        
                                                   }) {
        
                                            }
                                            .isSecureTextEntry(true)
                                            .titleColor(.gray)
                                            .lineColor(.white)
                                            .selectedLineColor(.white)
                                            .titleFont(.system(size: 14))
                                            .cornerRadius(16)
        
                                            .padding([.leading , .trailing ] , 4)
                                            .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray))
                                            .padding([.leading , .trailing ] , 16)
                                            .padding(.bottom,5)
                                            .frame(height: 60)
        
        
        
        
                                    HStack{
                                        Text("Change Password")
                                            .fontWeight(.bold)
                                            .frame(maxWidth: .infinity)
                                            .font(Font.custom("sf_pro", size: 19))
                                            .padding(9)
                                            .background(Color(cyanColor))
                                            .cornerRadius(8)
                                            .foregroundColor(.white)
                                            .padding(20)
        
                                            .onTapGesture(perform: {
        
                                                // this iis test push
        
                                                ViewModel.checkAllPass()
                                            }).alert(isPresented: $ViewModel.isPassChanged) {
        
                                                Alert(title: Text("Success !!"), message: Text("Your Password Changed !!!") , dismissButton: .destructive(Text("Continue")) {
        
                                                    self.presentation.wrappedValue.dismiss()
        
        
                                                })
        
        
        
                                    }
        
        
        
                                    }
        
        
                                    Color.gray.frame(height:CGFloat(6) / UIScreen.main.scale)
                                        .frame(width : 120)
        
        
        
                                    Spacer()
        
                                }
        
                            }
        
                            .frame( maxWidth: .infinity, maxHeight: 385 , alignment: .bottom)
        
                            .background(Color(backgroundColor))
        
        
        
        
                        }
                    }.frame(minWidth : 0  , maxWidth: .infinity , minHeight: 0 , maxHeight:  .infinity , alignment: .bottom)
                    .background(Color(backgroundColor))
        
        
                    HUDProgressView(placeholder: "Requsting ... ", show: $ViewModel.isLoading)
        
        
                    ZStack{
                        Button(action: {
        
        
                            self.presentation.wrappedValue.dismiss()
        
        
                        }) {
                            HStack {
        
                                Image(systemName: "arrow.left")
                                    .font(.title)
                                    .foregroundColor(Color(cyanColor))
        
                            }
        
                        }
                    }.frame(minWidth : 0  , maxWidth: .infinity , minHeight: 0 , maxHeight:  .infinity , alignment: .topLeading).padding(7)
        
        
                }.frame(minWidth : 0  , maxWidth: .infinity , minHeight: 0 , maxHeight:  .infinity , alignment: .bottom)
                .background(Color(backgroundColor))
        
        
    }
}

struct ResetPassWordUIView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPassWordUIView()
    }
}
