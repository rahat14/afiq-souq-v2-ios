//
//  SelectAddressPaymentUIView.swift
//  Afiq Souq
//
//  Created by GAMEKILLER on 4/12/21.
//

import SwiftUI



struct SelectAddressPaymentUIView: View {
    @Environment(\.presentationMode) var presentation
    
    
    @StateObject var viewModel : AddressPaymentViewModel
    let columnsCount  : [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    
    init(total : String , iscodeUsed : Bool , ccode : String ){
        _viewModel = StateObject(wrappedValue: AddressPaymentViewModel(total_amount: total , isCodeUsed: iscodeUsed  , code: ccode  ))
        
    }
    
    
    var body: some View {
        
        ZStack{
            VStack{
                
                NavigationLink(
                    destination: OrderDoneUIView( id: viewModel.transId).navigationBarHidden(true)
                    , tag : 1 , selection : $viewModel.triggerNext ){
                    
                    EmptyView()
                }
                
                
                VStack(alignment: .leading){
                    // tool bar
                    
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
                        
                        Text("Checkout Page")
                            .font(Font.custom("sf_pro", size: 22))
                            .lineLimit(1)
                        
                        
                        Spacer()
                        
                        
                        
                        
                    }.padding([.leading , .trailing , .top] , 5).frame(height: 40).shadow(radius: 26, y: 26)
                    
                    
                    Text("Shipping to : ")
                        .font(.custom("sf_pro", size: 20))
                        .padding()
                    
                    
                    
                    VStack(spacing: 8){
                        
                        TextField( "Name" , text: $viewModel.name)
                        
                        TextField( "Delivery Address" , text: $viewModel.delivery_address)
                            .lineLimit(3)
                        
                        TextField( "Phone" , text: $viewModel.ph)
                        
                        
                        
                        
                        
                    }.padding(.leading , 30)
                    .padding([.trailing  , .bottom  ] , 5 )
                    Divider()
                    
                    HStack{
                        
                        Text("Select Payment Method" )
                            .font(.custom("sf_pro", size: 20))
                            .padding(.leading ,10)
                        
                        Spacer()
                        
                        Image(systemName: "control")
                            .font(.title2)
                            .foregroundColor(Color(cyanColor))
                            .rotationEffect(.degrees(180))
                    }
                    
                    // list
                    
                    LazyVGrid(columns: columnsCount){
                        
                        
                        paymentOptions(text: "Credit/Debit Card", image: "credit_card" )
                            .onTapGesture {
                               
                                viewModel.createPayment()
                            }
                        
                        paymentOptions(text: "Use Wallet", image: "wallet" )
                            .onTapGesture {
                                
                                viewModel.loadWalletBal()
                                
                            }
                           
                        
                        paymentOptions(text: "Bkash", image: "bkash" ).onTapGesture {
                            
                            viewModel.createPayment()
                            
                        }
                        
                        paymentOptions(text: "Cash On Delivery", image: "cash-on-delivery" ).onTapGesture {
                                
                            viewModel.CreateOrder(isPaid: false , method: "COD")
                        }
                        
                        
                        
                        
                    }.padding()
                    
                    
                    
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
                
                
                
                Button(action: {
                    print("Delete tapped!")
                }){
                    Text("Proceed To Pay")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .font(Font.custom("sf_pro", size: 18))
                        .padding(11)
                        .background(Color(cyanColor))
                        .cornerRadius(16)
                        .foregroundColor(.white)
                        .padding(8)
                }
                
                
                
                
                
                
            }
            
            if $viewModel.showPaymentBox.wrappedValue {
                ZStack() {
                    Color.white
                    
                    VStack {
                        //your custom layout text fields buttons
                        
                        Text("Payment Procedure...")
                            .font(.title3)
                        
                        Text(viewModel.msg)
                            .font(.custom("sf_pro", size: 14))
                            .padding()
                        
                        HStack(){
                            Text("CANCEL").onTapGesture {
                                
                                viewModel.showPaymentBox = false
                            }
                            
                            if (viewModel.canPayment){
                                
                                Text("CONTINUE").onTapGesture {
                                    
                                
                                    print(viewModel.canPayment)
                                    viewModel.showPaymentBox = false
                                   
                                    viewModel.AdjustWalletBalance()
                                    
                                    
                                  //  viewModel.CreateOrder(isPaid: true, method: "WALLET")
                                    
                                }
                            }else {
                                
                                
                                Text("OK").onTapGesture {
                                    
                                    
                                    print(viewModel.canPayment)
                                    
                                    viewModel.showPaymentBox = false
                                    
                                    //viewModel.AdjustWalletBalance()
                                    
                                  //  viewModel.CreateOrder(isPaid: true, method: "WALLET")
                                    
                                }
                                
                                
                                
                            }
                            
                            
                        }
                        
                        
                        
                        
                        
                        
                    }.padding()
                }
                .frame(width: 350, height: 220,alignment: .center)
                .cornerRadius(20).shadow(radius: 20)
                
            }
            
            HUDProgressView(placeholder: "Processing...", show: $viewModel.isLoading)
            
        }.alert(isPresented: $viewModel.ShowError ) {
            Alert(title: Text("Important message"), message: Text(viewModel.ErrorMsg), dismissButton: .default(Text("OK")))
        }
        
        
        
    }
}

struct  paymentOptions  : View  {
    
    var text : String
    var image : String
    var body : some View{
        
        
        
        VStack{
            
            VStack{
                
                Image(image)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .aspectRatio(contentMode: .fit)
                Text(text)
                
                
            }.padding()
            
            
            
        }.frame(maxWidth : .infinity , minHeight: 130 , maxHeight: 130).background(Color(UIColor(red: 0.90, green: 0.90, blue: 0.92, alpha: 1.00)))
        .cornerRadius(8)
        
        
        
    }
}


struct SelectAddressPaymentUIView_Previews: PreviewProvider {
    static var previews: some View {
        SelectAddressPaymentUIView( total: "0.0" , iscodeUsed: true , ccode: "")
    }
}
