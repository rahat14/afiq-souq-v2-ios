//
//  WalletUiIView.swift
//  Afiq Souq
//
//  Created by GAMEKILLER on 4/20/21.
//

import SwiftUI

struct WalletUiIView: View {
    @Environment(\.presentationMode) var presentation
    @ObservedObject var VM = WalletViewModel()
    @State var txt = ""
    @State var isTriggerNextPage : Int? = 0
    
    
    var body: some View {
        ZStack{

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
                    
                    Text("My Wallet")
                        .font(Font.custom("sf_pro", size: 17))
                        .lineLimit(1)
                    
                    
                    Spacer()
                    
                  
                        
                    
                }.padding([.leading , .trailing , .top] , 5).frame(height: 40 , alignment: .center).background(Color(.white))
                
                HStack{
                    VStack(alignment : .leading , spacing : 10 ){
                        
//                        NavigationLink(destination: MyMasterViewController() , tag : 1 , selection : $isTriggerNextPage ) {
//                                                EmptyView()
//                             }.navigationBarHidden(true)
                        
                        
                        Text("Balance")
                            .font(.custom("sf_pro", size: 17))
                            .foregroundColor(.black)
                        
                        
                        let  walletBal = VM.walletNumber.replacingOccurrences(of: "\"", with: "")
                        Text(bdtSign + walletBal)
                            .font(.custom("sf_pro", size: 22))
                            .foregroundColor(Color(cyanColor))
                        
                        HStack{
                            Text("Status:").foregroundColor(.gray)
                            
                            Image(systemName: "checkmark.circle")
                                .foregroundColor(Color(cyanColor))
                                .font(.system(size: 17))
                            
                            Text("Active")
                                .bold()
                                .font(.custom("sf_pro", size: 17))
                                .foregroundColor(.black)
                            
                            
                            
                        }
                        
                    }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/,  maxWidth: .infinity, alignment: .topLeading)
                    
                    Text("Top Up")
                        .fontWeight(.bold)
                        .bold()
                        .frame(maxWidth: .infinity)
                        .font(Font.custom("sf_pro", size: 17))
                        .padding(9)
                        .background(Color(cyanColor))
                        .cornerRadius(6)
                        .foregroundColor(.white)
                        .padding(8)
                        .frame(width: 120, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .onTapGesture {
                            
                            savePayment(pay: paymnetMODEL.init(method: WALLET_PAYMET_METHOD , total: 1100 , isPaid: false))
                            
                            VM.showPaymentBox.toggle()
                            
                           // self.isTriggerNextPage = 1
                        }
                    
                }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/,  maxWidth: .infinity, alignment: .top).padding(7)
                
