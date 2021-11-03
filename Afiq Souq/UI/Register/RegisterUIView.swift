//
//  RegisterUIView.swift
//  Afiq Souq
//
//  Created by GAMEKILLER on 3/13/21.
//

import SwiftUI


struct RegisterUIView: View {
    
    @StateObject var RegVM = RegisterViewModel()
    @State private var action: Int? = 0
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        
            ScrollView{
                VStack(){
                    
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
                    .padding([.leading , .trailing , .top] , 5)
                    .frame(height: 20 , alignment: .center)
                    .background(Color(.white))
                    
                    ZStack(alignment : .top){
                        Rectangle()
                            .foregroundColor(Color(cyanColor))
                            .frame(maxWidth: .infinity ,
                                   maxHeight: 200)
                            .cornerRadius(50 ,
                                          corners: .topLeft)
                            .cornerRadius(50 ,
                                          corners: .topRight)
                            
                            .padding([.leading,.trailing] , 13)
                        
                        VStack(){
                            HStack{
                                Text("Register")
                                    .font(.title)
                                    .padding(.top , 10)
                                Spacer()
                            }
                            
                            HStack{
                                TextField(" First Name"  , text : $RegVM.fname)
                                    .frame(height: 55)
                                    .cornerRadius(16)
                                    .textFieldStyle(PlainTextFieldStyle())
                                    .padding([.leading , .trailing ] , 4)
                                    .font(.system(
                                            size: 20))
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                    .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray))
                                    .padding([.leading , .trailing ] , 1)
                                    .padding(.bottom,5)
                                Spacer()
                                
                                TextField("Last Name"  , text : $RegVM.sname  )
                                    .frame(height: 55)
                                    .cornerRadius(16)     .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                    .textFieldStyle(PlainTextFieldStyle())
                                    .padding([.leading , .trailing ] , 4)
                                    .font(.system(
                                            size: 20))
                                    .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray))
                                    .padding([.trailing ] , 1)
                                    .padding(.bottom,5)
                            }
                            TextField("Enter E-Mail", text: $RegVM.mail )
                                .frame(height: 55)
                                .cornerRadius(16)
                        
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                                .textFieldStyle(PlainTextFieldStyle())
                                .padding([.leading , .trailing ] , 4)
                                .font(.system(
                                        size: 20))
                                .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray))
                                .padding([.leading , .trailing ] , 1)
                                .padding(.bottom , 7)
                            
                            TextField("Enter Phone", text:  $RegVM.phone )
                                .frame(height: 55)
                                .cornerRadius(16)
                                .textFieldStyle(PlainTextFieldStyle())
                                .padding([.leading , .trailing ] , 4)
                                .font(.system(
                                        size: 20))
                                .keyboardType(.numberPad)
                                .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray))
                                .padding([.leading , .trailing ] , 1)
                                .padding(.bottom , 7)
                            
                            
                            
                            SecureField("Enter password", text: $RegVM.password )
                                .frame(height: 55)
                                .cornerRadius(16)
                                .textFieldStyle(PlainTextFieldStyle())
                                .padding([.leading , .trailing ] , 4)
                                .font(.system(
                                        size: 20))
                                .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray))
                                .padding([.leading , .trailing ] , 1)
                                .padding(.bottom , 7)
                            
                            
                            TextField("Enter Your District", text: $RegVM.district )
                                .frame(height: 55)
                                .cornerRadius(16)
                                .textFieldStyle(PlainTextFieldStyle())
                                .padding([.leading , .trailing ] , 4)
                                .font(.system(
                                        size: 20))
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                                .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray))
                                .padding([.leading , .trailing ] , 1)
                                .padding(.bottom , 7)
                            
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
                            }.frame(minHeight: 85)
                            .cornerRadius(16)
                            .textFieldStyle(PlainTextFieldStyle())
                            .padding([.leading , .trailing ] , 4)
                            .disableAutocorrection(true)
                        
                            .autocapitalization(.none)
                            .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray))
                            .padding([.leading , .trailing ] , 1)
                            .padding(.bottom , 7)
                            
                            
                            
                            Text(RegVM.prompt)
                                .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                                .foregroundColor(.red)
                                .font(.title2)
                            
                            
                            VStack(spacing: 3 ){
                                CheckboxField(id: "true", label: "By Signing Up ,You Agree to The", callback: checkBoxSelcted )
                                    .frame( maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                                   
                                   
               
                                
                                Text("Privacy Policy.") .font(Font.system(size: 17)).onTapGesture {
                                    guard let url = URL(string: "https://afiqsouq.com/privacy-policy") else { return }
                                    UIApplication.shared.open(url)
                                }.foregroundColor(Color(cyanColor))  .frame( maxWidth: .infinity , alignment: .leading)
                                .padding(.leading , 26)
               
               

                               
                                
                            }.frame( maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                            .padding(.leading , 5 )
                            .padding([.leading , .trailing] , 8)
                            
                            
                            HStack{
                                NavigationLink(destination: PhoneVerfication(usermodel: RegVM.UserFinalModel).navigationBarHidden(true), tag: 1, selection: $action) {
                                    
                                        EmptyView()
                                    
                                    
                                }
                                
                                Text("Register")
                                    .fontWeight(.bold)
                                    .frame(maxWidth: .infinity)
                                    .font(.title3)
                                    .padding()
                                    .background(Color(cyanColor))
                                    .cornerRadius(15)
                                    .foregroundColor(.white)
                                    .padding(12)
                                    .onTapGesture(perform: {
                                        
                                        RegVM.CheckTheData()
                                        if(RegVM.triggerNextPage){
                                            self.action = 1
                                        }
                                    
                                    })
                                
                            }.padding(10)
                            
                            
                            
                            
                        }
                        .frame(maxHeight: .infinity).padding(.leading)
                        .padding(.trailing, 10)
                        
                        .background(Color.white).padding(.top  ,25)
                        .padding(.bottom ,30)
                        
                        
                        
                    }
                    
                    
                }
            }
          
    }
    
    func  checkBoxSelcted(id: String , isMarked : Bool) {
        //LoginVM.loadUser()
        RegVM.changeTheStatrIsChecked()
    }
}

struct RegisterUIView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterUIView()
    }
}
