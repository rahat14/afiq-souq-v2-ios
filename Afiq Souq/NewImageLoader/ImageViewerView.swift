//
//  ImageViewerView.swift
//  DSS
//
//  Created by Shakhawat Hossain Shahin on 25/9/21.
//  Copyright © 2021 Simec System LTD. All rights reserved.
//

import SwiftUI

struct ImageViewerView: View {
    @ObservedObject var vm: ImageViewModel
    
    init(imageUrl: String) {
        _vm = ObservedObject(wrappedValue: ImageViewModel(imageUrl: imageUrl))
    }
    
    var body: some View {
        ZStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                
            } else if vm.isLoading {
               // ActivityIndicatorView(isVisible: $vm.isLoading, type: .rotatingDots)
            } else {
                Image(systemName: "questionmark")
                    .foregroundColor(Color.gray)
            }
        }
    }
}

struct ImageViewerView_Previews: PreviewProvider {
    static var previews: some View {
        ImageViewerView(imageUrl: "")
    }
}
