//
//  RewardListUIView.swift
//  Afiq Souq
//
//  Created by GAMEKILLER on 4/24/21.
//

import SwiftUI

struct RewardListUIView: View {
   
    @Environment(\.presentationMode) var presentation
    @StateObject var viewModel :   ReviewListViewModel
    @State var rating = 3
    @State var id = 0
    
    init(productID : Int){
        _viewModel = StateObject(wrappedValue: ReviewListViewModel(id: productID))
            id = productID
    }
    
    var body: some View {
        ZStack{
            VStack{
                
            
                
                ScrollView{
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
                            
                            Text("Reviews")
                                .font(Font.custom("sf_pro", size: 20))
                                .lineLimit(1)
                            
                            
                            Spacer()
                            
                            
                            
                            
                        }
                        .padding([.leading , .trailing , .top] , 5)
                        .frame(height: 40 , alignment: .center)
                        .background(Color(.white))
                        
                        Color.gray.frame(height:CGFloat(4) / UIScreen.main.scale)
                        
                        HStack(alignment: .center , spacing : 10 ){
                            
                            Spacer()
                            
                            Text(String(viewModel.totalRating))
                                .font(.largeTitle)
                                .bold()
                            
                            Spacer()
                            
                            let r :  Int = Int(viewModel.totalRating)
                            
                           
                            
                            raingBar(rating: r)
                            
                            Spacer()
                        }
                        
                        Color.gray.frame(height:CGFloat(4) / UIScreen.main.scale)
                        
                        VStack{
                            
                            HStack(alignment: .center){
                                Text("5")
                                    .font(.title2)
                                Image(systemName: "star.fill")
                                    .foregroundColor(Color(cyanColor))
                                
                                Color.gray.frame(width : 230, height:(CGFloat(6) / UIScreen.main.scale) )
                                
                                
                                Text("0")
                                    .font(.title2)
                                
                            }
                            HStack(alignment: .center){
                                Text("4")
                                    .font(.title2)
                                Image(systemName: "star.fill")
                                    .foregroundColor(Color(cyanColor))
                                
                                Color.gray.frame(width : 230, height:(CGFloat(6) / UIScreen.main.scale) )
                                
                                
                                Text("0")
                                    .font(.title2)
                                
                            }
                            HStack(alignment: .center){
                                Text("3")
                                    .font(.title2)
                                Image(systemName: "star.fill")
                                    .foregroundColor(Color(cyanColor))
                                
                                Color.gray.frame(width : 230, height:(CGFloat(6) / UIScreen.main.scale) )
                                
                                
                                Text("0")
                                    .font(.title2)
                                
                            }
                            HStack(alignment: .center){
                                Text("2")
                                    .font(.title2)
                                Image(systemName: "star.fill")
                                    .foregroundColor(Color(cyanColor))
                                
                                Color.gray.frame(width : 230, height:(CGFloat(6) / UIScreen.main.scale) )
                                
                                
                                Text("0")
                                    .font(.title2)
                                
                            }
                            HStack(alignment: .center){
                                Text("1")
                                    .font(.title2)
                                Image(systemName: "star.fill")
                                    .foregroundColor(Color(cyanColor))
                                
                                Color.gray.frame(width : 230, height:(CGFloat(6) / UIScreen.main.scale) )
                                
                                
                                Text("0")
                                    .font(.title2)
                                
                            }
                            
                            
                            
                        }.padding()
                        
                        Color.gray.frame(height:CGFloat(4) / UIScreen.main.scale)
                        
                        ForEach(viewModel.list , id : \.id ){ item in
                            
                            ReviewItem(review: item)
                            
                        }
                        
                    }
                    .frame(minWidth: 0,  maxWidth: .infinity, minHeight: 0,  maxHeight: .infinity, alignment: .top)
                }
                .frame(minWidth: 0,  maxWidth: .infinity, minHeight: 0,  maxHeight: .infinity, alignment: .top)
                
                
                
                
                
                
                NavigationLink(destination: AddReviewUIView(productID:  viewModel.p_id).navigationBarHidden(true)){
                    Text("Add A Review")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .font(Font.custom("sf_pro", size: 20))
                        .padding(10)
                        .background(Color(cyanColor))
                        
                        .foregroundColor(.white)
                }
                    
                  
                
            }.frame(minWidth: 0,  maxWidth: .infinity, minHeight: 0,  maxHeight: .infinity, alignment: .top)
            
