//
//  JsonLoaderViewModel.swift
//  VisaInterviewTest
//
//  Created by Asi Givati on 21/11/2024.
//

import Foundation
import Combine

class JsonLoaderViewModel<T:Codable>: ObservableObject {
    @Published var result:Result<T, NetworkError>?
    private var cancellables = Set<AnyCancellable>()
    
    init(_ keyPath:KeyPath<NetworkManager, EndpointsMapper<T>>) {
        reloadData(by:keyPath)
    }
    
    func reloadData(by keyPath:KeyPath<NetworkManager, EndpointsMapper<T>>) {
        do {
            let publisher = try NetworkManager.shared.publisher(for: keyPath)
            publisher.sink { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .finished: break
                case .failure(let error):
                    self.result = .failure(error)
                }
            } receiveValue: { [weak self] decodedData in
                self?.result = .success(decodedData)
            }
            .store(in: &cancellables)
            
        } catch {
            let err = (error as? NetworkError) ?? NetworkError(error)
            result = .failure(err)
        }
    }
}
