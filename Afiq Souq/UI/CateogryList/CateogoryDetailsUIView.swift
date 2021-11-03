//
//  CateogoryDetailsUIView.swift
//  Afiq Souq
//
//  Created by GAMEKILLER on 4/17/21.
//
//import Kingfisher
import SwiftUI

struct CateogoryDetailsUIView: View {
    @State private var searchText = ""
    @State private var showCancelButton: Bool = false
    @State private var  cartCount : String = "0"
    @Environment(\.presentationMode) var presentation
    let catModel : Int
    @StateObject  var  categoryDetailsViewModel : CategoryDetailsViewModel
    let columnsCount  : [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    @State private var currentIndex = 00
    
    init(item : Int){
        self.catModel = item
        
         _categoryDetailsViewModel = StateObject(wrappedValue: CategoryDetailsViewModel(item: item))
     //   _object = StateObject(wrappedValue: MyObject(id: id))
        
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
                    
                    Text("Category Detalis")
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
                                .padding(.vertical,4)
                                .animation(.default)
                                .background(Color.white)
                                
            
                                
                                ScrollView(.horizontal) {
                                    HStack(spacing: 10) {
                                        ForEach( categoryDetailsViewModel.subCateList, id: \.id) {  offfer in
                                                NavigationLink(
                                                    destination: ProductListUIView(cateCode: offfer.id ?? 10 )
                                                        .navigationBarHidden(true)){
                                                    
                                                    categoryCellHorizontral(CategoryItem: offfer)
                                                         
                                                
                                                .cornerRadius(12)
                                                .padding([.top , .bottom] , 5 )
                                                        
                                                    
                                                    
                                             }
                                            }

                                    }
                                }
                                
                            }.background(Color(.lightGray))
                        
                        Text("Featured")
                            .font(.custom("sf_pro", size: 20))
                            .bold().padding([.top , .bottom] , 5 )
                        
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

struct  categoryCellHorizontral : View {
    var CategoryItem : CategoryModel
    
    var body: some View{
        
        VStack(spacing: 10){
            
            let title = CategoryItem.name
            
            Spacer()
            
            
            let parsed = title?.replacingOccurrences(of: "amp;", with: "")
            
            ImageViewerView(imageUrl: CategoryItem.image?.src ?? PLACEHOLDER_IMG_LINK)
//                .cancelOnDisappear(true)
//                .fade(duration: 0)
//                .resizable()
                .scaledToFit()
                .frame(maxWidth: 100, maxHeight: 100 , alignment: .center)
            
            
            
//            KFImage(URL(string: CategoryItem.image?.src ?? PLACEHOLDER_IMG_LINK))
//                .cancelOnDisappear(true)
//                .fade(duration: 0)
//                .resizable()
//                .scaledToFit()
//                .frame(maxWidth: 100, maxHeight: 100 , alignment: .center)
            
            Spacer()
            
            Text(parsed ??  "Cateogry Name")
                .lineLimit(1)
                .font(.custom("sf_pro", size: 16))
                .multilineTextAlignment(.center)
                .frame(maxHeight: 45 , alignment: .top)
                .foregroundColor(.black)
            
            
        }.frame(width: 140  , height: 120 )
        .padding(.all , 2 )
    
        .background(Color.white)
        
    }
}

struct ProductCellInCategory : View {
    var isLast :  Bool
    var   product : Product
    @StateObject  var    viewModel : CategoryDetailsViewModel
    var body: some View{
        
        VStack(alignment: .leading){
            
            if(!(product.images?.isEmpty ?? true)){
                let image : ProductImage = product.images![0]
                
//                KFImage(URL(string: image.src ?? "teest"))
//
//                    .fade(duration: 0)
//                    .resizable()
//                    .cacheMemoryOnly()
//                    .frame(height: 175)
                
                ImageViewerView(imageUrl: image.src ?? "teest")
                    
//                    .fade(duration: 0)
//                    .resizable()
//                    .cacheMemoryOnly()
                    .frame(height: 175)
                
            }else {
                ImageViewerView(imageUrl: "https://lh3.googleusercontent.com/proxy/Mxb6JpWy3goRMMypWtn1E_d10yLSgMLwzMDVRNknxeeuSQt9JQFeP15x2OOMLpEo8Rwz1oBVlmNt04obv-SX9SYN7GIabpFFMh4NV28FVqcRzbvb3mQaqYzWp-wX5VTVZ_85NQ")
                
//                    .fade(duration: 0)
//                    .resizable()
                    .frame(height: 175)
//                KFImage(URL(string: "https://lh3.googleusercontent.com/proxy/Mxb6JpWy3goRMMypWtn1E_d10yLSgMLwzMDVRNknxeeuSQt9JQFeP15x2OOMLpEo8Rwz1oBVlmNt04obv-SX9SYN7GIabpFFMh4NV28FVqcRzbvb3mQaqYzWp-wX5VTVZ_85NQ"))
//
//                    .fade(duration: 0)
//                    .resizable()
//                    .frame(height: 175)
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
                            
                          //  print(  "Requsting To Load of -> " + String(viewModel.page) )
                            
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

struct CateogoryDetailsUIView_Previews: PreviewProvider {
    static var previews: some View {
        //CateogoryDetailsUIView()
        
        categoryCellHorizontral(CategoryItem: CategoryModel.init(id: 1, name: "Test d", slug: "", parent: 4, categoryDescription: "", display: "d", image: nil))
    }
}
