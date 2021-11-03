//
//  ProductDetailsUIView.swift
//  Afiq Souq
//
//  Created by GAMEKILLER on 4/9/21.
//

import SwiftUI
//import Kingfisher
import HTMLAttributor



struct ProductDetailsUIView: View {
    
    @Environment(\.presentationMode) var presentation
    @StateObject var productDetailsVM : ProductDetailsViewModel
    var product : Product?
    @State var tirggerNextPage : Int? = 0
    @State var showingAlert : Bool = false
    @State var triggerCartPage : Int? = 0
    @State var isLoginShowAlert : Bool = false
  
    
    
    init( product : Product )
    {
        self.product = product
        
        //          _VM = StateObject(wrappedValue: RecoverOtPViewModel(id: USERID))
        _productDetailsVM = StateObject(wrappedValue: ProductDetailsViewModel(product: product))
        
    }
    @State private  var action : Int? = 0
    
    var body: some View {
        
        
        ZStack(alignment: .bottom){
            
           
            
            ScrollView{
                VStack(alignment: .center ){
                    
                    NavigationLink(destination: GalleryUIView(imageList: productDetailsVM.imageList, imageLink : productDetailsVM.imageLINK), tag : 1 ,
                                   selection : $tirggerNextPage )
                    {
                        EmptyView()
                    }
                    
                    
                    
                    
                    VStack(alignment: .center){
                        
                        
                        
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
                            
                            Text(product?.name ?? "Product Details")
                                .font(Font.custom("sf_pro", size: 17))
                                .lineLimit(1)
                            
                            
                            Spacer()
                            
                            NavigationLink(destination : CartPageUIView()
                                            .navigationBarHidden(true) ,
                                           tag : 1 ,
                                           selection : $triggerCartPage
                            ){
                                HStack {
                                    
                                   
                                    VStack(spacing: -4 ){
                                        
                                        HStack( spacing: 0){
                                            Text(productDetailsVM.CartCount)
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
              
                                
                                }.onTapGesture(perform: {
                                    self.triggerCartPage = 1
                                })
                            }
                            
                            
                            
                            
                        }.padding([.leading , .trailing , .top] , 5) .frame(height: 45)
                        
                        ZStack(alignment: .bottom){
                            
                            if(product?.images?.count ?? 0 > 0   ){
                                
                                let image : ProductImage = (product?.images![0])!
                                
                                
                                
                                ImageViewerView(imageUrl: image.src ?? "teest" )
//                                    .fade(duration: 0)
//                                    .resizable()
                                    .cornerRadius(14)
                                    .frame(maxWidth:.infinity ,
                                           maxHeight: 240)
                                    .padding(10)
                                    .onTapGesture {
                                        
                                        
                                        
                                        self.tirggerNextPage = 1
                                    }
                                
                                
                                
                                
//                                KFImage(URL(string: image.src ?? "teest" ))
//                                    .fade(duration: 0)
//                                    .resizable()
//                                    .placeholder{Image("placeholder")
//                                        .resizable()
//                                        .cornerRadius(14)
//                                        .frame(maxWidth:.infinity ,
//                                               maxHeight: 240)}
//                                    .loadImmediately()
//                                    .loadDiskFileSynchronously()
//                                    .cornerRadius(14)
//                                    .frame(maxWidth:.infinity ,
//                                           maxHeight: 240)
//                                    .padding(10)
//                                    .onTapGesture {
//
//
//
//                                        self.tirggerNextPage = 1
//                                    }
//
                                
                                
                            }else {
                                
                                Image("placeholder")
                                    .resizable()
                                    .cornerRadius(16)
                                    .frame(maxWidth:.infinity ,
                                           maxHeight: 240)
                                    .padding(10)
                                
                            }
                            
                            
                            
                            
                            
                            
                            HStack(alignment: .bottom){
                                
                                if(product?.images?.count ?? 0 > 0   ){
                                    
                                    let productImageArray : [ProductImage] = product?.images ?? []
                                    
                                    
                                    
                                    ForEach(productImageArray ,  id: \.id ){ productImage in
                                        
                                        
                                        
                                        ImageViewerView(imageUrl: productImage.src ?? PLACEHOLDER_IMG_LINK)
                                            
                                        //.loadDiskFileSynchronously()
//                                            .fade(duration: 0)
//                                            .resizable()
                                            .cornerRadius(8)
                                            .frame(maxWidth: 80 ,
                                                   maxHeight: 80)
                                            .onTapGesture{
                                                
                                                self.tirggerNextPage = 1
                                            }
                                        
//
//                                        KFImage(URL(string: productImage.src ?? PLACEHOLDER_IMG_LINK))
//                                            .loadImmediately()
//                                            .loadDiskFileSynchronously()
//                                            .fade(duration: 0)
//                                            .resizable()
//                                            .cornerRadius(8)
//                                            .frame(maxWidth: 80 ,
//                                                   maxHeight: 80)
//                                            .onTapGesture{
//
//                                                self.tirggerNextPage = 1
//                                            }
//
                                        
                                        
                                    }
                                    
                                    
                                }
                                else {
                                    
                                    Image("placeholder")
                                        .resizable()
                                        .cornerRadius(8)
                                        .frame(maxWidth: 80 ,
                                               maxHeight: 80)
                                }
                                
                                
                                
                                
                                
                            }
                            
                        }.frame(maxWidth: .infinity)
                        
                        
                        VStack(alignment: .center , spacing : 10 ){
                            
                            HStack{
                                Text(" Full Description : ")
                                    .font(Font.custom("sf_pro", size: 16))
                                    .fontWeight(.bold)
                                
                                Spacer()
                                
                            }
                            
                            
                            
                            let text = checkData(data: product?.shortDescription?.removeHTMLTag() ?? "")
                            
                            
                            
                      //  let hattr = HTMLAttributor()
                      //  let tree = try! hattr.parse(text)
                      //  let attributedText = try! hattr.attributedString(tree)
                            
                            Text(text)
                                .font(Font.custom("sf_pro", size: 15))
                                .multilineTextAlignment(.center)
                                .frame(minWidth : 0 , maxWidth: .infinity , minHeight: 30  ,alignment: .top)
                                .disabled(true)
                                
                            
                            HStack(alignment : .center , spacing : 10 ){
                                
                                Button(action: {
                                    
                                }) {
                                    HStack {
                                        
                                        Text("Additional Info")
                                            .fontWeight(.semibold)
                                            .font(Font.custom("lato", size: 14))
                                            .onTapGesture {
                                                self.showingAlert = true
                                            }
                                        
                                        
                                    }
                                    .padding(12)
                                    .foregroundColor(.white)
                                    .background(Color(cyanColor))
                                    .cornerRadius(8)
                                    
                                    
                                }
                                
                                
                                NavigationLink(destination: RewardListUIView(productID: (product?.id ?? 0 )).navigationBarHidden(true), tag : 1 , selection: $action){
                                    EmptyView()
                                }
                                
                                
                                Button(action: {
                                    // productDetailsVM.getCartItems()
                                    action = 1
                                    
                                }) {
                                    HStack {
                                        
                                        Text(" Reviews ")
                                            .fontWeight(.semibold)
                                            .font(Font.custom("lato", size: 14))
                                        
                                        
                                    }
                                    .padding(12)
                                    .foregroundColor(.white)
                                    .background(Color.gray)
                                    .cornerRadius(8)
                                    
                                }
                                
                            }
                            
                            HStack(spacing : 20){
                                
                                
                                HStack(spacing : 18){
                                    
                                    Button(action: {
                                        
                                        productDetailsVM.increment()
                                        
                                    }) {
                                        HStack {
                                            
                                            Image(systemName: "plus")
                                                .foregroundColor(.white)
                                            
                                            
                                        }
                                        
                                        
                                    }
                                    
                                    
                                    Text(String(productDetailsVM.qty)).foregroundColor(Color(.white))
                                        .font(Font.system(size: 14))
                                    
                                    
                                    Button(action: {
                                        
                                        productDetailsVM.decrement()
                                        
                                    }) {
                                        HStack {
                                            
                                            Image(systemName: "minus").foregroundColor(Color(.white))
                                                .font(Font.system(size: 14))
                                            
                                        }
                                        
                                        
                                    }
                                    
                                    
                                    
                                    
                                }
                                .padding(10)
                                .background(Color(cyanColor))
                                .cornerRadius(8)
                                
                                
                                Text(bdtSign + " "  + productDetailsVM.getProductPrice())
                                    .fontWeight(.semibold)
                                    .font(.title2)
                            }
                            
                            
                            
                            
                        }
                        
                        
                        Spacer()
                        
                        
                    }
                    .frame(maxHeight: .infinity)
                    .alert(isPresented: $productDetailsVM.showError) {
                        Alert(title: Text("Important message"), message: Text("You All ready Added This"), dismissButton: .default(Text("Try Again")))
                    }
                    
                    
                    NavigationLink(destination: CartPageUIView().navigationBarHidden(true)
                                   , tag : 1 , selection : $productDetailsVM.nextPage){
                        EmptyView()
                    }
                    
                    
                    
                    Spacer()
                    
                    
                }.frame(minWidth: 0, maxWidth: .infinity , minHeight: 0 , maxHeight: .infinity )
            }
            
            
            HStack{
                
                
                Button(action: {
                    productDetailsVM.CheckIfProductExists(id: String(product?.id ?? 0))
                    
                }) {
                    
                    HStack {
                        
                        Text("Add To Cart")
                            
                            .fontWeight(.semibold)
                            .font(Font.custom("lato", size: 16))
                            .frame(maxWidth: .infinity)
                        
                            
                        
                        
                    }
                    .padding(12)
                    .foregroundColor(.white)
                    .background(Color(cyanColor))
                    .cornerRadius(8)
                    
                }
                
                
                .frame(minWidth: 0, maxWidth: .infinity )
                
                
                Button(action: {
                    
                    productDetailsVM.addToCart(isBuyNow: true)
                    
                    
                }) {
                    HStack {
                        
                        Text("Buy Now")
                            .fontWeight(.semibold)
                            .font(Font.custom("lato", size: 16))
                            .frame(maxWidth: .infinity)
                    }
                    .padding(12)
                    .foregroundColor(.white)
                    .background(Color(lightGreen))
                    .cornerRadius(8)
                } .frame(minWidth: 0, maxWidth: .infinity)
                
                
            }.frame(minWidth: 0, maxWidth: .infinity , alignment: .bottom)
            .padding([.trailing , .leading] , 15 )
            .padding(.bottom , 4)
            .alert(isPresented: $showingAlert) {
                
                let reviewHtml  : String = checkData(data: product?.shortDescription  ?? "")
                let reviewStr : String = reviewHtml.removeHTMLTag()
                
                return Alert(title: Text("Product Description"), message: Text(reviewStr), dismissButton: .default(Text("Ok")))
                
            }
            
            
        }
        .frame(minWidth: 0, maxWidth: .infinity , minHeight: 0 , maxHeight: .infinity )
        
        
        
    }
//    struct HTMLStringView: UIViewRepresentable {
//        let htmlContent: String
//
//        func makeUIView(context: Context) -> WKWebView {
//            return WKWebView()
//        }
//
//        func updateUIView(_ uiView: WKWebView, context: Context) {
//            uiView.loadHTMLString(htmlContent, baseURL: nil)
//        }
//    }
//
    func checkData(data: String ) -> String {
        
        var text = data
        
        if text.isEmpty{
            text = getRandomReason()
        }
        
        return text
        
    }
    
    
}

//struct ProductDetailsUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProductDetailsUIView()
//    }
//}
