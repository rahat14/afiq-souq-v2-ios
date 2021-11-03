//
//  OrderDoneUIView.swift
//  Afiq Souq
//
//  Created by GAMEKILLER on 4/29/21.
//

import RealmSwift
import SwiftUI

struct OrderDoneUIView: View {
    @State  var isAction : Int? = 0
    @State var  id : Int
    
    
    
    
    var body: some View {
        VStack(){
            
            VStack(alignment: .trailing){
                
                NavigationLink(
                    destination: DashBoardUIView().navigationBarHidden(true)
                    , tag : 1 , selection : $isAction ){
                    
                    EmptyView()
                }
                
                
                HStack{
                    
                    
                    Button( action: {
                        
                        self.isAction = 1 
                        
                    }){
                        Image(systemName: "xmark").resizable()
                            .frame(width: 15, height: 15).padding(8)
                    }.background(Color.red)
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    
                    
                    
                }.frame( minWidth : 0 , maxWidth: .infinity , alignment: .trailing)
                
                
                
                
                Text("")
                    .padding(.vertical).onAppear(){
                        
                        deleteAllDataFrom()
                    }
                
                VStack{
                    
                    Image("check")
                        .resizable()
                        .frame(width: 100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center)
                    
                    Text("Thank You!")
                        .font(.title)
                        .bold()
                        .foregroundColor(Color(cyanColor))
                    
                    
                    Text("Your Order is Completed Succesfully.Please check the delivery state at Order Tracking")
                        .font(.custom("sf_pro", size: 16))
                        .multilineTextAlignment(.center)
                        .padding(12)
                    
                    Text("Order ID : " + String(id))
                        .bold()
                    
                    Text("Back To Shop")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .font(Font.custom("sf_pro", size: 18))
                        .padding(10)
                        .background(Color(cyanColor))
                        .cornerRadius(15)
                        .foregroundColor(.white)
                        .padding(12)
                        .onTapGesture(perform: {
                            
                            // this iis test push
                            self.isAction = 1
                        })
                    
                    
                    
                }
                
                
                
                
            }.frame(minWidth: 0,  maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/,  maxHeight: .infinity , alignment: .top )
            
            
            
            
        }.frame(minWidth: 0,  maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/,  maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center)
    }
    
    func deleteAllDataFrom() {
        
        do{
            let realm = try Realm()
            
            try! realm.write {
                            realm.deleteAll()
                            
                        }
            
            
        }
        
        catch let error {
          // Handle error
            print(error.localizedDescription)
            
        }
        
    }
}

struct OrderDoneUIView_Previews: PreviewProvider {
    static var previews: some View {
        OrderDoneUIView( id: 1221)
    }
}