            if (viewModel.isLoading) {
                
                ProgressView().progressViewStyle(CircularProgressViewStyle(tint: Color(cyanColor)))
            }
            
        }.frame(minWidth: 0,  maxWidth: .infinity, minHeight: 0,  maxHeight: .infinity, alignment: .top)
    }
}
struct raingBar  :  View {
    
    @State var rating: Int
    var label = ""
    var maximumRating = 5
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    var offColor = Color.gray
    var onColor = Color(cyanColor)
    
    
    var body : some View {
        
        
        HStack {
            if label.isEmpty == false {
                Text(label)
            }
            
            ForEach(1..<maximumRating + 1) { number in
                self.image(for: number)
                    .foregroundColor(number > self.rating ? self.offColor : self.onColor)
                    .onTapGesture {
                        //self.rating = number
                    }
                    .font(.title)
            }
        }
        
    }
    
    func image(for number: Int) -> Image {
        if number > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
}
struct raingBarSmall  :  View {
    
    @State var rating: Int
    var label = ""
    var maximumRating = 5
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    var offColor = Color.gray
    var onColor = Color(cyanColor)
    
    
    var body : some View {
        
        
        HStack {
            if label.isEmpty == false {
                Text(label)
            }
            
            ForEach(1..<maximumRating + 1) { number in
                self.image(for: number)
                    .foregroundColor(number > self.rating ? self.offColor : self.onColor)
                    .onTapGesture {
                        self.rating = number
                    }
                    .font(.caption)
            }
        }
        
    }
    
    func image(for number: Int) -> Image {
        if number > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
}

struct ReviewItem : View {
    var review : ReviewModel
    @State  var  rate = 4
    var body : some View {
        HStack(spacing : 0){
            
            Image("placeholder")
                .resizable()
                .frame(width: 95, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .cornerRadius(12)
                .padding(4)
            
            VStack(alignment: .leading){
                Text(review.reviewer ?? "" )
                    .foregroundColor(.gray)
                    .font(.custom("sf_pro", size: 17))
                    
                    .frame(maxWidth : .infinity , alignment: .leading )
                
                
                
                
                HStack(alignment : .center , spacing : 2){
                    
                    let rati = review.rating ?? 0
                    
                    raingBarSmall(rating: rati).padding(.leading , 15)
                    
                    Text( "(" + String(rati)  + ")" )
                        .font(.title3)
                        .foregroundColor(.black)
                        
                        .padding(2)
                    
                    Spacer()
                    
                    
                    
                }
                .frame(minWidth: 0,  maxWidth: .infinity , alignment: .topLeading)
                
                
                let reviewHtml  : String = review.review ?? ""
                let reviewStr : String = reviewHtml.removeHTMLTag()
                
                Text((reviewStr))
                    .font(.caption)
                    .foregroundColor(.black)
                
                
                
            }.frame(minWidth: 0,  maxWidth: .infinity , minHeight: 100 , maxHeight: 100 , alignment: .topLeading)
            
            
        }
        .frame(minWidth: 0,  maxWidth: .infinity , minHeight:  120 , maxHeight: 120, alignment: .topLeading)
        .padding(3)
        
        
        
    }
}

struct RewardListUIView_Previews: PreviewProvider {
    static var previews: some View {
        RewardListUIView(productID: 5151)
        //ReviewItem()
    }
    
    
}
