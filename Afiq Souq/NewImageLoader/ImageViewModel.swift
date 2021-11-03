//
//  CoinImageViewModel.swift
//  DSS
//
//  Created by Shakhawat Hossain Shahin on 25/9/21.
//  Copyright © 2021 Simec System LTD. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class ImageViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = true
    
    private let imageurl: String
    private let dataService: ImageService
    private var cancellables = Set<AnyCancellable>()
    
    init(imageUrl: String) {
        self.imageurl = imageUrl
        self.dataService = ImageService(imageUrl: imageUrl)
        self.addSubscriber()
        self.isLoading = true
    }
    
    private func addSubscriber() {
        dataService.$image
            .sink { [weak self] (_) in
                self?.isLoading = false
            } receiveValue: { [weak self] (returnedImage) in
                self?.image = returnedImage
            }
            .store(in: &cancellables)

    }
}
