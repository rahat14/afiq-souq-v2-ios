//
//  ProductListUIView.swift
//  Afiq Souq
//
//  Created by GAMEKILLER on 4/8/21.
//

import SwiftUI
//import Kingfisher
struct ProductListUIView: View {
    @Environment(\.presentationMode) var presentation
    @StateObject  var ProductViewModel : ProductListViewModel
    let columnsCount  : [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    @State private var currentIndex = 00
    @State private var cartCount : String = "0"
    
    
    init(cateCode : Int){

        
        _ProductViewModel = StateObject(wrappedValue: ProductListViewModel(item : cateCode))
     
        
    }
    
    
    
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
                
                Spacer()
                
                Text("Products")
                    .lineLimit(1)
                    .font(Font.custom("sf_pro", size: 20))
                    
                
                Spacer()
                
                NavigationLink(destination : CartPageUIView()
                                .navigationBarHidden(true)
                ){
                    HStack {
                     
                        
                       
                        VStack(spacing: -4 ){
                            
                            HStack( spacing: 0){
                                Text(cartCount)
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
                
              
                
                
            }.padding([.leading , .trailing ] , 5)
            .frame(height: 45 , alignment: .center)
            ScrollView{
                
            
            ZStack(alignment: .bottom){
              
             //   let chunkData = categoryDetailsViewModel.mainProductList
                
                
                
                    LazyVGrid(columns: columnsCount){
                        ForEach( ProductViewModel.mainProductList , id: \.id){ Product in
                            
                            NavigationLink(
                                destination: ProductDetailsUIView(product : Product)
                                    .navigationBarHidden(true)
                                
                            ){
                                ProductCells(isLast: false, product: Product)
                                    .padding(.bottom , 10 )
                                    .padding(.top , -5 )
                                    .onAppear{
                                    
                                    
                                    
                                    if currentIndex == ProductViewModel.mainProductList.count - 1 {
                                        
                                        ProductViewModel.loadMoreProduct()
                                    }
                                    
                                    currentIndex = currentIndex + 1
                                    
                                }
                                
                            }
                            
                            
                        }
                    }
                
            .frame(minHeight: 0 , maxHeight: .infinity)
                    Spacer()
                
                ProgressView().progressViewStyle(CircularProgressViewStyle(tint: Color(cyanColor)))
                
            }.frame(minWidth: 0  , maxWidth: .infinity , minHeight: 0 , maxHeight: .infinity)
                
            }.frame(minWidth: 0  , maxWidth: .infinity , minHeight: 0 , maxHeight: .infinity)
            .onAppear{
                self.cartCount = getCartCount()
                
            }
                
            }
        }
        
        
    }

struct ProductCell : View {
    var isLast :  Bool
    var   product : Product
    @ObservedObject  var    viewModel : ProductListViewModel
    var body: some View{
        
        VStack(alignment: .leading){
            
            if(!(product.images?.isEmpty ?? true)){
                let image : ProductImage = product.images![0]
                
                
                
                ImageViewerView(imageUrl: image.src ?? "teest")
                    
//                    .fade(duration: 0)
//                    .resizable()
                    //.cacheMemoryOnly()
                    .frame(height: 155)
                
            }else {
                ImageViewerView(imageUrl: "https://lh3.googleusercontent.com/proxy/Mxb6JpWy3goRMMypWtn1E_d10yLSgMLwzMDVRNknxeeuSQt9JQFeP15x2OOMLpEo8Rwz1oBVlmNt04obv-SX9SYN7GIabpFFMh4NV28FVqcRzbvb3mQaqYzWp-wX5VTVZ_85NQ")
//                    .fade(duration: 0)
//                    .resizable()
                    .frame(height: 155)
            }
            VStack(alignment: .leading){
                
                
                if(isLast){
                    Text(product.name ?? "test")
                        .font(Font.custom("sf_pro", size: 15))
                        .foregroundColor(.primary)
                        .lineLimit(2)
                        .padding([.trailing , .leading ] , 2 )
                        .onAppear{
                            
                            // telll viewmodel to load more
                            // load more here
                            viewModel.loadMoreProduct()
                            
                            
                }
                }
                else {
                    Text(product.name ?? "test")
                        .font(Font.custom("sf_pro", size: 15))
                        .foregroundColor(.primary)
                        .padding([.trailing , .leading ] , 2 )
                        .lineLimit(2)
                }
                
                
                
                    if(product.salePrice == product.regularPrice ){
                        
                        Text( bdtSign + " " + (product.price ?? "test"))
                            .font(Font.custom("sf_pro", size: 15))
                            .fontWeight(.heavy)
                            .padding(.top , 2)
                            .foregroundColor(Color(cyanColor))
                        
                    }else {
                        Text( bdtSign + " " + (product.regularPrice ?? "test"))
                            .font(Font.custom("sf_pro", size: 14))
                            .fontWeight(.heavy)
                            .strikethrough()
                            .padding(.top , 2)
                            .foregroundColor(.secondary)
                        
                        Text( bdtSign + " " + (product.price ?? "test"))
                            .font(Font.custom("sf_pro", size: 15))
                            .fontWeight(.heavy)
                            
                            .foregroundColor(Color(cyanColor))
                        
                    }
              
                    
                
            }.padding([.leading , .bottom] , 8 )
            
            
        }.background(Color(.systemBackground))
        .cornerRadius(5)
        .shadow(color: Color.gray.opacity(0.6) , radius: 10 )
        
        
    }
}


struct ProductListUIView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListUIView(cateCode:  110 )
    }
}