                ScrollView{
                    VStack{
                        ForEach(VM.walletItemList , id: \.balance){ item in
                            
                            walletCell(trans: item)
                       }
                        
                        
                    }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/,  maxWidth: .infinity, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/,  maxHeight: .infinity, alignment: .top)
                }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/,  maxWidth: .infinity, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/,  maxHeight: .infinity, alignment: .top)
                
            }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/,  maxWidth: .infinity, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/,  maxHeight: .infinity, alignment: .top).onAppear(){
                if VM.isWorking{
                    
                }
                else {
                    // triiger data upload
                   
                    
                    let paymnet = loadPayment()
                    if(paymnet ==  nil){
                        
                    }else {
                        // there is paymnet
                        let isPayment  = paymnet?.isPaid ?? false
                        print(isPayment)
                        if(isPayment){
                            
                            // payment done bring progress
                            
                            print("PAYMENT_DONE!!")
                            
                            // reset payment system
                            VM.is_Loading = true
                            
                            VM.AdjustWalletBalance(amount : paymnet?.total ?? 0)
                           
                            VM.isWorking = true
                            
                        }else {
                            
                            // payment not done
                            // so , do nothing
                            VM.is_Loading = false
                            print("NO_PAYMENT_DONE!!")
                            
                        }
                    }
                }
            }
            
            if (VM.isLoading) {
                
                ProgressView().progressViewStyle(CircularProgressViewStyle(tint: Color(cyanColor)))
            }
            
            
            if VM.showPaymentBox {
                ZStack() {
                    Color.white
                    
                    VStack(spacing : 5 ) {
                        //your custom layout text fields buttons
                        Text("Payment Procedure")
                            .font(.title3)
                        
                        
                        Text("Enter The Wallet Amount You Want To Recharge.")
                            .lineLimit(3)
                            .font(.custom("sf_pro", size: 14))
                            .padding(.horizontal)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.vertical , 5)
                        
                        
                        TextField("Amount"  , text: $txt)
                            .keyboardType(.decimalPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal)
                        
                        HStack(){
                            Text("CANCEL").onTapGesture {
                                
                                VM.showPaymentBox = false
                            }
                            
                                Spacer()
                                
                                Text("CONTINUE").onTapGesture {
                                    
                            
                                    VM.showPaymentBox.toggle()
                                    
                                   let total = Double(txt)
                                    
                                    
                                   VM.createPayment(amount: total ?? 0)
                                    
                                    
                                  //  viewModel.CreateOrder(isPaid: true, method: "WALLET")
                                    
                                }
                                                        
                            
                        }.padding(10)
                        
                        
                        
                        
                        
                        
                    }.padding()
                }
                .frame(width: 350, height: 220,alignment: .center)
                .cornerRadius(20).shadow(radius: 20)
                
            }
            
            
            HUDProgressView(placeholder: "Adding Payment !!!", show: $VM.is_Loading )
            
        }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/,  maxWidth: .infinity, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/,  maxHeight: .infinity, alignment: .top)
        
        
    }
}

struct walletCell  : View {
    var trans : WalletItem
    
    
    var body: some View{
        HStack{
            VStack(alignment : .leading , spacing : 10 ){
                HStack{
                    Button(action: {
                    }) {
                        Image("icon_bag")
                            .resizable()
                            .renderingMode(.template)
                        .foregroundColor(Color(cyanColor))
                            .frame( maxWidth: 15 ,maxHeight: 15 )
                            .padding(10)
                        
                    }.disabled(true).background(Color(UIColor(red: 0.84, green: 0.97, blue: 0.96, alpha: 1.00)))
                    .clipShape(Circle())
                   
                    let  type = trans.type ?? ""
                    
                    if type == "credit" {
                    
                        Text("Balance Added")
                            .font(.custom("sf_pro", size: 17))
                            .foregroundColor(.black)
                        
                    } else {
                        
                        Text("Product Purchased")
                            .font(.custom("sf_pro", size: 17))
                            .foregroundColor(.black)
                    }
                    
                    
                }
                
                Text(trans.amount ?? "")
                    .font(.custom("sf_pro", size: 22))
                    .foregroundColor(Color(cyanColor))
                    .padding(.leading , 25)
                
                let date = String(trans.date?.prefix(10) ?? "xxxxxxxxxx")
                
                HStack{
                    Text("on:" + date).foregroundColor(.gray)
                           
                }.padding(.leading , 25)
                
            }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/,  maxWidth: .infinity, alignment: .topLeading)
            
            Text("No chart data available.")
                .fontWeight(.bold)
                .bold()
                .frame(maxWidth: .infinity)
                .foregroundColor(.yellow)
                .font(Font.custom("sf_pro", size: 12))
                .frame(width: 150, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
        }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/,  maxWidth: .infinity, alignment: .top).padding(7)
    }
}

struct WalletUiIView_Previews: PreviewProvider {
    static var previews: some View {
        WalletUiIView()
    }
}

//struct MyMasterViewController: UIViewControllerRepresentable {
//    func makeUIViewController(context: Context) -> MasterViewController {
//        let sb = UIStoryboard(name: "Main", bundle: nil)
//        let vc = sb.instantiateViewController(identifier: "MasterViewController") as! MasterViewController
//        return vc
//    }
//
//    func updateUIViewController(_ uiViewController: MasterViewController, context: Context) {
//    }
//
//    typealias UIViewControllerType = MasterViewController
//}
