//
//  CartPageUIView.swift
//  Afiq Souq
//
//  Created by GAMEKILLER on 4/11/21.
//

import SwiftUI
//import Kingfisher
struct CartPageUIView: View {
    @Environment(\.presentationMode) var presentation
    
    @State var isTrigger = false
    @State private var triggerNextPage : Int? = 0
    @State private var isLoginShowAlert : Bool = false
    @State private var triggerSignPage : Int? = 10
    @StateObject var viewModel = CartPageViewModel()
    
    var index = 0
    @State var couponCode  = ""
    var body: some View {
        
        VStack{
            ZStack{
                VStack{
                    
                    NavigationLink(
                        destination: SelectAddressPaymentUIView(total: viewModel.getFinalTotlaPrice() , iscodeUsed: viewModel.isCodeUsed ,
                                                                ccode: couponCode) ,
                        tag: 1, selection: $triggerNextPage){
                        EmptyView()
                    }
                    
                    
                    NavigationLink(
                        destination: LoginUIView().navigationBarHidden(true),
                        tag: 11, selection: $triggerSignPage){
                        EmptyView()
                    }
                    
                    
                    
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
                            
                            Text("Cart")
                                .font(Font.custom("sf_pro", size: 20))
                                .lineLimit(1)
                            
                            
                            Spacer()
                            
                            
                            
                            
                        }.padding([.leading , .trailing , .top] , 5).frame(height: 40).shadow(radius: 26, y: 26)
                        
                        HStack(spacing : 0 ){
                            
                            HStack{
                                Image(systemName: "dollarsign.square")
                                    .resizable()
                                    .foregroundColor(.gray)
                                    .frame(width: 23 , height: 23  )
                                    .padding(.leading , 10)
                                
                                
                                TextField("Coupon" , text: $couponCode  , onCommit: {
                                    
                                    
                                    viewModel.loadCouponList(code : couponCode)
                                    
                                    
                                    
                                })
                                    .disableAutocorrection(true)
                                    .frame(height: 42)
                                    .foregroundColor(Color(cyanColor))
                                    .textFieldStyle(PlainTextFieldStyle())
                                    .font(Font.custom("sf_pro", size: 15))
                                   
                                    
                            }
                            .frame(minWidth: 0,maxWidth: .infinity , minHeight: 0 , maxHeight: .infinity).background(Color(UIColor(red: 0.89, green: 1.00, blue: 0.99, alpha: 1.00)))
                            
                            Text("Apply Code")
                                .foregroundColor(.white)
                                .font(Font.custom("sf_pro", size: 18))
                                .frame(minWidth: 0,maxWidth: .infinity , minHeight: 0 , maxHeight: .infinity).background(Color(cyanColor))
                                .onTapGesture {
                                    
                                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                    viewModel.loadCouponList(code : couponCode)
                                }
                            
                            
                            
                            
                            
                            
                        }.cornerRadius(14)
                        .frame(height: 42)
                        .padding([.leading , .trailing] , 30)
                        
                        
                        let data = viewModel.loadCartItems()
                        List{
                            
                            
                            
                            
                            ForEach(data, id: \.id) { data  in
                                
                                
                                CartCell(index: 0 , product: data , vm: viewModel)
                                
                                
                            }
                            
                            
                        }
                        
                        
                        
                        
                        
                        
                    }.frame(minWidth: 0,
                            maxWidth: .infinity,
                            minHeight: 0,
                            maxHeight: .infinity)
                    
                    //Mark: al the bootom view
                    
                    VStack(spacing : 7 ){
                        
                        Color.gray.frame(height:CGFloat(3) / UIScreen.main.scale)
                            .padding([.leading , .trailing ] , 30)
                        
                        HStack{
                            Spacer().frame(minWidth: 0,
                                           maxWidth: .infinity)
                            
                            Text("Sub Total ")
                                
                                .frame(minWidth: 0,
                                       maxWidth: .infinity , alignment: .leading)
                            
                            Text(bdtSign + viewModel.getTotlaPrice()).frame(minWidth: 0,
                                                                            maxWidth: .infinity)
                            
                        }
                        
                        HStack{
                            Spacer().frame(minWidth: 0,
                                           maxWidth: .infinity)
                            Text("Tax").frame(minWidth: 0,
                                              maxWidth: .infinity , alignment: .leading)
                                .multilineTextAlignment(.trailing)
                            
                            Text(bdtSign + "0.00").frame(minWidth: 0,
                                                         maxWidth: .infinity)
                        }
                        
                        HStack{
                            Spacer().frame(minWidth: 0,
                                           maxWidth: .infinity)
                            
                            Text("Delivery Charge").frame(minWidth: 0,
                                                          maxWidth: .infinity , alignment: .leading)
                            
                            Text(bdtSign +  String(viewModel.deliveryCharge)).frame(minWidth: 0,  maxWidth: .infinity )
                        }
                        
                        
                        
                        
                        Color.gray.frame(height:CGFloat(3) / UIScreen.main.scale)
                            .frame(minWidth: 0,maxWidth: .infinity)
                            .padding(.trailing , 40)
                            .padding(.leading , 140)
                        
                        HStack{
                            Spacer().frame(minWidth: 0,
                                           maxWidth: .infinity)
                            
                            Text("Total")
                                .bold()
                                .foregroundColor(Color(cyanColor))
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            
                            Text(bdtSign +  viewModel.getFinalTotlaPrice()).bold()
                                .frame(minWidth: 0,  maxWidth: .infinity)
                                .foregroundColor(Color(cyanColor))
                        }
                        
                        HStack{
                            Spacer().frame(minWidth: 0,
                                           maxWidth: .infinity)
                            
                            Text("Discount").frame(minWidth: 0,
                                                   maxWidth: .infinity ,alignment: .leading)
                            
                            Text(bdtSign +  String(viewModel.disCount)).frame(minWidth: 0,  maxWidth: .infinity)
                        }
                        
                        Color.gray.frame(height:CGFloat(3) / UIScreen.main.scale)
                            .frame(minWidth: 0,maxWidth: .infinity)
                            .padding(.trailing , 40)
                            .padding(.leading , 140)
                        
                        
                        HStack{
                            Spacer().frame(minWidth: 0,
                                           maxWidth: .infinity)
                            
                            Text("To Be Paid")
                                .bold()
                                .foregroundColor(Color(cyanColor))
                                .frame(minWidth: 0, maxWidth: .infinity ,alignment: .leading)
                            
                            Text(bdtSign +  viewModel.getFinalTotlaPrice()).bold()
                                .frame(minWidth: 0,  maxWidth: .infinity)
                                .foregroundColor(Color(cyanColor))
                        }
                        
                        
                        
                        
                        Text("Check Out")
                            .frame(maxWidth: .infinity)
                            .font(Font.custom("sf_pro", size: 18))
                            .padding(10)
                            .background(Color(cyanColor))
                            .cornerRadius(15)
                            .foregroundColor(.white)
                            .padding([.leading  , .trailing ] , 30)
                            .padding([.bottom , .top ] , 7)
                            .onTapGesture(perform: {
                                
                                if(isUserLoggedin()){
                                    if(viewModel.cartList.count > 0){
                                        triggerNextPage = 1
                                    }
                                }
                                else {
                                    
                                    self.isLoginShowAlert = true
                                    
                                }
                                
                               
                                
                                
                                
                                
                            })
                        
                        
                    }.frame(minWidth: 0,
                            maxWidth: .infinity,
                            minHeight: 0)
                    .background(Color(.white))
                    .alert(isPresented: $viewModel.showError) {
                        Alert(title: Text("Important message"), message: Text(viewModel.msg), dismissButton: .default(Text("OK")))
                    
                }
                }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top).alert(isPresented: $isLoginShowAlert) {
                    Alert(
                        title: Text("Please Login."),
                        message: Text("To Complete Order  Please Login."),
                        primaryButton: .destructive(Text("Login")) {
                            self.triggerSignPage = 11
                        },
                        secondaryButton: .cancel()
                    )
                }
                
                
                HUDProgressView(placeholder: "Checking Coupon...", show: $viewModel.isLoading)
            }
        }.ignoresSafeArea(.keyboard)
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
       
    }
    
    
}

