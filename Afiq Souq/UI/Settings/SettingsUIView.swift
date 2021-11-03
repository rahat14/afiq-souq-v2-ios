//
//  SettingsUIView.swift
//  Afiq Souq
//
//  Created by GAMEKILLER on 4/19/21.
//

import SwiftUI

struct SettingsUIView: View {
    @Environment(\.presentationMode) var presentation
    @State  var isTrue : Bool = true
    @State var isShowAlert : Bool = false
    @State var triggerSignPage : Int? = 10
    @State var triggerTransPage : Int? = 100
    var body: some View {
        
        VStack{
            
            
            NavigationLink(
                destination: LoginUIView().navigationBarHidden(true),
                tag: 11, selection: $triggerSignPage){
                EmptyView()
            }
           
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
                
                Text("Settings")
                    .font(Font.custom("sf_pro", size: 17))
                    .lineLimit(1)
                
                
                Spacer()
                
              
                    
                
            }.padding([.leading , .trailing , .top] , 5)
            .frame(height: 40 , alignment: .center).background(Color(.white))
            
            VStack{
                Image("my_bg")
                    .resizable()
                    .frame(minWidth: 0 , maxWidth: .infinity
                    , maxHeight: 120)
                
            }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/,  maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 120, maxHeight: 120, alignment: .top)
            
            
            Color.gray.frame(height:CGFloat(3) / UIScreen.main.scale)
                .padding([.leading , .trailing ] , 15)
                .padding(.top , 10)
            
            
            HStack(alignment: .center){
                
                VStack(alignment: .leading , spacing : 15){
                    
                    NavigationLink(destination : ResetPassWordUIView( ).navigationBarHidden(true) , tag : 1 , selection :  $triggerTransPage){
                        
                        EmptyView()
                      
                    }
                    
                    HStack{
                        
                        Image(systemName: "gearshape.fill")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(Color(cyanColor))
                            .frame(width: 20, height: 20)
                        
                        
                        Text("Reset Password")
                            .font(.system(size: 17))
                            .foregroundColor(.black)
                            .bold()
                            .onTapGesture {
                                
                                if(isUserLoggedin()){
                                    self.triggerSignPage = 1
                                }else {
                                    isShowAlert = true 
                                }
                                
                            }
                            
                        
                        
                    }
                    
                   
                        HStack{
                            
                            Image(systemName: "exclamationmark.shield.fill")
                                .font(.system(size: 20))
                                .foregroundColor(Color(cyanColor))
                            
                            Text("Privacy Policy")
                                .font(.system(size: 17))
                                .bold()
                                .padding(.leading , -2)
                                .foregroundColor(.black)
                            
                            
                        }
                        
                        
                    
                
                    
                    
                    
                    HStack{
                        
                        Image(systemName: "bell")
                            .font(.system(size: 20))
                            .foregroundColor(Color(cyanColor))
                        
                        Text("Notificaiton")
                            .font(.system(size: 17))
                            .bold()
                            .padding(.leading , -2)
                       
                        
                        
                        Toggle("", isOn: $isTrue)
                                       .toggleStyle(SwitchToggleStyle(tint: Color(cyanColor)))
                            
                                        .labelsHidden()
                            .frame(width: 60, height: 20, alignment: .trailing)
                            .padding(.leading , 4)
                       
                        
                        
                    }
                  
                    
                    
                }
                
                
            } .alert(isPresented: $isShowAlert) {
                Alert(
                    title: Text("Please Login."),
                    message: Text("To Access This Feature Please Login."),
                    primaryButton: .destructive(Text("Login")) {
                        self.triggerSignPage = 11
                    },
                    secondaryButton: .cancel()
                )
            }
            .padding()
            .onTapGesture(perform: {
                guard let url = URL(string: "https://afiqsouq.com/privacy-policy") else { return }
                UIApplication.shared.open(url)
            })
            
            
            
            
        }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/,  maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .top)
    }
    
    func  checkBoxSelcted(id: String , isMarked : Bool) {
        //LoginVM.loadUser()
    }
}

struct SettingsUIView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsUIView()
    }
}
