//
//  LoginUIView.swift
//  Afiq Souq
//
//  Created by GAMEKILLER on 3/5/21.
//

import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
struct RoundedCorner: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

// for check box
struct CheckboxField: View {
    let id: String
    let label: String
    let size: CGFloat
    let color: Color
    let textSize: Int
    let callback: (String, Bool)->()
    
    init(
        id: String,
        label:String,
        size: CGFloat = 17,
        color: Color = Color.black,
        textSize: Int = 17,
        callback: @escaping (String, Bool)->()
    ) {
        self.id = id
        self.label = label
        self.size = size
        self.color = color
        self.textSize = textSize
        self.callback = callback
    }
    
    @State var isMarked:Bool = false
    
    var body: some View {
        Button(action:{
            self.isMarked.toggle()
            self.callback(self.id, self.isMarked)
        }) {
            HStack(alignment: .center, spacing: 8) {
                Image(systemName: self.isMarked ? "checkmark.square" : "square")
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: self.size, height: self.size)
                Text(label)
                    .font(Font.system(size: size))
                
            }.foregroundColor(self.color)
        }
        .foregroundColor(Color.white)
    }
}

struct LoginUIView: View {
    
    @ObservedObject var  loginVM = LoginViewModel()
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        
        NavigationLink(
            destination: DashBoardUIView().navigationBarHidden(true),
            tag: 11, selection: $loginVM.triggerDashBoard){
            EmptyView()
        }
        
           
//                if(loginVM.isUserLogin()){
//
//                    DashBoardUIView().navigationBarBackButtonHidden(true)
//                        .navigationBarHidden(true)
//                        .edgesIgnoringSafeArea(.bottom)
//
//
            //    }
            //    else {
                 
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
                            Image("login_image")
                                .resizable()
                                .frame(maxWidth:.infinity ,
                                       maxHeight: 220).padding(.bottom,4)
                            
                            ZStack(alignment : .top){
                                Rectangle()
                                    .foregroundColor(Color(cyanColor))
                                    .frame(maxWidth: .infinity ,
                                           maxHeight: 200)
                                    .cornerRadius(50 ,
                                                  corners: .topLeft)
                                    .cornerRadius(50 ,
                                                  corners: .topRight)
                                    
                                    .padding([.leading,.trailing] , 10)
                                
                                
                                
                                CurvedCardView(LoginVM: loginVM)
                                    .background(Color.white).padding(.top  ,25)
                                    .padding(.bottom ,30)
                                
                                
                                
                            }
                            
                        }
                    }.navigationBarBackButtonHidden(true)
                    .navigationBarHidden(true)
              
                
           //     }
            
            
         
            
        
        
        
        
    }
    
    struct  CurvedCardView : View  {
        
        @ObservedObject  var LoginVM : LoginViewModel
        
        
        
        var body: some View {
            ZStack{
                VStack(){
                    HStack{
                        Text("Sign In")
                            .font(Font.custom("sf_pro", size: 25))
                        Spacer()
                    }
                    
                    TextField("Enter mail.." , text: $LoginVM.mail)
                        .frame(height: 55)
                        .cornerRadius(16)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding([.leading , .trailing ] , 4)
                        .font(Font.custom("sf_pro", size: 20))
                        .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray))
                        .padding([.leading , .trailing ] , 16)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding(.bottom,5)
                    
                    SecureField("Enter password.." , text: $LoginVM.pass)
                        .frame(height: 55)
                        .font(Font.custom("sf_pro", size: 20))
                        .cornerRadius(16)
                        
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding([.leading , .trailing ] , 4)
                        .font(Font.custom("sf_pro", size: 20))
                        .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray))
                        .padding([.leading , .trailing ] , 16)
                        .padding(.bottom , 7)
                    
                    Text("")
                        .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.red)
                        
                        .font(.title2)
                    
                    
                    HStack{
                        Text("Sign In")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .font(Font.custom("sf_pro", size: 20))
                            .padding(10)
                            .background(Color(cyanColor))
                            .cornerRadius(15)
                            .foregroundColor(.white)
                            .padding(12)
                            .onTapGesture(perform: {
                                LoginVM.SignUp()
                                // this iis test push
                            })
                        
                        
                        
                    }
                    
                    HStack{
                        
                        CheckboxField(id: "true", label: "Remember me", callback: checkBoxSelcted )
                        
                        Spacer()
                        
                        NavigationLink(destination: ResetPassUIView().navigationBarHidden(true)){
                            Text("Forget Password?")
                                .font(.system(size: 17))
                                .foregroundColor(.black)
                        }
                        
                        
                        
                    }.padding(.top , 5)
                    
                    HStack{
                        Text("Don't Have Account?")
                            .font(.system(size: 17))
                            .padding(.trailing , -3)
                        
                        NavigationLink(destination: RegisterUIView()
                                        .navigationBarTitle("") //this must be empty
                                        .navigationBarHidden(true)
                                        .navigationBarBackButtonHidden(true)) {
                            Text("Sign Up")
                                .font(.system(size: 20))
                                .foregroundColor(Color(cyanColor))
                                .padding(.leading, 0 )
                        }
                        
                        Spacer()
                        
                    }
                    
                }
                VStack(alignment: .center){
                    
                    HUDProgressView(placeholder: "Logging User", show: $LoginVM.isLoading)
                    
                    
                }.edgesIgnoringSafeArea(.all)
            }
            .frame(maxHeight: .infinity).padding(.leading)
            .padding(.trailing, 10)
            .alert(isPresented: $LoginVM.showAlert) {
                Alert(title: Text("Important message"), message: Text(LoginVM.prompt), dismissButton: .default(Text("Try Again")))
            }
            
            
            
            
            
            
        }
        
        
        func  checkBoxSelcted(id: String , isMarked : Bool) {
            //LoginVM.loadUser()
        }
    }
    
    struct LoginUIView_Previews: PreviewProvider {
        static var previews: some View {
            //WalkThroughView()
            LoginUIView()
        }
    }
    

    
    
}


  
