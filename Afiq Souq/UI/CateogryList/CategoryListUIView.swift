//
//  CategoryListUIView.swift
//  Afiq Souq
//
//  Created by GAMEKILLER on 4/17/21.
//

import SwiftUI


struct CategoryListUIView: View {
    @Environment(\.presentationMode) var presentation
    let cateogryColumnCount  : [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    @StateObject private var viewModel = CategoryViewModel()
    var body: some View {
        
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
                
                Text("Cateogry List")
                    .font(Font.custom("sf_pro", size: 17))
                    .lineLimit(1)
                
                
                Spacer()
                
                NavigationLink(destination : CartPageUIView()
                                .navigationBarHidden(true)
                ){
                    HStack {
                        
                       
                        VStack(spacing: -4 ){
                            
                            HStack( spacing: 0){
                                Text(viewModel.getCartCount())
                                    .multilineTextAlignment(.center)
                                    .font(.custom("sf_pro", size: 14))
                                    .foregroundColor(.white)
                                    .frame(minWidth: 28)
                                    .background(Circle().fill(Color(cyanColor)))
                                    .padding(.leading)
                            }.frame(minWidth: 30 , alignment: .trailing )
                            
                           
                                
                                
                            
                            Image("cart_icon")
                               .resizable()
                                .frame(width: 22, height: 22)
                                .padding(.top , -2)
                            Spacer()
                        }
  
                    
                    }
                }
                    
                
                
                
            }.padding([.leading , .trailing , .top] , 5)
            .frame(height: 45)
           
           
            
            
            ScrollView(.vertical){
                
                
              
                LazyVGrid(columns: cateogryColumnCount){
                    
                    ForEach(viewModel.categoryList , id: \.id ){ cat in
                        NavigationLink(destination : CateogoryDetailsUIView(item: cat.id ?? 10).navigationBarHidden(true)){
                            
                            
                            categoryCellBig(CategoryItem: cat)
                        }
                        
                        
                    }
                    
                }
                
                
                
                
                
                
            }.frame(minWidth: 0,  maxWidth: .infinity, minHeight: 0,  maxHeight: .infinity)
        }
        
    }
}

struct CategoryListUIView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryListUIView()
    }
}
