//
//  TransactionsUIView.swift
//  Afiq Souq
//
//  Created by GAMEKILLER on 4/22/21.
//

import SwiftUI
import SwiftUICharts

struct TransactionsUIView: View {
    @Environment(\.presentationMode) var presentation
    
    @StateObject var viewModel = TransactionListViewModel()
    
    var body: some View {
        ZStack{
            VStack{
                
                VStack(alignment: .leading, spacing: 10 ){
                    
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
                        
                        Text("Transactions")
                            .font(Font.custom("sf_pro", size: 17))
                            .lineLimit(1)
                        
                        
                        Spacer()
                        
                      
                            
                        
                    }.padding([.leading , .trailing , .top] , 5)
                    .frame(height: 40 , alignment: .center)
                    .background(Color(.white))
               
                    
                    Text("Spend Statistics")
                        .font(.title2)
                        .foregroundColor(.black)
                    
                    
                    LineView(data: [ ])
                        
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/,  maxHeight: .infinity, alignment: .top)
                
                    
                    
                }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/,  maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .top)
                
                VStack(alignment: .leading ){
                    
                    Text("Recent Spendings")
                        .font(.title2)
                        .foregroundColor(.black)
                    
                    
                    List{
                        
                        ForEach(Array(zip(viewModel.items.indices, viewModel.items)), id: \.0) { index, item in
                          // index and item are both safe to use here
                            
                           
                                previousTransCell(lineItem: item)
                                
                            
                           
                        }
                       
                        
                    }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/,  maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .top)
                    
                    
                    
                }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/,  maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .top)
                
                
            }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/,  maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .top)
            
            if (viewModel.isLoading) {
                
                ProgressView().progressViewStyle(CircularProgressViewStyle(tint: Color(cyanColor)))
            }
            
        }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/,  maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .top)
    }
}

struct previousTransCell : View {
    
    var lineItem : LineItem
   
    var body: some View {
        
        ZStack(alignment: .leading){
            RoundedRectangle(cornerRadius: 10, style: .continuous)
            .fill(Color(lightCyan))
            
            HStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(Color.gray).frame(minWidth: 75,  maxWidth: 75 , minHeight: 80 ,  maxHeight: 80 , alignment: .leading )
                        .padding([.top , .bottom] , 4 )
                        .padding([.leading , .trailing] , 5 )
                }
                
          
                VStack( alignment :.leading ,  spacing : 10 ){
                    
               
                    Text(lineItem.name ?? "")
                        .font(.custom("sf_pro", size: 16))
                        .foregroundColor(.black)
                    let dates = String((lineItem.sku ?? "xxxxxxxxxxxx").prefix(10))
                    
                    Text(dates)
                        .font(.custom("sf_pro", size: 14))
                        .foregroundColor(.gray)
                    
                    Spacer(minLength: 10)
                    
                    
                    
                    
                } .padding(.all , 8) .frame(minWidth: 0,  maxWidth: .infinity, minHeight: 0,  maxHeight: .infinity , alignment: .leading)
                
                
                VStack(alignment: .trailing){
                    Spacer()
                    
                  
                    Text( "-" + bdtSign + String(lineItem.price ?? 0)  )
                        
                        .font(.custom("sf_pro", size: 16))
                        .foregroundColor(.red)
                       
                    
                    Spacer()
                    
                 
                    
                    
                }.padding(.trailing , 8 )
                
            }.frame(minWidth: 0,  maxWidth: .infinity, minHeight: 90,  maxHeight: 100 , alignment: .leading)
        }
       
       
        .frame(minWidth: 0,  maxWidth: .infinity, minHeight: 90,  maxHeight: 100 , alignment: .leading)
        
       
        
      
        
        
    }
}


struct TransactionsUIView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsUIView()
    }
}
