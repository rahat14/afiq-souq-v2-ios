//
//  OldOrderDetailsView.swift
//  Afiq Souq
//
//  Created by GAMEKILLER on 4/19/21.
//

import SwiftUI



struct OldOrderDetailsView: View {
    @Environment(\.presentationMode) var presentation
    
    var orderObj : OldCartModel
    @State var showErrorMsg : Bool = false
    @State var showSuccess : Bool = false
    @State var show : Bool = false
    var body: some View {
        
        
        ZStack{
            
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
                    
                    Text("Order Detials")
                        .font(Font.custom("sf_pro", size: 17))
                        .lineLimit(1)
                    
                    
                    Spacer()
                    
                  
                        
                    
                }.padding([.leading , .trailing , .top] , 5)
                .frame(height: 40 , alignment: .center).background(Color(.white))
                
                ScrollView{
                    
                    VStack{
                        ForEach(orderObj.lineItems , id: \.id ){ item in
                            
                            CartCellOld(lineItem: item )
                        }
                    
                       
                        
                    }.frame(minWidth : 0  , maxWidth: .infinity , minHeight: 250 , maxHeight: 250 , alignment: .top)
                    
                    
                }.frame(minWidth : 0  , maxWidth: .infinity , minHeight: 0 , maxHeight: .infinity , alignment: .top)
                
                
                Color.gray.frame(height:CGFloat(3) / UIScreen.main.scale)
                    .frame(minWidth: 0,maxWidth: .infinity)
                    .padding()
                
                HStack{
                    Spacer().frame(minWidth : 100  , maxWidth: 100 )
                    
                    VStack(spacing : 5){
                        
                        HStack{
                            
                            let delivery = Int((orderObj.shippingTotal ?? "0" )) ?? 0
                            
                            let  total  = Int((orderObj.total ?? "0")) ?? 0
                            
                            let subTotal = total - delivery
                            
                            Text("Sub Total")
                                .font(.custom("sf_pro", size: 16))
                            Spacer()
                            Text(bdtSign + " " + String(subTotal))
                                .font(.custom("sf_pro", size: 16))
                        }
                        
                        HStack{
                            
                            Text("Tax")
                                .font(.custom("sf_pro", size: 16))
                            Spacer()
                            Text(bdtSign + " 0")
                                .font(.custom("sf_pro", size: 16))
                        }
                        
                        HStack{
                            
                            Text("Delivery Charge")
                                .font(.custom("sf_pro", size: 16))
                            Spacer()
                            Text(bdtSign + " " + (orderObj.shippingTotal ?? "" ))
                                .font(.custom("sf_pro", size: 16))
                        }
                        
                        Color.gray.frame(height:CGFloat(3) / UIScreen.main.scale)
                            .frame(minWidth: 0,maxWidth: .infinity)
                        HStack{
                            
                            Text("Total")
                                .font(.custom("sf_pro", size: 16))
                                .foregroundColor(Color(cyanColor))
                            Spacer()
                            Text(bdtSign + (orderObj.total ?? ""))
                                .font(.custom("sf_pro", size: 16))
                                .foregroundColor(Color(cyanColor))
                        }
                        
                    }
                    
                    Spacer().frame(minWidth : 30  , maxWidth: 30 )
                    
                    
                }.frame(minWidth : 0  , maxWidth: .infinity , minHeight: 0 , maxHeight: .infinity , alignment: .top)
                
                let status = orderObj.status ?? ""
                if(status == "pending"){
                Text("Cancel This Order")
                    
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .font(Font.custom("sf_pro", size: 19))
                    .padding(9)
                    .background(Color(cyanColor))
                    .cornerRadius(15)
                    .foregroundColor(.white)
                    .padding(10)
                    .onTapGesture(perform: {
                        
                        show = true
                        showErrorMsg = false
                        
                        // this iis test push
                      //  let isTrue =  cancelOrder(id: (22223) )
                        
                        NetworkManager.shared.CancelAOrder(for: (orderObj.id ?? 0 )){result  in
                            
                           
                            switch(result){
                            case .success( _):
                                // save the data"
                                // self?.saveUser(user: userDeatils)
                                
                                show = false
                                DispatchQueue.main.async {
                                    
                                    showSuccess = true
                                    
                                        
                               
                                    
                                }
                                
                                
                            case .failure(let errror ):
                                DispatchQueue.main.async {
                                    print(errror)
                                    
                                    show = false
                                    
                                    showErrorMsg = true
                                    
                                }
                                
                            }
                            
                    }
                })
                    
                }
                
            }.frame(minWidth : 0  , maxWidth: .infinity , minHeight: 0 , maxHeight: .infinity , alignment: .top)
            .alert(isPresented: $showErrorMsg) {
                
                        Alert(title: Text("Error"), message: Text("Could Not Cancel Your Order Try Again !!!"), dismissButton: .default(Text("Got it!")))
                    }
            .alert(isPresented: $showSuccess) {
                
                Alert(title: Text("Success"), message: Text("Your Order Was Successfully Canceled !!"), dismissButton: .default(Text("OK")))
                
                
                    
            }
            
            
            HUDProgressView(placeholder: "Cancelling Order", show: $show )
            
           
                
                
            
        }
       
    }
}



struct CartCellOld  : View {
    
    var lineItem: LineItem
    
    var body : some View{
        
        
        VStack(alignment: .leading , spacing: 5  ){
            
            Text(lineItem.name ?? "")
                .font(.custom("sf_pro", size: 16))
    
            
            HStack{
                Spacer()
                Text(bdtSign + "." + String(lineItem.price ?? 0) )
                    .fontWeight(.bold)
            }.frame(minWidth : 0  , maxWidth: .infinity , alignment: .trailing)
            Text("Qty X" + String(lineItem.quantity ?? 0))
                .font(.custom("sf_pro", size: 16))
            
            
            
        }.frame(minWidth : 0  , maxWidth: .infinity , minHeight: 70 , maxHeight: 70 , alignment: .topLeading)
        .padding(8)
        .background(Color(UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1.00)))
     
        
    
        
    }
    
    
    
}

//struct OldOrderDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        //OldOrderDetailsView()
//    }
//
//}
