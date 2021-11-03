//
//  ImageService.swift
//  DSS
//
//  Created by Shakhawat Hossain Shahin on 25/9/21.
//  Copyright © 2021 Simec System LTD. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class ImageService {
    
    @Published var image: UIImage? = nil
    
    private var imageSubscription: AnyCancellable?
    private let imageUrl: String
    
    init(imageUrl: String) {
        self.imageUrl = imageUrl

        getCoinImage()
    }
    
    private func getCoinImage() {
        downloadCoinImage()
    }
    
    private func downloadCoinImage() {
        guard let url = URL(string: imageUrl) else { return }
        
        imageSubscription = NetworkingManager.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedImage) in
                guard let self = self, let downloadedImage = returnedImage else { return }
                self.image = downloadedImage
                self.imageSubscription?.cancel()
            })
    }
}
