//
//  ImageCacheManager.swift
//  VisaInterviewTest
//
//  Created by Asi Givati on 21/11/2024.
//

import SwiftUI
import Combine

class ImageCacheManager:ObservableObject {
    @Published var image:UIImage?
    @Published var error:NetworkError?
    private var cancellables = Set<AnyCancellable>()
    private static var cache = NSCache<NSString, UIImage>()

    func loadImage(url:URL?) {
        guard let url = url else {
            error = NetworkError.invalidUrl
            return
        }
        
        if let image = ImageCacheManager.cache[url.absoluteString] {
            self.image = image
            return
        }
        
        NetworkManager.shared.downloadImagePublisher(from: url)
            .sink { [weak self] completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    self?.error = error
                }
            } receiveValue: { [weak self] image in
                ImageCacheManager.cache[url.absoluteString, image]
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
            .store(in: &cancellables)
    }
}
