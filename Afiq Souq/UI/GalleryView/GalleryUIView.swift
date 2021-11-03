//
//  GalleryUIView.swift
//  Afiq Souq
//
//  Created by GAMEKILLER on 4/25/21.
//

import SwiftUI
//import Kingfisher


struct GalleryUIView: View {
    @Environment(\.presentationMode) var presentation
    
    var imageList : [String]
    
  
    @State private var isZoomed = false
    @State var scale: CGFloat = 1.0
    @State var isTapped: Bool = false
    @State var pointTapped: CGPoint = CGPoint.zero
    @State var draggedSize: CGSize = CGSize.zero
    @State var previousDragged: CGSize = CGSize.zero
    @State var imageLink: String
    
    
 
    
    var body: some View {
        ZStack(alignment: .topLeading ){
            
        
            VStack{
                
                 
                    GeometryReader {reader in
                        ImageViewerView(imageUrl: imageLink ?? "teest")
                          //  .resizable()
                            .scaledToFit()
                           
//                        KFImage(URL(string: imageLink ))
//                              .resizable()
//                              .scaledToFit()
                            .frame(minWidth: 0 , maxWidth: .infinity , minHeight: 0,  maxHeight: .infinity)
                              .animation(.default)
                              .offset(x: self.draggedSize.width, y: 0)
                              .scaleEffect(self.scale)
                              .scaleEffect(self.isTapped ? 2 : 1,
                               anchor: UnitPoint(
                                x: self.pointTapped.x / reader.frame(in: .global).maxX,
                                y: self.pointTapped.y / reader.frame(in: .global).maxY
                                ))
                               .gesture(TapGesture(count: 2)
                               .onEnded({
                              self.isTapped = !self.isTapped
                          })
                          .simultaneously(with: DragGesture(minimumDistance: 0, coordinateSpace: .global)
                          .onChanged({ (value) in
                              self.pointTapped = value.startLocation
                              self.draggedSize = CGSize(
                                   width: value.translation.width + self.previousDragged.width,
                                   height: value.translation.height + self.previousDragged.height)
                  //            print(value.startLocation)
                          }).onEnded({ (value) in
                  //            print(value.location)
                              let globalMaxX = reader.frame(in: .global).maxX
                              let offsetWidth = ((globalMaxX * self.scale) - globalMaxX) / 2
                              let newDraggedWidth = self.draggedSize.width * self.scale
                              if (newDraggedWidth > offsetWidth) {
                                  self.draggedSize = CGSize(
                                      width: offsetWidth / self.scale,
                                      height: value.translation.height + self.previousDragged.height
                                      )
                              } else if (newDraggedWidth < -offsetWidth) {
                                  self.draggedSize = CGSize(
                                      width: -offsetWidth / self.scale,
                                      height: value.translation.height + self.previousDragged.height
                                      )
                              } else {
                                  self.draggedSize = CGSize(
                                      width: value.translation.width + self.previousDragged.width,
                                      height: value.translation.height + self.previousDragged.height
                                      )
                              }
                              self.previousDragged = self.draggedSize
                              }))).gesture(MagnificationGesture()
                              .onChanged({ (scale) in
                              self.scale = scale.magnitude
                          }).onEnded({ (scaleFinal) in
                              self.scale = scaleFinal.magnitude
                          }))
                         
                    }
                    .frame(minWidth: 0 , maxWidth: .infinity , minHeight: 0,  maxHeight: .infinity)
                    
                    
                    
                
                
                ScrollView(.horizontal){
                    HStack(alignment: .center , spacing : 10 ){
                        
        //                KFImage(URL(string: ""))
        //                    .fade(duration: 0)
        //                    .resizable()
        //                    .cacheMemoryOnly()
        //                    .aspectRatio(contentMode: isZoomed ? .fill : .fit )
        //                    .ignoresSafeArea(.all)
        //                    .onTapGesture {
        //
        //                        withAnimation {
        //
        //                            isZoomed.toggle()
        //                        }
        //                    }
                        
                        ForEach( imageList , id: \.self ){
                            item in
                            
                            
                            ImageViewerView(imageUrl: item )
//                                .fade(duration: 0)
//                                .resizable()
                                .cornerRadius(8)
                                .frame(maxWidth: 80 ,
                                       maxHeight: 80)
                                .onTapGesture {
                                    
                                    imageLink = item
                                }
                                
                        }
                        
                    
                          
                        
                    }
                }.frame(minWidth: 0 , maxWidth: .infinity , alignment: .bottom)
                
                
                
            }.frame(minWidth: 0 , maxWidth: .infinity , minHeight: 0,  maxHeight: .infinity)
            
            
          
            
            Button(action: {
                
                
                self.presentation.wrappedValue.dismiss()
                
                
            }) {
                HStack {
                    
                    Image(systemName: "arrow.left")
                        .font(.title3)
                        .foregroundColor(Color(cyanColor))
                    
                }
                
            }.padding()
            
            
            
        }.frame(minWidth: 0 , maxWidth: .infinity , minHeight: 0,  maxHeight: .infinity, alignment: .topLeading)
    }
}

struct GalleryUIView_Previews: PreviewProvider {
    static var previews: some View {
        GalleryUIView(imageList: [],  imageLink: "String")
    }
}
