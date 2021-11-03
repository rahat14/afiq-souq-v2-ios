//
//  views.swift
//  Afiq Souq
//
//  Created by GAMEKILLER on 4/5/21.
//

import Foundation
import SwiftUI

struct HUDProgressView : View {
    var placeholder : String
    @Binding var show : Bool
    @State var animate = false
    
    var body: some View{
        
        if(show){
            VStack(spacing: 20 ){
                
                Circle()
                    .stroke(AngularGradient(gradient: .init(colors:
                                                                [Color.primary , Color.primary.opacity(0)]), center: .center))
                                    .frame(width: 80, height: 80)
                    .rotationEffect(.init(degrees: animate ? 360 : 0 ))
                Text(placeholder)
                    .fontWeight(.bold)
                
                
            }.padding(.vertical , 25 )
            .padding(.horizontal , 35 )
            .background(BlurView())
            .cornerRadius(10)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
           // .background(Color.primary.opacity(0.35))
            .background(Color.primary.opacity(0.00))
            .onAppear(){
                withAnimation(Animation.linear(duration: 1.5).repeatForever(autoreverses: false)){
                    animate.toggle()
                }
            }
        }
       
    }
}

struct  BlurView : UIViewRepresentable {
    func makeUIView(context : Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemThinMaterial))
        return view
    }
    func updateUIView(_ uiView: UIVisualEffectView , context : Context)   {
        
    }
}


