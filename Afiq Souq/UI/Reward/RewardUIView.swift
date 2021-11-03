//
//  RewardUIView.swift
//  Afiq Souq
//
//  Created by GAMEKILLER on 4/22/21.
//

import SwiftUI

struct RewardUIView: View {
    @Environment(\.presentationMode) var presentation
    var body: some View {
      
        VStack{
            HStack{
                
                Button(action: {
                    
                    
                    self.presentation.wrappedValue.dismiss()
                    
                    
                }) {
                    HStack {
                        
                        Image(systemName: "arrow.left")
                            .font(.title2)
                            .foregroundColor(Color(cyanColor))
                        
                    }
                    
                }
                
                Spacer()
                
                Text("My Rewards")
                    .font(Font.custom("sf_pro", size: 17))
                    .lineLimit(1)
                
                
                Spacer()
                
                
                
                
            }.padding([.leading , .trailing , .top] , 5)
            .frame(height: 40 , alignment: .center)
            .background(Color(.white))
            
            ZStack(alignment: .top){
                
                
                Image("my_bg")
                    .resizable()
                    .frame(minWidth: 0 , maxWidth: .infinity
                           , maxHeight: 120)
                ZStack(alignment: .bottom){
                    
                }.frame(width: 165, height: 165, alignment: .top)
                .padding(.top , 70)
                .background(Circle().foregroundColor(Color(lightCyan)))
                
                ZStack(alignment: .bottom){
                    
                }.frame(width: 167, height: 165, alignment: .top)
                .padding(.top , 75)
                .background(Circle().foregroundColor(Color(cyanColor)))
                
                ZStack(alignment: .bottom){
                    
                }.frame(width: 170, height: 165, alignment: .top)
                .padding(.top , 80)
                .background(Circle().foregroundColor(Color(lightCyan)))
                
                ZStack(alignment: .top){
                    
                    Circle()
                        .strokeBorder(Color(cyanColor) ,
                                      style: StrokeStyle(
                                        lineWidth: 2,
                                        dash: [3]
                                      ))
                        
                        .background(Circle().foregroundColor(Color.white))
                    
                    VStack(alignment: .center , spacing : 0){
                        
                        HStack(alignment: .center , spacing : 0 ){
                            Image("starbright")
                            Image("crown_bright")
                                .resizable()
                                .frame(width: 50, height: 50)
                            Image("starbright")
                        }.padding()
                        
                        Text("0")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(Color(cyanColor))
                            .padding(.top , -9)
                        
                        Text("Points Available")
                            .font(.custom("sf_pro", size: 17))
                            .bold()
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        
                        
                    }
                    
                    
                    
                }.frame(width: 165, height: 165, alignment: .top)
                .padding(.top , 30)
                
                
                
                
                
            }
            
            HStack{
                
                Text("Earn Points")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .font(Font.custom("sf_pro", size: 20))
                    .padding(12)
                    .background(Color(.white))
                    .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color(cyanColor), lineWidth: 2)
                        )
                    .foregroundColor(Color(cyanColor))
                
                
                Text("Earn Points")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .font(Font.custom("sf_pro", size: 20))
                    .padding(12)
                    .background(Color(cyanColor))
                    .cornerRadius(12)
                    .foregroundColor(.white)
                
                
            }.frame(minWidth: 0/*@END_MENU_TOKEN@*/,  maxWidth: /*@START_MENU_TOKEN@*/.infinity, alignment: .center)
            .padding(.top , -20)
            .padding([.leading , .trailing] , 10 )
            
            HStack{
                
                Text("10 Points For\n every & 100 Spend")
                    .font(.title2)
                    .bold()
                    .foregroundColor(Color(cyanColor))
                    .multilineTextAlignment(.center)
                    .padding()
                
                
            }.frame(minWidth: 0/*@END_MENU_TOKEN@*/,  maxWidth: /*@START_MENU_TOKEN@*/.infinity, alignment: .center)
           
            HStack(alignment: .center){
                
                Text("Recent Spendings")
                    .font(.title3)
                    .bold()
                    .foregroundColor(Color(.black))
                    .padding(.leading , 5)
                  
                 
                Spacer()
                
                Image(systemName: "chevron.down")
                    .font(.title2)
                    .foregroundColor(Color(cyanColor))
                    .padding(.trailing , 5)
                    
                
            }.frame(minWidth: 0/*@END_MENU_TOKEN@*/,  maxWidth: /*@START_MENU_TOKEN@*/.infinity, alignment: .leading)
            
            
        }.frame(minWidth: 0/*@END_MENU_TOKEN@*/,  maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity, alignment: .top)
        
    }
}

struct RewardUIView_Previews: PreviewProvider {
    static var previews: some View {
        RewardUIView()
    }
}
