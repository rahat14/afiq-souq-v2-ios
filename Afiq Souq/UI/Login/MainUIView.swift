//
//  MainUIView.swift
//  Afiq Souq
//
//  Created by GAMEKILLER on 5/26/21.
//

import SwiftUI

struct MainUIView: View {
    @AppStorage("currentPage") var currentPage = 1
    
    var body: some View {
        
        NavigationView{
        
        if(isFirstTimeOpening()){
           
            WalkThroughView()
            
        }else {
        
            DashBoardUIView()
            
        }
        
        
    }.navigationBarTitle("Login", displayMode: .inline)
    
    
    .navigationViewStyle(StackNavigationViewStyle())
        
        
    }
}

struct MainUIView_Previews: PreviewProvider {
    static var previews: some View {
        WalkThroughView()
    }
}

struct ScreenView : View {
        var image: String
        var title : String
        var detail : String
        var bgColor : Color
    @AppStorage("currentPage") var currentPage = 1

    var body: some View{
        
        VStack(spacing: 0){
        
            Image(image)
                .resizable()
                
                .frame(minWidth: 0,  maxWidth: .infinity/*@END_MENU_TOKEN@*/, minHeight: 0,  maxHeight: /*@START_MENU_TOKEN@*/.infinity, alignment: .top)
            
        }.frame(minWidth: 0,  maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 0,  maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .top)
        .ignoresSafeArea()
        

    }
}

struct WalkThroughView: View  {
@AppStorage("currentPage") var currentPage = 1
@State var  selection : Int? = 0

var body: some View{
    VStack(spacing: 0){
        
    
        
        NavigationLink(
            "", destination: DashBoardUIView(),
            tag: 1,
            selection: $selection
            
            )
        
        
        
        VStack(spacing: 0 ){
            
            if(currentPage == 1 ){
                ScreenView(image: "ff", title: "", detail: "", bgColor: Color.black)
                    .transition(.slide)
            }
            if(currentPage == 2 ){
                ScreenView(image: "dd", title: "", detail: "", bgColor: Color.black)
                    .transition(.slide)
            }
            if(currentPage == 3 ){
                ScreenView(image: "fff", title: "", detail: "", bgColor: Color.black)
                    .transition(.slide)
            }
            
        }.frame(minWidth: 0,  maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 0,  maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .top)
        
    
        
        HStack{
            
            if currentPage == 1 {
                
                Button(action: {
                   
                    selection = 1
                    
                }, label: {
                    
                    Text("Skip")
                        .foregroundColor(.black)
                        .fontWeight(.semibold)
                        .kerning(1.2)


                })
                
            }else {
                Button(action: {
                    withAnimation(.easeInOut){
                        if(currentPage > 1 ){
                            currentPage  -= 1
                        }
                    }
                }, label: {
                    
                    Text("Back")
                        .foregroundColor(.black)
                        .fontWeight(.semibold)
                        .kerning(1.2)


                })
                
            }
            
            Spacer()
            
            Button(action: {
                withAnimation(.easeInOut){
                    if(currentPage < 3 ){
                        currentPage += 1
                    }else {
                        selection = 1
                    }
                }
            }, label: {
                
                Text("Next")
                    .foregroundColor(.black)
                    .fontWeight(.semibold)
                    .kerning(1.2)
                

                
            })
            
        }.frame(maxWidth: .infinity   , alignment: .center)
        .padding(20)
        
        .background(Color.white)
        
        
    }.frame(minWidth: 0,  maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 0,  maxHeight: .infinity, alignment: .top).ignoresSafeArea()
    
}
}

