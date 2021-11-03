//
//  DashBoardUIView.swift
//  Afiq Souq
//
//  Created by GAMEKILLER on 4/6/21.
//

import SwiftUI
//import Kingfisher
import RealmSwift


struct DashBoardUIView: View {
    @State private  var selected = 0
    @State private var  drawerShown = false
    @StateObject var ViewModel  : DashBoardViewModel = DashBoardViewModel()
    @State private  var ss : String = ""
    @State private var cartCount = "0"
    @State private var catCode : Int = 398
    @State private var triggerNOON : Int?  = 0
   
    
    var body: some View {
        
        ZStack{
            
            NavigationLink(destination: Noon_EveningviewUIView(item: catCode).navigationBarHidden(true) , tag : 1
                           , selection : $triggerNOON
            ){
                
            }
            
            VStack{
                HStack{
                    
                    
                    
                    Button(action: {
                        
                        drawerShown.toggle()
                        
                    }) {
                        
                        
                        HStack {
                            
                            Image(systemName: "text.alignleft")
                                .font(Font.custom("sf_pro", size: 20))
                                .foregroundColor(Color(darkBlue))
                            
                        }
                        
                        
                    }
                    
                    
                    
                    
                    if $selected.wrappedValue >  0 {
                        
                        Spacer()
                        
                        Text("Discover")
                            .lineLimit(1)
                            .font(Font.custom("sf_pro", size: 20))
                        
                        
                        
                        Spacer()
                        
                        
                    }else {
                        HStack(spacing : 7){
                            
                            
                            //                            Button(action: {
                            //                                self.catCode = 398
                            //                                self.triggerNOON = 1
                            //                            }) {
                            //
                            //
                            //                                    Text("  Morning  " ) .foregroundColor(.white)
                            //
                            //                                .padding(8)
                            //                                .frame(  maxWidth: .infinity ,minHeight: 30 ,maxHeight: 30)
                            //                                .background(Color(cyanColor))
                            //                                .cornerRadius(8.0)
                            //
                            //
                            //                            }
                            
                            Text("MORNING")
                                .font(.custom("lato", size: 15))
                                .foregroundColor(.white)
                                .onTapGesture {
                                    self.catCode = 398
                                    self.triggerNOON = 1
                                }
                                .padding(8)
                                .frame(maxWidth: .infinity , minHeight: 35 ,maxHeight: 35 )
                                .background(Color(cyanColor))
                                .cornerRadius(9.0)
                            
                            
                            
                            
                            Text("EVENING")
                                .font(.custom("lato", size: 15))
                                .foregroundColor(.white)
                                .onTapGesture {
                                    self.catCode = 0
                                    self.triggerNOON = 1
                                }
                                .padding(8)
                                .frame(maxWidth: .infinity , minHeight: 35 ,maxHeight: 35 )
                                .background(Color(lightGreen))
                                .cornerRadius(9.0)
                            
                            
                            
                            
                            //                            Button(action: {
                            //
                            //                            }) {
                            //
                            //                                    Text("  Evening  ")
                            //
                            //
                            //
                            //                            }
                            
                            
                        }
                        .fixedSize(horizontal: false, vertical: true)
                        .frame( maxWidth: .infinity)
                        
                    }
                    
                    
                    
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
                                .onAppear{
                                    self.cartCount = ViewModel.getCartCount()
                                    
                                }
                                
                                
                                
                                
                                
                                
                                Image("cart_icon")
                                    .resizable()
                                    .frame(width: 22, height: 22)
                                    .padding(.top , -2)
                                Spacer()
                            }
                            
                            
                        }
                    }
                    
                    
                    
                    
                }.padding([.leading , .trailing ] , 5)
                .frame(height: 45)
                
                
                
                ZStack(alignment: .bottom){
                    
                    
                    
                    TabView(selection: $selected){
                        
                        
                        
                        
                        Home(dashboardViewModel: ViewModel , selected: $selected)
                            .tabItem{
                                Text("home")
                                
                            }
                            .tag(0) .navigationBarTitle("") //this must be empty
                            .navigationBarHidden(true)
                            .navigationBarBackButtonHidden(true)
                        
                        CategoryPage(dashViewModel: ViewModel)
                            .tabItem{
                                Text("cateogry")
                                
                            }.tag(1) .navigationBarTitle("") //this must be empty
                            .navigationBarHidden(true)
                            .navigationBarBackButtonHidden(true)
                        
                        SearchPage(viewModel: ViewModel)
                            .tabItem{
                                Text("Folder")
                                
                            }.tag(2) .navigationBarTitle("") //this must be empty
                            .navigationBarHidden(true)
                            .navigationBarBackButtonHidden(true)
                        
                        Profile()
                            .tabItem{
                                Text("Foer")
                                
                            }.tag(3) .navigationBarTitle("") //this must be empty
                            .navigationBarHidden(true)
                            .navigationBarBackButtonHidden(true)
                        
                        
                    } .navigationBarTitle("") //this must be empty
                    .navigationBarHidden(true)
                    .navigationBarBackButtonHidden(true)
                    .onAppear{
                        UITabBar.appearance().isHidden = true
                    }
                    
                    
                    
                    
                    VStack(){
                        ZStack(alignment: .bottom){
                            
                            BottomBar(selected: self.$selected, VM: ViewModel)
                                .padding()
                                .padding(.horizontal, 22)
                                
                                .background(CurvedShape())
                            
                            Button(action: {
                                
                                selected = 0
                                
                                
                            }) {
                                
                                
                                Image(systemName: "square.grid.2x2")
                                    .foregroundColor(.white)
                                    .font(.title)
                                    .padding(18)
                                
                            }.background(Color(cyanColor))
                            .clipShape(Circle())
                            .offset(y: -35)
                            .shadow(radius: 4)
                            
                        }
                    }.frame(maxWidth: .infinity , alignment: .bottom)
                    
                    if(ViewModel.loadMore){
                        
                        ProgressView().progressViewStyle(CircularProgressViewStyle(tint: Color(cyanColor)))
                        
                        
                    }
                    
                }.frame(minHeight: 0 , maxHeight: .infinity )
                
                
            }
            
            if drawerShown {
                
                drawerView(shown: $drawerShown)
                    .animation(.spring())
                
                
            }
        }
        .navigationBarTitle("") //this must be empty
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        
        
        
        
        
    }
}




