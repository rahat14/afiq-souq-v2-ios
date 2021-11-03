//
//  Noon_EveningviewUIView.swift
//  Afiq Souq
//
//  Created by GAMEKILLER on 5/9/21.
//

import SwiftUI

struct Noon_EveningviewUIView: View {
    @State private var searchText = ""
    @State private var showCancelButton: Bool = false
    @State private var  cartCount : String = "0"
    @Environment(\.presentationMode) var presentation
    let catModel : Int
    @StateObject  var  categoryDetailsViewModel : NoonEveingViewmodel
    let columnsCount  : [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    @State private var currentIndex = 00
    
    init(item : Int){
        self.catModel = item
        
         _categoryDetailsViewModel = StateObject(wrappedValue: NoonEveingViewmodel(item: item))
        
    }
    var body: some View {
        
        ZStack{
            VStack(alignment: .leading , spacing : 0 ){
                
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
                
                                               
                ScrollView{
                  VStack(alignment: .leading  ){
                       
                            VStack(spacing : 0){
                                
                                HStack {
                                    HStack {
                                        Image(systemName: "magnifyingglass")
                                        
                                        TextField("search", text: $searchText, onEditingChanged: { isEditing in
                                            self.showCancelButton = true
                                            
                                        }, onCommit: {
                                            
                                            categoryDetailsViewModel.searching = true
                                            categoryDetailsViewModel.loadProductList(search: searchText, page: 1)
                                            
                                            
                                            
                                        }).foregroundColor(.primary)
                                        
                                        Button(action: {
                                            self.searchText = ""
                                        }) {
                                            Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
                                        }
                                    }
                                    .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                                    .foregroundColor(.secondary)
                                    .background(Color(.secondarySystemBackground))
                                    .cornerRadius(10.0)
                                    
                                    if showCancelButton  {
                                        Button("Cancel") {
                                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
                                            // this must be placed before the other commands here
                                            self.searchText = ""
                                            self.showCancelButton = false
                                            categoryDetailsViewModel.searching = false
                                            categoryDetailsViewModel.loadProductList(search: "", page: 1)
                                            
                                        }
                                        .foregroundColor(Color(.systemBlue))
                                    }
                                }
                                .padding(.horizontal)
                                .padding(.vertical, 7)
                                .animation(.default)
                                .background(Color.white)
                                
                            }.background(Color(.lightGray))
                        
                        
                        ZStack(alignment: .bottom){
                          
                         //   let chunkData = categoryDetailsViewModel.mainProductList
                            
                            
                        LazyVGrid(columns: columnsCount){
                            ForEach( categoryDetailsViewModel.mainProductList , id: \.id){ Product in
                                
                                NavigationLink(
                                    destination: ProductDetailsUIView(product : Product)
                                        .navigationBarHidden(true)
                                    
                                ){
                                    ProductCells(isLast: false, product: Product)
                                        .padding(.bottom , 10 )
                                        .padding(.top , -5 )
                                        .onAppear{
                                        
                                        
                                        
                                        if currentIndex == categoryDetailsViewModel.mainProductList.count - 1 {
                                            
                                            categoryDetailsViewModel.loadMoreProduct()
                                        }
                                        
                                        currentIndex = currentIndex + 1
                                        
                                    }
                                    
                                }
                                
                                
                            }
                        }
                        .frame(minHeight: 0 , maxHeight: .infinity)
                                Spacer()
                            
                            if categoryDetailsViewModel.loading{
                                
                                ProgressView()
                            }
                            
                        }.frame(minWidth: 0  , maxWidth: .infinity , minHeight: 0 , maxHeight: .infinity)
                        
                    }
                                    
                }.frame(minWidth: 0  , maxWidth: .infinity , minHeight: 0 , maxHeight: .infinity)
                .onAppear{
                    self.cartCount = getCartCount()
                    
                }
                
                
                
                
            }.frame(minWidth: 0  , maxWidth: .infinity , minHeight: 0 , maxHeight: .infinity)
            
            HUDProgressView(placeholder: "Searching...", show: $categoryDetailsViewModel.searching)
        }
        
    }
}

struct Noon_EveningviewUIView_Previews: PreviewProvider {
    static var previews: some View {
        Noon_EveningviewUIView(item: 358)
    }
}
