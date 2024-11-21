//
//  AsyncCacheImage.swift
//  VisaInterviewTest
//
//  Created by Asi Givati on 21/11/2024.
//

import SwiftUI
import Combine

struct AsyncCacheImage<Placeholder:View>:View {
    @StateObject private var imageCacheManager = ImageCacheManager()
    @State private var imageLoadingError:NetworkError?
    private let url:URL?
    private let placeholder:() -> Placeholder
    init(url:URL?, @ViewBuilder placeholder: @escaping () -> Placeholder) {
        self.url = url
        self.placeholder = placeholder
    }
    
    var body: some View {
        Group {
            if let error = imageCacheManager.error {
                Text(error.description)
                    .font(.title2)
                    .foregroundColor(.red)
            }
            else if let image = imageCacheManager.image {
                Image(uiImage: image)
                    .resizable()
            } else {
                placeholder()
            }
        }
        .alert(isPresented: Binding($imageLoadingError)) {
            return Alert(title: Text("Authentication Error"), message: imageLoadingError != nil ? Text(imageLoadingError!.description) : nil, dismissButton: .default(Text("Ok!")))
        }
        .task {
            imageCacheManager.loadImage(url: url)
        }
    }
}
