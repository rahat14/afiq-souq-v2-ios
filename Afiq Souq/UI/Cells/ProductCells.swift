//
//  ProductCells.swift
//  Afiq Souq
//
//  Created by GAMEKILLER on 4/17/21.
//

import SwiftUI
//import Kingfisher

struct ProductCellsCollection: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}


struct SearchProductCell : View {
    var isLast :  Bool
    var   product : Product

    var body: some View{
        
        VStack(alignment: .leading){
            
            if(!(product.images?.isEmpty ?? true)){
                let image : ProductImage = product.images![0]
                
                
                ImageViewerView(imageUrl: image.src ?? "teest")
//                    .resizable()
//                    .fade(duration: 0)
                    .frame(height: 155)
                
//                KFImage(URL(string: image.src ?? "teest"))
//
//                    .fade(duration: 0)
//                    .resizable()
//                    .cacheMemoryOnly()
//                    .frame(height: 155)
                
            }else {
                
                ImageViewerView(imageUrl: "https://lh3.googleusercontent.com/proxy/Mxb6JpWy3goRMMypWtn1E_d10yLSgMLwzMDVRNknxeeuSQt9JQFeP15x2OOMLpEo8Rwz1oBVlmNt04obv-SX9SYN7GIabpFFMh4NV28FVqcRzbvb3mQaqYzWp-wX5VTVZ_85NQ")
//                    .resizable()
//                    .fade(duration: 0)
                    .frame(height: 155)
                
                
                
                
//                KFImage(URL(string: "https://lh3.googleusercontent.com/proxy/Mxb6JpWy3goRMMypWtn1E_d10yLSgMLwzMDVRNknxeeuSQt9JQFeP15x2OOMLpEo8Rwz1oBVlmNt04obv-SX9SYN7GIabpFFMh4NV28FVqcRzbvb3mQaqYzWp-wX5VTVZ_85NQ"))
//
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
                        .onAppear{
                            
                            // telll viewmodel to load more
                            // load more here
                          
                            
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


struct drawerView : View {
    
    @Binding var shown : Bool
    let user : CustomerDetailsResponse? = loadUser()
    @Environment(\.openURL) var openURL
            
    var body : some View {
        
        ZStack(alignment: .top){
        
       
            
            VStack{
                Image("image_back")
                    .resizable()
                    .frame(minWidth: 0 ,  maxWidth: .infinity, minHeight: 0 , maxHeight: 250 ,  alignment: .top)
                
                
        
                
                HStack(alignment : .center){
                    
                    VStack(alignment: .leading , spacing : 7 ){
                        
                        HStack{
                            
                            Image("home")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(Color(cyanColor))
                            
                            Text("Home")
                                .font(.system(size: 17))
                                .bold()
                                .padding(.leading , -2)
                                .foregroundColor(.black)
                            
                            
                        }.onTapGesture {
                            
                            self.shown.toggle()
                        }
                        
                        NavigationLink(destination: CategoryListUIView().navigationBarHidden(true)){
                            
                            HStack{
                                
                                Image("categories")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(Color(cyanColor))
                                
                                Text("Categories")
                                    .font(.system(size: 17))
                                    .bold()
                                    .padding(.leading , -2)
                                    .foregroundColor(.black)
                                
                                
                            }
                            
                        }
                        
                        NavigationLink(destination:  ProductListUIView(cateCode: topDeals).navigationBarHidden(true)){
                            
                            HStack{
                                
                                Image("top_deals")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(Color(cyanColor))
                                
                                Text("Top Deals")
                                    .font(.system(size: 17))
                                    .bold()
                                    .padding(.leading , -2)
                                    .foregroundColor(.black)
                                
                                
                            }
                        }
                        
                      
                        NavigationLink(destination:  ProductListUIView(cateCode: new_arrivals).navigationBarHidden(true)){
                        HStack{
                            
                            Image("icon_crown")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(Color(cyanColor))
                            
                            Text("New Arrivals")
                                .font(.system(size: 17))
                                .bold()
                                .padding(.leading , -2)
                                .foregroundColor(.black)
                            
                            
                        }
                        }
                        
                        
                        
                        
                        HStack{
                            
                            Image("icon_questions")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(Color(cyanColor))
                            
                            Text("Chat With Us")
                                .font(.system(size: 17))
                                .bold()
                                .padding(.leading , -2)
                                .foregroundColor(.black)
                            
                            
                        }.onTapGesture {
                            openURL(URL(string: "https://www.afiqsouq.com/chat-page")!)
                        }
                        
                        
                    }
                }.padding(5)
                
                
            }
              
            
              VStack{
                  
                ZStack{
                    Image("userpp")
                        .resizable()
                        .frame(width: 83, height: 80, alignment: .top)
                     
                      .clipShape(Circle())
                      
                      .padding(.top , 40)
                  
                    Circle().strokeBorder(Color(cyanColor), lineWidth: 3).frame(width: 80, height: 80, alignment: .top).padding(.top , 40)
                  
                }
                   
                
                Text(user?.username ?? "")
                    .foregroundColor(Color(cyanColor))
                    .bold()
                    .padding(.top , 5 )
                
                let phone  = (user?.billing.phone ?? "").replacingOccurrences(of: " ", with: "")
               
                
                Text(phone)
                    .foregroundColor(Color(.white))
                    .padding(.top , 1 )
                  
                  
              }
              
            
                
            HStack{
                Spacer()
                Button( action: {
                    
                    self.shown.toggle()
                    
                }){
                    Image(systemName: "xmark").resizable()
                        .frame(width: 15, height: 15).padding(8)
                }.background(Color.red)
                .foregroundColor(.white)
                .clipShape(Circle())
                
            }.padding(1)
          
           
            // custom views
            
            
            
        }.frame(width: 300, height: 450 , alignment: .top)
        .background(Color(.white))
        .cornerRadius(20)
        
    }
}

struct ProductCells_Previews: PreviewProvider {
    static var previews: some View {
        
       
        ProductCellsCollection()
    }
}


struct TextWithAttributedString: View {

var attributedText: NSAttributedString
@State private var height: CGFloat = .zero

var body: some View {
    InternalTextView(attributedText: attributedText, dynamicHeight: $height)
        .frame(minHeight: height)
}

struct InternalTextView: UIViewRepresentable {

    var attributedText: NSAttributedString
    @Binding var dynamicHeight: CGFloat

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.textAlignment = .justified
        textView.isScrollEnabled = false
        textView.isUserInteractionEnabled = false
        textView.showsVerticalScrollIndicator = false
        textView.showsHorizontalScrollIndicator = false
        textView.allowsEditingTextAttributes = false
        textView.backgroundColor = .clear
        textView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        textView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.attributedText = attributedText
        DispatchQueue.main.async {
            dynamicHeight = uiView.sizeThatFits(CGSize(width: uiView.bounds.width, height: CGFloat.greatestFiniteMagnitude)).height
        }
    }
}
    
}