struct Home : View {
    
    @StateObject var dashboardViewModel : DashBoardViewModel
    @Binding  var selected : Int
    //  @ObservedObject  var ProductViewModel : ProductListViewModel =  ProductListViewModel()
    @State var txt = ""
    //  @State var edge = UIApplication.shared.windows.first?.safeAreaInsets
    
    let columnsCount  : [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    let cateogryColumnCount  : [GridItem] = Array(repeating: .init(.flexible()), count: 4 )
    let rows: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    private let timer  = Timer.publish(every: 3 , on: .main , in: .common).autoconnect()
    @State private var currentIndex = 00
    
    //    init() {
    //           //Use this if NavigationBarTitle is with Large Font
    //          // UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "sf_pro", size: 20)!]
    //        UINavigationBar.appearance().largeTitleTextAttributes = [.font:UIFont.preferredFont(forTextStyle:.title2)]
    //           //Use this if NavigationBarTitle is with displayMode = .inline
    //           //UINavigationBar.appearance().titleTextAttributes = [.font : UIFont(name: "Georgia-Bold", size: 10)!]
    //       }
    var body: some View{
        
        
        ScrollView(.vertical){
            
            VStack{
                VStack{
                    
                    HStack {
                        Image(systemName: "magnifyingglass")
                        
                        TextField("search", text: $txt, onEditingChanged: { isEditing in
                            
                        }).disabled(true).foregroundColor(.primary)
                        
                        
                    }
                    .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                    .foregroundColor(.secondary)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10.0)
                    .padding(.vertical,12)
                    .padding(.horizontal)
                    .onTapGesture {
                        selected = 2
                    }
                    
                    
                    //                HStack(spacing: 15){
                    //
                    //                    Image(systemName: "magnifyingglass")
                    //                        .foregroundColor(.gray)
                    //
                    //                    TextField("Search Products", text: $txt).disabled(true)
                    //
                    //                }
                    //                .padding(.vertical,12)
                    //                .padding(.horizontal)
                    //                .background(Color.white)
                    //                .clipShape(Capsule())
                    //                .onTapGesture(perform: {
                    //                    selected = 3
                    //                })
                    
                    GeometryReader { geometry in
                        ImageCarouselView(numberOfImages: 5) {
                            
                        

                            ForEach(0..<6) { num in
                                
                                ImageViewerView(imageUrl: Paths.banner_path + String(num+1) + ".jpg")
                                    //                            .placeholder{
                                    //                                Image("placeholder")
                                    //                                .resizable()
                                    //                                    .frame(maxHeight : 250)
                                    //                            }
//                                    .cancelOnDisappear(true)
//                                    .fade(duration: 0)
//                                    .resizable()
                                    .scaledToFill()
                                    .frame( width: geometry.size.width, height: geometry.size.height , alignment: .center)
                                    .clipped()
//                                KFImage(URL(string: Paths.banner_path + String(num+1) + ".jpg"))
//                                    //                            .placeholder{
//                                    //                                Image("placeholder")
//                                    //                                .resizable()
//                                    //                                    .frame(maxHeight : 250)
//                                    //                            }
//
//                                    .cancelOnDisappear(true)
//                                    .fade(duration: 0)
//                                    .resizable()
//                                    .scaledToFill()
//                                    .frame( width: geometry.size.width, height: geometry.size.height , alignment: .center)
//                                    .clipped()


                            }

                        }
                    }.frame(height: 220)
                    // sliderView()
        //            sliderView()
                    horizontralCateogry().padding([.top, .bottom] , 10)
                    
                    HStack{
                        Text(" Shop By Category")
                            .font(Font.custom("sf_pro", size: 16))
                        
                        Spacer()
                        
                        NavigationLink(destination:  CategoryListUIView().navigationBarHidden(true)){
                            
                            Text(" View All ")
                                .font(Font.custom("sf_pro", size: 16))
                                .foregroundColor(Color(cyanColor))
                                .padding(.all , 2)
                                .border(Color(cyanColor), width: 2)
                                .cornerRadius(4)
                                .padding(.trailing , 4 )
                            
                        }
                        
                        
                        
                    }.frame(maxWidth: .infinity).padding(.top , 2)
                    
                    
                    
                    
                    VStack{
                        
                        HStack{
                            
                            ForEach(dashboardViewModel.a , id: \.id){ cat in
                                
                                
                                
                                
                                NavigationLink(destination: CateogoryDetailsUIView(item: cat.id ?? 10 ).navigationBarHidden(true)
                                ){
                                    categoryCellSmall(CategoryItem: cat)
                                }
                                
                                
                            }
                            
                        }
                        
                        HStack{
                            
                            ForEach(dashboardViewModel.b , id: \.id){ cat in
                                
                                
                                NavigationLink(destination: CateogoryDetailsUIView(item: cat.id ?? 10 ).navigationBarHidden(true)
                                ){
                                    categoryCellSmall(CategoryItem: cat)
                                }
                                
                            }
                            
                        }
                        
                        HStack{
                            
                            ForEach(dashboardViewModel.c , id: \.id){ cat in
                                
                                
                                NavigationLink(destination: CateogoryDetailsUIView(item: cat.id ?? 10 ).navigationBarHidden(true)
                                ){
                                    categoryCellSmall(CategoryItem: cat)
                                }
                            }
                            
                        }
                        
                    }.frame(minWidth : 0, maxWidth: .infinity )
                    
                    
                    
                    
                    
                    //                LazyVGrid(columns: cateogryColumnCount){
                    //
                    //                    ForEach(dashboardViewModel.categoryList , id: \.id ){ cat in
                    //                        NavigationLink(destination: CateogoryDetailsUIView(item: cat.id ?? 10 ).navigationBarHidden(true)
                    //                        ){
                    //                            categoryCellSmall(CategoryItem: cat)
                    //                        }
                    //
                    //
                    //                    }
                    //
                    //                }
                    
                    // combo offer start
                    HStack{
                        Text(" Combo Offers")
                            .font(Font.custom("sf_pro", size: 16))
                        
                        Spacer()
                        
                        NavigationLink(destination: CateogoryDetailsUIView(item: 325)
                                        .navigationBarHidden(true)){
                            
                            Text(" View All ")
                                .font(Font.custom("sf_pro", size: 16))
                                .foregroundColor(Color(cyanColor))
                                .padding(.all , 2)
                                .border(Color(cyanColor), width: 2)
                                .cornerRadius(4)
                                .padding(.trailing , 4 )
                            
                        }
                        
                        
                        
                    }.frame(maxWidth: .infinity).padding(.top , 2)
                    
                    
              
                        
                        
                        ScrollView(.horizontal) {
                            HStack(spacing: 4) {
                                
                                
                                if(dashboardViewModel.comboOfferList.count > 0){
                                    let chunck = dashboardViewModel.comboOfferList.chunked(into: 2 )
                                    
                                    
                                    ForEach( 0..<chunck.count , id: \.self ){ index in
                                        
                                        Text("")
                                        VStack(spacing: 25){
                                            
                                            Text("")
                                            
                                            ForEach(chunck[index] , id: \.id){ item in
                                                
                                                NavigationLink(
                                                    destination: ProductDetailsUIView(product : item)
                                                        .navigationBarHidden(true)){
                                                    
                                                    ProductCellsHorizontral(isLast: false, product: item )
                                                        
                                                    
                                                    
                                                }
                                                
                                                Text("")
                                                
                                                
                                            }
                                            
                                            
                                        }
                                     
                                        
                                    }
                                }
                                
                                //                                ForEach( dashboardViewModel.comboOfferList, id: \.id) {  offfer in
                                //                                    NavigationLink(
                                //                                        destination: ProductDetailsUIView(product : offfer)
                                //                                            .navigationBarHidden(true)){
                                //
                                //
                                //                                }
                                //                                }
                            }
                        }
                        
                        
                  
                    
                    
                    // combo offer ends
                    
                    
                    //  electronics starts
                    
                    HStack{
                        Text(" Electronics")
                            .font(Font.custom("sf_pro", size: 16))
                            .bold()
                        
                        Spacer()
                        
                        NavigationLink(destination: CateogoryDetailsUIView(item: 440).navigationBarHidden(true)){
                            
                            Text(" View All ")
                                .font(Font.custom("sf_pro", size: 16))
                                .foregroundColor(Color(cyanColor))
                                .padding(.all , 2)
                                .border(Color(cyanColor), width: 2)
                                .cornerRadius(4)
                                .padding(.trailing , 4 )
                        }
                        
                        
                        
                    }.frame(maxWidth: .infinity).padding(.top , 2)
                    
                    
                    VStack{
                        
                        
                        ScrollView(.horizontal) {
                            HStack(spacing: 10) {
                                ForEach( dashboardViewModel.electronicsList, id: \.id) {  offfer in
                                    NavigationLink(
                                        destination: ProductDetailsUIView(product : offfer)
                                            .navigationBarHidden(true)){
                                        
                                        ProductCellsHorizontral(isLast: false, product: offfer)
                                            .padding([.top , .bottom] , 40 )
                                        
                                        
                                    }
                                }
                                
                            }
                        }
                    }
                    
                    
                }
                
                // electronic ends
                
                //  Beauty  starts
                
                HStack{
                    Text(" Health & Beauty")
                        .font(Font.custom("sf_pro", size: 16))
                        .bold()
                    
                    Spacer()
                    
                    NavigationLink(destination: CateogoryDetailsUIView(item: 330).navigationBarHidden(true)){
                        
                        Text(" View All ")
                            .font(Font.custom("sf_pro", size: 16))
                            .foregroundColor(Color(cyanColor))
                            .padding(.all , 2)
                            .border(Color(cyanColor), width: 2)
                            .cornerRadius(4)
                            .padding(.trailing , 4 )
                    }
                }.frame(maxWidth: .infinity).padding(.top , 2)
                
                
                VStack{
                    
                    
                    ScrollView(.horizontal) {
                        HStack(spacing: 10) {
                            
                            ForEach( dashboardViewModel.health_beautyList, id: \.id) {  offfer in
                                NavigationLink(
                                    destination: ProductDetailsUIView(product : offfer)
                                        .navigationBarHidden(true)){
                                    
                                    ProductCellsHorizontral(isLast: false, product: offfer)
                                        .padding([.top , .bottom] , 40 )
                                    
                                    
                                }
                            }
                            
                        }
                    }
                }
                
                
                
                
                // electronic ends
                
                
                HStack{
                    Text(" Products")
                        .font(Font.custom("sf_pro", size: 16))
                        .bold()
                    
                    Spacer()
                    
                    
                }.frame(maxWidth: .infinity).padding(.top , 2)
                
                
              //  let chunkedListOfPorduct = dashboardViewModel.ProductList.chunked(into: 2)
                
                                    LazyVGrid(columns: columnsCount){
                                        ForEach(dashboardViewModel.ProductList , id: \.id){ Product in
                
                                            NavigationLink(
                                                destination: ProductDetailsUIView(product : Product)
                                                    .navigationBarHidden(true)
                
                                            ){
                                                ProductCells(isLast: false, product: Product)
                                                   // .onAppear{
//                                                    if currentIndex == dashboardViewModel.ProductList.count - 1 {
//
//
//                                                        dashboardViewModel.loadMoreProduct()
//                                                    }
//
//                                                    currentIndex = currentIndex + 1
                
                                              //  }
                                            }
                
                
                                        }
                                    }.id(UUID())
                                    .padding([.leading , .trailing] , 1 )
                                   
                
                if(dashboardViewModel.loadMore == false  ){
                    
                    NavigationLink(
                        destination: infiniteListView()
                            .navigationBarHidden(true)){
                        Text("Browse More")
                            .font(.title3)
                            .padding(.bottom , 100)
                    }
                   
                        
                }
                
                
//             LazyVStack{
//                    ForEach( 0..<chunkedListOfPorduct.count , id: \.self){ index in
//
//
//                       HStack{
//
//                                ForEach(chunkedListOfPorduct[index]){ Product in
//
//                                    NavigationLink(
//                                        destination: ProductDetailsUIView(product : Product)
//                                            .navigationBarHidden(true)
//
//                                    ){
//
//                                    ProductCells(isLast: false, product: Product)
//
//
//
//                                }
//
//                                }
//
//
//
//                              //  ProductCells(isLast: false, product: Product)
//
//                            }
////                        LazyHStack{
////
////                        }
////                        .background(Color.red)
////                        .frame(width: 0, height:   1 ).onAppear{
//
////                        Text("")
////                            .onAppear{
////                            print(currentIndex)
////                            print("full length"  + String(dashboardViewModel.ProductList.count))
////                            if currentIndex >= (dashboardViewModel.ProductList.count) - 1{
////
////
////                                dashboardViewModel.loadMoreProduct()
////                            }
////
////                            currentIndex = currentIndex + 2
////
////                        }
//                        //}
//
//
//                    }
//
//
//
//
//
//
//                    Spacer(minLength: 30)
//
//
//                }.padding(.bottom , 30)
//
                
                
                
            }
            
            
            
        }.frame(maxHeight: .infinity)
        
        
        
        
    }
}


