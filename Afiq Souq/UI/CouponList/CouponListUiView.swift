//
//  CouponListUiView.swift
//  Afiq Souq
//
//  Created by GAMEKILLER on 4/19/21.
//

import SwiftUI

struct CouponListUiView: View {
    @Environment(\.presentationMode) var presentation
    
    @StateObject var  VM  = CouponListViewModel()
    
  
    
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
                    
                    Text("Coupons")
                        .font(Font.custom("sf_pro", size: 17))
                        .lineLimit(1)
                    
                    
                    Spacer()
                    
                  
                        
                    
                }.padding([.leading , .trailing , .top] , 5)
                .frame(height: 40 , alignment: .center).background(Color(.white))
                
                ScrollView{
                    VStack{
                        
                        ForEach(VM.couponList , id : \.id ){ couponItem in
                            CouponCell(item: couponItem)
                        }
                        
                        
                    }.frame(minWidth: 0 , maxWidth: .infinity , minHeight: 0 , maxHeight: .infinity , alignment: .top)
                }.frame(minWidth: 0 , maxWidth: .infinity , minHeight: 0 , maxHeight: .infinity , alignment: .top)
            }.frame(minWidth: 0 , maxWidth: .infinity , minHeight: 0 , maxHeight: .infinity , alignment: .top)
          
            if(VM.isLoading){
                
                ProgressView()
                    
                    .progressViewStyle(CircularProgressViewStyle(tint: Color(cyanColor)))
            }
           
            
        }
        
    }
    
  

}


struct CouponCell : View {
    var item : CouponModel
    var body: some View {
        
        
        
        ZStack{
            RoundedRectangle(cornerRadius: 0, style: .continuous)
                            .fill(Color(cyanColor))
                .shadow(radius: 5 )
            VStack{
               
                HStack(spacing : 0){
                    VStack(alignment : .leading , spacing : 5){
                        
                        Text("Coupon Code :" + (item.code ?? "") )
                            .bold()
                            .font(.custom("sf_pro", size: 16))
                            .foregroundColor(.white)
                        
                        Text("Minimum Spent " + (item.minimumAmount ?? "") + bdtSign)
                            .bold()
                            .font(.custom("sf_pro", size: 15))
                            .foregroundColor(.white)
                            .padding(4)
                        
                        
                        
                    }.frame(minWidth : 0 , maxWidth:  .infinity , minHeight: 0 , maxHeight: .infinity , alignment: .topLeading )
                    .padding(3)
                    
                    
                    ZStack{
                        VStack{
                            Text(bdtSign + (item.amount ?? "") + "off")
                                .bold()
                                .font(.title3)
                                .foregroundColor(.white)
                                .padding([.trailing], 10 )
                        }
                    }
                    
                }.frame(minWidth : 0 , maxWidth:  .infinity , minHeight: 0 , maxHeight: .infinity )
                
            }.padding(2)
        }
        .frame(minWidth : 0 , maxWidth:  .infinity , minHeight: 100 , maxHeight: 100 )
        .padding([.leading , .trailing, .top] , 10)
       
        
        
    }
}

struct CouponListUiView_Previews: PreviewProvider {
    static var previews: some View {
        CouponListUiView()
    }
}
