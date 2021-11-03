//
//  infiniteListView.swift
//  Afiq Souq
//
//  Created by GAMEKILLER on 5/25/21.
//

import SwiftUI
struct infiniteListView: View {
    
    @StateObject var VM  : infinteViewModel = infinteViewModel()
    @State private var currentIndex = 00
    @State private var selectedProduct : Product = getDemoProduct()
    @State private var triggerNet : Int? = 0
    @State private var  cartCount : String = "0"
    @Environment(\.presentationMode) var presentation
    var body: some View {
        ZStack{
            let chunkedListOfPorduct = VM.ProductList.chunked(into: 2)
            
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
                    
                    Text("Shop")
                        .font(Font.custom("sf_pro", size: 17))
                        .lineLimit(1)
                    
                    
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
                        
                    
                    
                    
                }.padding([.leading , .trailing , .top] , 5)
                .frame(height: 45)
                .background(Color.white)
                
                List{
                    
                    ForEach(0..<chunkedListOfPorduct.count ,id: \.self ){ index in
                        HStack{
                            ForEach(chunkedListOfPorduct[index] ){ p in
                                
                                ProductCellsMe(isLast: false , product: p)
                                    
                        
                                    .onAppear(){
                                    
                                    if VM.ProductList.last?.id == p.id{
                                        VM.loadMoreProduct()
                                    }
                                    
                                    
    //                                if currentIndex == VM.ProductList.count/2 {
    //
    //
    //                                    VM.loadMoreProduct()
    //                                }
    //
    //                                currentIndex = currentIndex + 1
    //
    //                                print(String(currentIndex) + "tola " + String(VM.ProductList.count) )
                                    
                                }.onTapGesture{
                                    
                                selectedProduct = p
                                
                                triggerNet = 1
                                    
                                }
                                
                            }
                        }
                    }
                    
                    
                    
                }
                .frame(maxWidth: .infinity , maxHeight: .infinity )
                
                if VM.loadMore{
                    
                    ProgressView().progressViewStyle(CircularProgressViewStyle(tint: Color(cyanColor)))
                        .scaleEffect(1.5, anchor: .center)
                        .frame( alignment: .bottom)
                }
                
            }.frame(maxWidth: .infinity , maxHeight: .infinity )
            
       
            
            
            NavigationLink(destination: ProductDetailsUIView(product: selectedProduct ).navigationBarBackButtonHidden(true).navigationBarHidden(true), tag: 1, selection: $triggerNet) {
                
                    EmptyView()
                
                
            }
            
           
        
        } .onAppear{
            self.cartCount = getCartCount()
            
        }
    }
}

func getDemoProduct() -> Product {
    
    let list: [ProductImage] = []
    
    let p = Product.init(id: 0, name: "", slug: "", permalink: "", dateCreated: "", dateCreatedGmt: "", dateModified: "", dateModifiedGmt: "", type: "", status: "", featured: true, catalogVisibility: "", productItemDescription: "", shortDescription: "", sku: "", price: "", regularPrice: "", salePrice: "", onSale: true, purchasable: true, totalSales: 0, shippingRequired: true, shippingTaxable: true, shippingClass: "", shippingClassID: 0, reviewsAllowed: true, averageRating: "", ratingCount: 0, parentID: 0, images: list, stockStatus: "")
    
    return p
}


struct ProductCellsMe : View {
    var isLast :  Bool
    @State private var   showModal = false
    var   product : Product
    // @ObservedObject  var    viewModel : DashBoardViewModel
    var body: some View{
        
        VStack(alignment: .leading){
            
            if(!(product.images?.isEmpty ?? true)){
                let image : ProductImage = product.images![0]
                ImageViewerView(imageUrl: image.src ?? "teest")
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
//        .onTapGesture{
//            self.showModal = true
//        }.sheet(isPresented: self.$showModal, onDismiss: {
//            self.showModal = false
//        }, content: {
//
//            ProductDetailsUIView(product: product)
//        })
//
        
    }
}
struct infiniteListView_Previews: PreviewProvider {
    static var previews: some View {
        infiniteListView()
    }
}
