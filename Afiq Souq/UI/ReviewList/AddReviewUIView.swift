//
//  AddReviewUIView.swift
//  Afiq Souq
//
//  Created by GAMEKILLER on 4/24/21.
//

import SwiftUI

struct AddReviewUIView: View {
    @Environment(\.presentationMode) var presentation
    var productID : Int
    @State var rating = 0
    @State var review = " "
    @State var laoding : Bool = false
    @State var showError : Bool = false
    @State var showSuccess : Bool = false
    var body: some View {
        ScrollView{
            
            ZStack{
                VStack(alignment: .leading , spacing : 15 ){
                    
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
                        
                        Text("Add a Review")
                            .font(Font.custom("sf_pro", size: 17))
                            .lineLimit(1)
                        
                        
                        Spacer()
                        
                      
                            
                        
                    }
                    .padding([.leading , .trailing , .top] , 5)
                    .frame(height: 40 , alignment: .center)
                    .background(Color(.white))
                    
                    HStack{
                        
                        Text("Your Rating").font(.title2)
                        
                        raingBarHere(rating: $rating)
                        
                    }.alert(isPresented: $showError) {
                        Alert(title: Text("Error"), message: Text("Some Thing Went Wrong, Try Again!!"), dismissButton: .default(Text("OK")))
                    }
                    
                    Text("Your review").font(.title2)
                    
                    ZStack(alignment: .top){
                        
                        TextEditor(text : $review).font(.system(size: 20))
                            .padding(.top)
                        
                        HStack{
                            
                                Text("")
                                    
                                    .foregroundColor(.gray)
                                    .font(.system(size: 20))
                                
                                
                            
                            Spacer()
                        }
                        .padding(.top)
                        
                        
                        Text("eeeeee").opacity(0)
                            .padding(.all , 8 )
                    }.frame(minHeight: 100)
                    .cornerRadius(16)
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding([.leading , .trailing ] , 4)
                    .disableAutocorrection(true)
                    .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray))
                    .padding([.leading , .trailing ] , 1)
                    .padding(.bottom , 7)
                  
                    
                    Text("Submit")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .font(Font.custom("sf_pro", size: 20))
                        .padding(10)
                        .background(Color(cyanColor))
                        .cornerRadius(12)
                        .foregroundColor(.white)
                        .padding(12)
                        .onTapGesture(perform: {
                            
                            // upload the  review
                            let reviewStr  : String  = review
                            let ratingInt : Int = Int(rating)
                             let user = loadUser()

                            
                            if(ratingInt == 0 || reviewStr.isEmpty ){
                                
                               showError = true
                                
                                
                            }else {
                                laoding = true
                                let review = ReviewModel(id : 0  ,productID: productID, review: reviewStr , reviewer: user?.firstName ?? "user", reviewerEmail: (user?.email ?? ""), rating: ratingInt)
                                
                                NetworkManager.shared.CreateAReview(for: review ){
                                        result in
                                   
                                    switch(result){
                                    case .success( _):
                                        // save the data
                                        // self?.saveUser(user: userDeatils)
                                      
                                        DispatchQueue.main.async {
                                            laoding = false
                                            showSuccess = true
                                           
                                        }
                                        
                                    case .failure(let errror ):
                                        DispatchQueue.main.async {
                                            laoding = false
                                            showError = true
                                           
                                        }
                                        print(errror)
                                    }
                                    
                                }
                            }
                            
                            
                        }).alert(isPresented: $showSuccess) {
                            Alert(title: Text("Success"), message: Text("Review Was Posted"), dismissButton: .default(Text("Go Back")){
                                
                                self.presentation.wrappedValue.dismiss()
                                
                            })
                        }
                    
                    
                    
                }.frame(minWidth: 0,  maxWidth: .infinity, minHeight: 0,  maxHeight: .infinity, alignment: .top)
                .padding()
                
                HUDProgressView(placeholder: "Posting Review ", show: $laoding)
                
            }.frame(minWidth: 0,  maxWidth: .infinity, minHeight: 0,  maxHeight: .infinity, alignment: .top)
            
            
        }.frame(minWidth: 0,  maxWidth: .infinity, minHeight: 0,  maxHeight: .infinity, alignment: .top)
    }
   
}

struct raingBarHere  :  View {
    
    @Binding var rating: Int
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

struct AddReviewUIView_Previews: PreviewProvider {
    static var previews: some View {
        AddReviewUIView(productID: 5151)
    }
    
 
}
