//
//  OldOrderListUIView.swift
//  Afiq Souq
//
//  Created by GAMEKILLER on 4/19/21.
//

import SwiftUI

struct OldOrderListUIView: View {
    @Environment(\.presentationMode) var presentation
    @StateObject var viewModel = oldOrderListViewModel()
    
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
                    
                    Text("Past Orders")
                        .font(Font.custom("sf_pro", size: 17))
                        .lineLimit(1)
                    
                    
                    Spacer()
                    
                  
                        
                    
                }.padding([.leading , .trailing , .top] , 5)
                .frame(height: 40 , alignment: .center).background(Color(.white))
                ScrollView{
                    VStack{
                        
                        ForEach(viewModel.oldCartModelList , id: \.id){ index in
                            
                        NavigationLink(
                            destination: OldOrderDetailsView(orderObj: index).navigationBarHidden(true))
                        {
                            previousOrderCell(oldCartItem: index)
                        }
                       
                        
                       
                       }
                        
                    }.frame(minWidth: 0,  maxWidth: .infinity, minHeight: 0,  maxHeight: .infinity , alignment: .top)
                }.frame(minWidth: 0,  maxWidth: .infinity, minHeight: 0,  maxHeight: .infinity , alignment: .top)
                
            
               
            }.background(Color(UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1.00)))
            
            if(viewModel.isLoading){
                
                ProgressView().progressViewStyle(CircularProgressViewStyle(tint: Color(cyanColor)))
                    
            }
           
        }
        
    }
}

struct previousOrderCell : View {
    
    var oldCartItem : OldCartModel
    var body: some View {
        
        ZStack(alignment: .leading){
            RoundedRectangle(cornerRadius: 10, style: .continuous)
            .fill(Color.white)
      
            
            HStack(){
                
                VStack(alignment : .leading , spacing: 3){
                    Text("Order ID : APP_" + String(oldCartItem.id ?? 0 ) )
                        .font(.custom("sf_pro", size: 15))
                        .foregroundColor(.black)
                        .bold()
                    
                    let date = String(oldCartItem.dateCreated?.prefix(10) ?? "sdfasdfasdfasdfasdfasdfasfasdf")
                    
                    Text("Date : " + date )
                        .font(.custom("sf_pro", size: 14))
                        .bold()
                        .foregroundColor(.black)
                    Spacer()
                    
                    
                }.frame(minWidth: 0,  maxWidth: .infinity, minHeight: 0,  maxHeight: .infinity , alignment: .leading )
                
               
                
                VStack(alignment: .trailing){
                    Spacer()
                    
                  
                    Text(oldCartItem.status ?? "N/A" )
                        .italic()
                        .font(.custom("sf_pro", size: 15))
                        .foregroundColor(.black)
                       
                    
                    Spacer()
                    
                    HStack{
                        
            
                        
                        Text(String( oldCartItem.lineItems.count ) + " items," )
                            .font(.custom("sf_pro", size: 14))
                            .foregroundColor(.black)

                        Text("Total:" )
                            .font(.custom("sf_pro", size: 15))
                            .foregroundColor(.black)
                        
                        Text( bdtSign + (oldCartItem.total ?? "") )
                            .font(.custom("sf_pro", size: 15))
                            .foregroundColor(Color(cyanColor))
                           
                        
                    }
                    
                    
                }
                
                
                Spacer(minLength: 10)
                
                
                
                
            } .padding(.all , 8) .frame(minWidth: 0,  maxWidth: .infinity, minHeight: 0,  maxHeight: .infinity , alignment: .leading)
        }
       
       
        .frame(minWidth: 0,  maxWidth: .infinity, minHeight: 90,  maxHeight: 100 , alignment: .leading)
        .padding([.leading , .trailing] , 6)
      
        
        
    }
}


struct OldOrderListUIView_Previews: PreviewProvider {
    static var previews: some View {
        OldOrderListUIView()
    }
}
