//
//  JsonLoaderView.swift
//  VisaInterviewTest
//
//  Created by Asi Givati on 21/11/2024.
//

import SwiftUI

struct JsonLoaderView<T:Codable, Content:View>: View {
    
    @StateObject private var vm:JsonLoaderViewModel<T>
    private let content:(T) -> Content
    
    init(_ keyPath:KeyPath<NetworkManager, EndpointsMapper<T>>, @ViewBuilder content:@escaping (T) -> Content) {
        _vm = StateObject(wrappedValue: JsonLoaderViewModel(keyPath))
        self.content = content
    }
    
    var body: some View {
        Group {
            if let result = vm.result {
                switch result {
                case .success(let decodedObject):
                    content(decodedObject)
                case .failure(let error):
                    Text(error.description)
                        .foregroundColor(.red)
                }
            } else {
                Text("Loading...")
            }
        }
        .environmentObject(vm)
    }
}