private struct OffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {}
}

struct ProductCells : View {
    var isLast :  Bool
    var   product : Product
    // @ObservedObject  var    viewModel : DashBoardViewModel
    var body: some View{
        
        VStack(alignment: .leading){
            
            if(!(product.images?.isEmpty ?? true)){
                let image : ProductImage = product.images![0]
                
                ImageViewerView(imageUrl: image.src ?? "teest")
//                    .cancelOnDisappear(true)
                   // .loadImmediately(true)
//                    .fade(duration: 0)
//                    .resizable()
                    .frame(height: 155)
                
//                KFImage(URL(string: image.src ?? "teest"))
//                    .cancelOnDisappear(true)
//                    .loadImmediately(true)
//                    .fade(duration: 0)
//                    .resizable()
//                    .frame(height: 155)
                
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
        
        
    }
}

struct ProductCellsHorizontral : View {
    var isLast :  Bool
    var   product : Product
    // @ObservedObject  var    viewModel : DashBoardViewModel
    var body: some View{
        
        VStack(alignment: .leading){
            
            
            if(!(product.images?.isEmpty ?? true)){
                let image : ProductImage = product.images![0]
                
                ImageViewerView(imageUrl: image.src ?? "teest")
                    
//                    .cancelOnDisappear(true)
                    //.downsampling(size: CGSize(width: 150, height: 150))
//                    .fade(duration: 0)
//                    .resizable()
                    .frame(height: 155)
                
            }else {
                ImageViewerView(imageUrl: PLACEHOLDER_IMG_LINK)
//                    .fade(duration: 0)
//                    .resizable()
                    .frame(height: 155)
            }
            VStack(alignment: .leading){
                
                let title = product.name
                
                let parsed = title?.replacingOccurrences(of: "amp;", with: "")
                if(isLast){
                    Text(parsed ?? "test")
                        .font(Font.custom("sf_pro", size: 15))
                        .foregroundColor(.primary)
                        .lineLimit(2)
                        .padding([.trailing , .leading ] , 2 )
                        .onAppear{
                            
                            // telll viewmodel to load more
                            // load more here
                            //     viewModel.loadMoreProduct()
                            
                            //   print(  "Requsting To Load of -> " + String(viewModel.page) )
                            
                        }
                }
                else {
                    
                    Text(parsed ?? "test")
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
        .frame(width: 200 , height: 180 )
        .padding(5)
        
        
        
    }
}

struct CourseCardView : View {
    
    var course : Course
    
    var body: some View{
        
        VStack{
            
            VStack{
                
                Image(course.asset)
                    .resizable()
                    .renderingMode(.original)
                    .aspectRatio(contentMode: .fit)
                    .padding(.top,10)
                    .padding(.leading,10)
                    .background(Color(course.asset))
                
                HStack{
                    
                    VStack(alignment: .leading, spacing: 12) {
                        
                        Text(course.name)
                            .font(.title3)
                        
                        Text("(course.numCourse) Courses")
                    }
                    .foregroundColor(.black)
                    
                    Spacer(minLength: 0)
                }
                .padding()
            }
            .background(Color.white)
            .cornerRadius(15)
            
            // or you can use max height in flexible in Grid Item....
            
            Spacer(minLength: 0)
        }
    }
}

// TabViews...

struct CategoryPage : View {
    var dashViewModel : DashBoardViewModel
    let cateogryColumnCount  : [GridItem] = Array(repeating: .init(.flexible()), count: 2 )
    var body: some View{
        
        ScrollView(.vertical){
            
            
            LazyVGrid(columns: cateogryColumnCount){
                
                ForEach(dashViewModel.categoryList , id: \.id ){ cat in
                    
                    NavigationLink(destination: CateogoryDetailsUIView(item: cat.id ?? 10 ).navigationBarHidden(true)
                    ){
                        categoryCellBig(CategoryItem: cat)
                    }
                }
                
            }
            
            
        }.frame(minWidth: 0,  maxWidth: .infinity, minHeight: 0,  maxHeight: .infinity)
        .onAppear(){
            dashViewModel.isCateEmpty()
        }.padding(.bottom , 50)
    }
}

struct SearchPage : View {
    @StateObject  var viewModel : DashBoardViewModel
    @State private var searchText = ""
    @State private var showCancelButton: Bool = false
    @State private var searching : Bool  = false
    let columnsCount  : [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    var body: some View{
        
        ZStack{
            
            ScrollView{
                VStack{
                    
                    HStack {
                        HStack {
                            Image(systemName: "magnifyingglass")
                            
                            TextField("search", text: $searchText, onEditingChanged: { isEditing in
                                self.showCancelButton = true
                            }, onCommit: {
                                
                                self.searching = true
                                viewModel.loadProductSearch(q: searchText)
                                
                                
                                
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
                                self.searching = false
                            }
                            .foregroundColor(Color(.systemBlue))
                        }
                    }
                    .padding(.horizontal)
                    .animation(.default) // animation does not work properly
                    
                    //    let chunkData   = viewModel.searchProductList.chunked(into: 2)
                    
                    //                List{
                    //                    ForEach(0..<chunkData.count , id: \.self) { index in
                    //
                    //                        HStack{
                    //                            ForEach(chunkData[index] , id: \.id) {  product in
                    //
                    //                                NavigationLink(destination : ProductDetailsUIView(product: product)
                    //                                                .navigationBarHidden(true)
                    //                                ){
                    //                                SearchProductCell(isLast: false  , product: product).onAppear(){
                    //                                    self.searching = false
                    //                                }
                    //                                }
                    //                            }
                    //                        }
                    //                    }
                    //
                    //
                    //
                    //                }
                    //                .listRowBackground(Color.clear)
                    
                    LazyVGrid(columns: columnsCount){
                        ForEach( viewModel.searchProductList , id: \.id){ Product in
                            
                            NavigationLink(
                                destination: ProductDetailsUIView(product : Product)
                                    .navigationBarHidden(true)
                                
                            ){
                                ProductCells(isLast: false, product: Product).onAppear{
                                    
                                    self.searching = false
                                    
                                }
                            }
                            
                            
                        }
                    }
                    .frame(minHeight: 0 , maxHeight: .infinity)
                    
                }
            }.frame(minHeight: 0 , maxHeight: .infinity)
            
            
            HUDProgressView(placeholder: "Searching...", show: $searching )
            
            
        }.frame(minHeight: 0 , maxHeight: .infinity)
        
    }
}

struct Profile : View {
    let user : CustomerDetailsResponse? = loadUser()
    @State var  actions : Int? = 0
    @State var triggerSignPage : Int? = 10
    @State var transPage : Int? = 100
    @State var showAlert : Bool = false
    var body: some View{
        
        ScrollView{
            VStack{
                
                ZStack(alignment: .top){
                    
                    
                    Image("my_bg")
                        .resizable()
                        .frame(minWidth: 0 , maxWidth: .infinity
                               , maxHeight: 120)
                    
                    Image("userpp")
                        .resizable()
                        .frame(width: 80, height: 80, alignment: .top)
                        .clipShape(Circle()).padding(.top , 75)
                    
                    
                    
                    
                    
                    
                }
                
                NavigationLink(
                    destination: LoginUIView().navigationBarHidden(true),
                    tag: 11, selection: $triggerSignPage){
                    EmptyView()
                }
                
                
                NavigationLink(
                    destination: MainUIView().navigationBarHidden(true),
                    tag: 1, selection: $actions){
                    EmptyView()
                }
                
                
                Text(user?.email ?? "Click Here To login ")
                    .font(.custom("sf_pro", size: 17))
                    .bold()
                    .padding(.top , 5 )
                    .onTapGesture(){
                        if(!isUserLoggedin()){
                            self.triggerSignPage = 11
                        }
                    }  .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Please Login."),
                            message: Text("To Access This Information Please Login."),
                            primaryButton: .destructive(Text("Login")) {
                                self.triggerSignPage = 11
                            },
                            secondaryButton: .cancel()
                        )
                    }
                
                let phone  = (user?.billing.phone ?? "").replacingOccurrences(of: " ", with: "")
                Text(phone)
                    .font(.custom("sf_pro", size: 15))
                    .bold()
                    .padding(.top , 1 )
                   
                
                
                
                
                
                horizontralOptions().padding(.all , 10 )
                    .padding([.leading , .trailing] , 20)
                
                
                Color.gray.frame(height:CGFloat(3) / UIScreen.main.scale)
                    .padding([.leading , .trailing ] , 20)
                    .padding(.top , 10)
                
                NavigationLink(
                    destination: TransactionsUIView().navigationBarHidden(true) , tag : 1 , selection : $transPage ){
                    
                  EmptyView()
                    
                }
                
                HStack(alignment: .center){
                    
                    VStack(alignment: .leading , spacing : 10){
                        
                        
                        HStack{
                            
                            Image("icon_bag")
                                .resizable()
                                .renderingMode(.template)
                                .foregroundColor(Color(cyanColor))
                                .frame(width: 20, height: 20)
                            
                            
                            Text("Transactions")
                                .font(.system(size: 17))
                                .bold()
                                .padding(.leading , -2)
                                .foregroundColor(.black)
                            
                            
                        }
                        .padding(.top).onTapGesture {
                            
                            if(isUserLoggedin()){
                                self.transPage = 100
                            }else {
                                self.showAlert = true
                            }
                           
                        }
                        
                        
                        
                        NavigationLink(
                            destination: CouponListUiView().navigationBarHidden(true)){
                            HStack{
                                
                                Image(systemName: "cube")
                                    .font(.system(size: 20))
                                    .foregroundColor(Color(cyanColor))
                                
                                Text("Gift Cards")
                                    .font(.system(size: 17))
                                    .bold()
                                    .padding(.leading , -2)
                                    .foregroundColor(.black)
                                
                                
                            }
                            
                            
                        }
                        
                        
                        
                        NavigationLink(
                            destination: SettingsUIView().navigationBarHidden(true)){
                            HStack{
                                
                                Image(systemName: "gearshape")
                                    .font(.system(size: 20))
                                    .foregroundColor(Color(cyanColor))
                                
                                Text("Settings")
                                    .font(.system(size: 17))
                                    .bold()
                                    .padding(.leading , -2)
                                    .foregroundColor(.black)
                                
                                
                                
                                
                            }
                        }
                        
                        
                        if(isUserLoggedin()){
                            HStack{
                                
                                Image("icon_logout")
                                    .resizable()
                                    .renderingMode(.template)
                                    .foregroundColor(Color(cyanColor))
                                    
                                    .frame(width: 20, height: 20)
                                
                                
                                
                                Text("Logout")
                                    .font(.system(size: 17))
                                    .bold()
                                    .padding(.leading , 0)
                                    .foregroundColor(.black)
                                
                                
                            }.onTapGesture {
                                
                                let defaults = UserDefaults.standard
                                defaults.set("null", forKey: "user")
                                
                                
                                DispatchQueue.main.async {
                                    //self.isLoading = false
                                    self.actions = 1
                                }
                                
                            }
                        }else {
                            
                            
                            HStack{
                                
                                Image("icon_logout")
                                    .resizable()
                                    .renderingMode(.template)
                                    .foregroundColor(Color(cyanColor))
                                    .frame(width: 20, height: 20)
                                
                                
                                
                                Text("Log In")
                                    .font(.system(size: 17))
                                    .bold()
                                    .padding(.leading , 0)
                                    .foregroundColor(.black)
                                
                                
                            }.onTapGesture {
                                
                            
                                
                                
                                DispatchQueue.main.async {
                                    //self.isLoading = false
                                    self.triggerSignPage = 11
                                }
                                
                            
                        }
                        
                        
                    }
                    
                    }
                }
                
                
             
                
            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0,  maxHeight: .infinity, alignment: .top)
            
        }
        
        
    }
}

// Model Data...

struct Course : Identifiable {
    
    var id = UUID().uuidString
    var name : String
    var numCourse : Int
    var asset : String
}

// both image and color name is same so i used common word asset...

var courses = [
    
    Course(name: "Coding", numCourse: 12,asset: "placeholder"),
    Course(name: "Trading", numCourse: 12,asset: "placeholder"),
    Course(name: "Cooking", numCourse: 12,asset: "placeholder"),
    Course(name: "Marketing", numCourse: 12,asset: "placeholder"),
    Course(name: "UI/UX", numCourse: 12,asset: "placeholder"),
    Course(name: "Digital Marketing", numCourse: 12,asset: "placeholder")
]

struct DetailView : View {
    
    var course : Course
    
    var body: some View{
        
        VStack{
            
            Text(course.name)
                .font(.title2)
                .fontWeight(.bold)
        }
        .navigationTitle(course.name)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: Button(action: {}, label: {
            
            Image("placeholder")
                .renderingMode(.template)
                .foregroundColor(.gray)
        }))
    }
}


struct CurvedShape : View {
    
    var body : some View{
        
        Path{path in
            
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: UIScreen.main.bounds.width, y: 0))
            path.addLine(to: CGPoint(x: UIScreen.main.bounds.width, y: 55))
            
            path.addArc(center: CGPoint(x: UIScreen.main.bounds.width / 2, y: 55), radius: 33, startAngle: .zero, endAngle: .init(degrees: 180), clockwise: true)
            
            path.addLine(to: CGPoint(x: 0, y: 55))
            
        }.fill(Color(bottomColor))
        .rotationEffect(.init(degrees: 180))
    }
}

struct BottomBar : View {
    
    @Binding var selected : Int
    
    @ObservedObject var  VM : DashBoardViewModel
    
    var body : some View{
        
        HStack{
            
            Button(action: {
                
                self.selected = 0
                
            }) {
                
                Image(systemName: "house").font(.title2)
                
            }.foregroundColor(self.selected == 0 ? Color(cyanColor) : .gray)
            
            Spacer(minLength: 12)
            
            
            Button(action: {
                
                self.selected = 1
                
                VM.loadMore = false
                
            }) {
                
                Image(systemName: "archivebox").font(.title2)
                
                
            }.foregroundColor(self.selected == 1 ? Color(cyanColor) : .gray)
            
            
            Spacer().frame(width: 120)
            
            Button(action: {
                
                self.selected = 2
                VM.loadMore = false
            }) {
                
                Image(systemName: "magnifyingglass" ).font(.title2)
                
            }.foregroundColor(self.selected == 2 ? Color(cyanColor) : .gray)
            .offset(x: -30)
            
            
            Spacer(minLength: 12)
            
            Button(action: {
                VM.loadMore = false
                self.selected = 3
                
            }) {
                
                Image(systemName: "person").font(.title2)
                
            }.foregroundColor(self.selected == 3 ? Color(cyanColor) : .gray)
        }
    }
}


struct sliderView : View {
    
    private let timer  = Timer.publish(every: 3 , on: .main , in: .common).autoconnect()
    @State private var currentIndex = 0
    
    var body : some View {
        
        VStack{
            
            TabView (selection: $currentIndex){
                ForEach(0..<6) { num in
                    ImageViewerView(imageUrl: Paths.banner_path + String(num+1) + ".jpg")
                     //   //                            .placeholder{
                     //   //                                Image("placeholder")
                     //   //                                .resizable()
                        // //                                    .frame(maxHeight : 250)
                        // //                            }
                      //  .loadImmediately()
//                        .fade(duration: 0)
//                        .resizable()
                        
                        .tag(num)
                    
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .frame( maxHeight: 250)
            .onReceive(timer, perform: { _ in
                
                withAnimation{
                    currentIndex = currentIndex < 6 ? currentIndex + 1 : 1
                }
                
            })
            
        }.frame(maxWidth: .infinity , maxHeight: 250)
        
        
    }
    
}


struct  horizontralCateogry : View {
    
    @State private var action: Int? = 0
    @State private var cat_code: Int? = 398
    
    var body : some View {
        
        HStack{
            
            NavigationLink(destination:  CateogoryDetailsUIView(item: cat_code ?? 398).navigationBarHidden(true) , tag : 1 , selection: $action   ){
                
                EmptyView()
            }
            
            VStack{
                Button(action: {
                    
                    // selected = 0
                    
                    
                    
                    
                }) {
                    
                    
                    Image("ic_grocery")
                        .resizable()
                        .scaledToFill()
                        .frame( maxWidth: 30 ,maxHeight: 30 )
                        .padding(10)
                    
                    
                }.disabled(true).background(Color(cyanColor))
                .clipShape(Circle())
                .frame(maxWidth: .infinity)
                Text("Groceries\n ")
                    .font(Font.custom("lato", size: 14))
                    .padding(.top , -5 )
                
            }.onTapGesture{
                self.cat_code = 398
                self.action = 1
            }
            
            
            
            VStack{
                Button(action: {
                    
                    // selected = 0
                    
                    
                }) {
                    
                    
                    Image("electronics")
                        .resizable()
                        .scaledToFill()
                        .frame( maxWidth: 30 ,maxHeight: 30 )
                        .padding(10)
                    
                    
                }.disabled(true).background(Color(cyanColor))
                .clipShape(Circle())
                .frame(maxWidth: .infinity)
                Text("Electronic\n ").padding(.top , -5 )
                    .font(Font.custom("lato", size: 14))
            }.onTapGesture{
                self.cat_code = 440
                self.action = 1
            }
            
            VStack{
                Button(action: {
                    
                    // selected = 0
                    
                    
                }) {
                    
                    
                    Image("beauty")
                        .resizable()
                        .scaledToFill()
                        .frame( maxWidth: 30 ,maxHeight: 30 )
                        .padding(10)
                    
                    
                }.disabled(true).background(Color(cyanColor))
                .clipShape(Circle())
                .frame(maxWidth: .infinity)
                Text("Health\n&Beauty")
                    .padding(.top , -5 ) .font(Font.custom("lato", size: 14))
                
            }.onTapGesture{
                self.cat_code = 330
                self.action = 1
            }
            
            VStack{
                Button(action: {
                    
                    // selected = 0
                    
                    
                }) {
                    
                    
                    Image("male_clothes")
                        .resizable()
                        .scaledToFill()
                        .frame( maxWidth: 30 ,maxHeight: 30 )
                        .padding(10)
                    
                    
                }.disabled(true).background(Color(cyanColor))
                .clipShape(Circle())
                .frame(maxWidth: .infinity)
                
                Text("Men's\nFashion").padding(.top , -5 )
                    .font(Font.custom("lato", size: 14))
            }.onTapGesture{
                self.cat_code = 118
                self.action = 1
            }
            
            VStack{
                Button(action: {
                    
                    // selected = 0
                    
                    
                }) {
                    
                    
                    Image("woman_clothes")
                        .resizable()
                        .scaledToFill()
                        .frame( maxWidth: 30 ,maxHeight: 30 )
                        .padding(10)
                    
                }.disabled(true).background(Color(cyanColor))
                .clipShape(Circle())
                .frame(maxWidth: .infinity)
                Text("Women's\nFashion").padding(.top , -5 ) .font(Font.custom("lato", size: 14))
            }.onTapGesture{
                self.cat_code = 119
                self.action = 1
            }
            
            
        }
        
    }
    
}


struct  horizontralOptions  : View {
    
    @State private var action: Int? = 0
    @State private var cat_code: Int? = 398
    @State private var showingAlert : Bool = false
    
    var body : some View {
        
        HStack{
            
            NavigationLink(destination:  LoginUIView().navigationBarHidden(true) , tag : 1001 , selection: $action   ){
                
                EmptyView()
            }
            
            NavigationLink(destination:  OldOrderListUIView().navigationBarHidden(true) , tag : 101 , selection: $action   ){
                
                EmptyView()
            }
            
            NavigationLink(destination:  ProfileUIView().navigationBarHidden(true) , tag : 102 , selection: $action   ){
                
                EmptyView()
            }
            
            
            
            NavigationLink(destination:  RewardUIView().navigationBarHidden(true) , tag : 105 , selection: $action   ){
                
                EmptyView()
            }
            
            
            NavigationLink(
                destination: WalletUiIView().navigationBarHidden(true) , tag : 103 , selection: $action  ){
                
                EmptyView()
            }
            
            
            VStack{
                Button(action: {
                    
                    // selected = 0
                    
                    
                }) {
                    
                    
                    Image("user_icon")
                        .resizable()
                        .scaledToFill()
                        .frame( maxWidth: 30 ,maxHeight: 30 )
                        .padding(10)
                        .padding(.leading , 4)
                    
                    
                }.disabled(true).background(Color(cyanColor))
                .clipShape(Circle())
                .frame(maxWidth: .infinity)
                Text("Profile").padding(.top , -5 )
                    .font(Font.custom("lato", size: 14))
            }.onTapGesture{
                
                
             //   self.action = 102
                checkAndTrigger(code: 102)
                
            }
            .alert(isPresented:$showingAlert) {
                        Alert(
                            title: Text("Please Login."),
                            message: Text("To Access This Information Please Login."),
                            primaryButton: .destructive(Text("Login")) {
                                self.action = 1001
                            },
                            secondaryButton: .cancel()
                        )
                    }
            
            VStack{
                Button(action: {
                    
                    // selected = 0
                    
                    
                }) {
                    
                    
                    Image("checklist")
                        .resizable()
                        .scaledToFill()
                        .frame( maxWidth: 30 ,maxHeight: 30 )
                        .padding(10)
                    
                    
                }.disabled(true).background(Color(cyanColor))
                .clipShape(Circle())
                .frame(maxWidth: .infinity)
                Text("Orders").padding(.top , -5 ) .font(Font.custom("lato", size: 14))
                
            }.onTapGesture{
                
               // self.action = 101
                checkAndTrigger(code: 101)
            }
            
            VStack{
                Button(action: {
                    
                    // selected = 0
                    
                    
                }) {
                    
                    
                    Image("wallet_svg")
                        .resizable()
                        .scaledToFill()
                        .frame( maxWidth: 30 ,maxHeight: 30 )
                        .padding(10)
                    
                    
                }.disabled(true).background(Color(cyanColor))
                .clipShape(Circle())
                .frame(maxWidth: .infinity)
                
                Text("Wallet").padding(.top , -5 )
                    .font(Font.custom("lato", size: 14))
            }.onTapGesture{
                
              //  self.action = 103
                checkAndTrigger(code: 103)
            }
            
            VStack{
                Button(action: {
                    
                    // selected = 0
                    
                    
                }) {
                    
                    
                    Image("reward")
                        .resizable()
                        .scaledToFill()
                        .frame( maxWidth: 30 ,maxHeight: 30 )
                        .padding(10)
                    
                }.disabled(true).background(Color(cyanColor))
                .clipShape(Circle())
                .frame(maxWidth: .infinity)
                Text("Reward").padding(.top , -5 ) .font(Font.custom("lato", size: 14))
            }.onTapGesture{
                
                //self.action = 105
                checkAndTrigger(code: 105)
            }
            
            
        }
        
    }
    
    func checkAndTrigger(code : Int ) {
      
        if(isUserLoggedin()){
            self.action = code
        }else {
            self.showingAlert = true
        }
    }
    
}

struct  categoryCellSmall : View {
    var CategoryItem : CategoryModel
    
    var body: some View{
        
        VStack{
            
            let title = CategoryItem.name
            
            let parsed = title?.replacingOccurrences(of: "amp;", with: "")
            ImageViewerView(imageUrl: CategoryItem.image?.src ?? PLACEHOLDER_IMG_LINK)
               // .cancelOnDisappear(true)
//                .fade(duration: 0)
//                .resizable()
                .frame(maxHeight: .infinity)
                .cornerRadius(2)
            
            
            Text(parsed ??  "Cateogry Name")
                .lineLimit(2)
                .font(.custom("sf_pro", size: 14))
                .multilineTextAlignment(.center)
                .frame(maxHeight: 40 , alignment: .top)
                .padding(.top , -5)
                .foregroundColor(.black)
            
            
        }.frame(maxHeight: 120)
        .padding(.all , 2 )
        .padding(.top , -4)
        
    }
}

struct  categoryCellBig : View {
    var CategoryItem : CategoryModel
    
    var body: some View{
        
        VStack{
            
            let title = CategoryItem.name
            
            let parsed = title?.replacingOccurrences(of: "amp;", with: "")
            ImageViewerView(imageUrl: CategoryItem.image?.src ?? PLACEHOLDER_IMG_LINK)
               // .cancelOnDisappear(true)
                
               // .fade(duration: 0)
               // .resizable()
                .frame(maxHeight: .infinity)
            
            
            
            Text(parsed ??  "Cateogry Name")
                .lineLimit(2)
                .font(.custom("sf_pro", size: 17))
                .multilineTextAlignment(.center)
                .frame(maxHeight: 45 , alignment: .top)
                .padding(.top , -5)
                .foregroundColor(.black)
            
            
        }.frame(maxHeight: 220)
        .padding(.all , 2 )
        .padding(.top , -8)
        .cornerRadius(8)
        
    }
}

struct DashBoardUIView_Previews: PreviewProvider {
    static var previews: some View {
        DashBoardUIView()
        
    }
}