struct CartCell  : View {
    
    var index : Int
    
    var product : CartDbMOdel
    
    @ObservedObject var  vm : CartPageViewModel
    
    var body : some View{
        
        
        
        
        HStack{
            VStack{
                ZStack(alignment: .top   ){
                    
                    ImageViewerView(imageUrl: product.image )
//                        .resizable()
                       // .cacheMemoryOnly()
                        .cornerRadius(16)
                        .frame(maxWidth:.infinity , maxHeight: .infinity)
                    
//                    KFImage(URL(string: product.image ))
//                        .fade(duration: 0)
//                        .resizable()
//                        .cacheMemoryOnly()
//                        .cornerRadius(16)
//                        .frame(maxWidth:  .infinity , maxHeight: .infinity)
                    
                    
                    
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.red).frame(minWidth: 0,
                                                     maxWidth: .infinity , alignment: .topLeading)
                        .font(.title2)
                        .padding([.top  , .leading ], -10)
                        .onTapGesture {
                            
                            // delete the row
                            
                            vm.delete(cartId: product.id)
                            
                        }
                    
                    
                    
                }
                
            }.frame(minWidth: 0,
                    maxWidth: .infinity)
            
            VStack{
                
                Text(product.title)
                    .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.black)
                
                HStack(spacing : 20){
                    HStack(spacing : 18){
                        
                        Button(action: {
                            
                            //productDetailsVM.increment()
                            vm.update(ingredientID: product.id , quantity: (product.quantity + 1))
                            
                        }) {
                            HStack {
                                
                                Image(systemName: "plus")
                                    .foregroundColor(.white)
                                
                                
                            }
                            
                            
                        }.buttonStyle(PlainButtonStyle())
                        
                        
                        Text(String(product.quantity )).foregroundColor(Color(.white))
                            .font(Font.system(size: 14))
                        
                        
                        Button(action: {
                            
                            let  newQty = product.quantity  - 1
                            if(newQty >= 1 ){
                                // update the database
                                
                                vm.update(ingredientID: product.id , quantity: newQty)
                                
                            }
                            else {
                                print("mibuse error ")
                                // throow msg
                            }
                            
                        }) {
                            HStack {
                                
                                Image(systemName: "minus").foregroundColor(Color(.white))
                                    .font(Font.system(size: 14))
                                
                            }
                            
                            
                        }.buttonStyle(PlainButtonStyle())
                        
                        
                        
                        
                    }
                    .padding(8)
                    .background(Color(cyanColor))
                    .cornerRadius(8)
                    
                    
                }
                
                Spacer()
                
                
            }.frame(minWidth: 0,
                    maxWidth: .infinity)
            
            
            VStack{
                
                Text(bdtSign + String(product.unit_price))  //+ //productDetailsVM.getProductPrice())
                    .bold()
                Spacer()
                
            }.frame(minWidth : 0 , maxWidth: .infinity )
        }.frame(minWidth : 0 , maxWidth: .infinity   , minHeight : 0 , maxHeight : 100).padding(.all , 6 )
        
    }
    
    
    
}

struct CartPageUIView_Previews: PreviewProvider {
    static var previews: some View {
        CartPageUIView()
    }
}
