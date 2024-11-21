//
//  NetworkManager.swift
//  VisaInterviewTest
//
//  Created by Asi Givati on 21/11/2024.
//

import UIKit
import Combine

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    private(set) lazy var defaultDecoder:JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    func publisher<T:Codable>(for keyPath:KeyPath<NetworkManager, EndpointsMapper<T>>, decoder:JSONDecoder? = nil) throws -> AnyPublisher<T, NetworkError> {
        let mapper = self[keyPath:keyPath]
        guard let url = URL(string: mapper.endpoint.rawValue) else {
            throw NetworkError.invalidUrl
        }
        
        let decoder = decoder ?? defaultDecoder
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .tryMap { (data, response) -> Data in
                if (response as? HTTPURLResponse)?.statusCode != 200 {
                    throw NetworkError.invalidResponse
                }
                return data
            }
            .decode(type: T.self, decoder: decoder)
            .mapError {
                guard let networkErr = $0 as? NetworkError else {
                    return NetworkError($0)
                }
                return networkErr
            }
            .eraseToAnyPublisher()
    }
    
    func downloadImagePublisher(from url:URL) -> AnyPublisher<UIImage, NetworkError> {
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .tryMap { (data, response) -> UIImage in
                guard (response as? HTTPURLResponse)?.statusCode == 200,
                    let image = UIImage(data: data) else {
                    throw NetworkError.invalidResponse
                }
                return image
            }
            .mapError {
                guard let networkErr = $0 as? NetworkError else {
                    return NetworkError($0)
                }
                return networkErr
            }
            .eraseToAnyPublisher()
    }
}

extension NetworkManager {
    var dishList:EndpointsMapper<[Dish]> { EndpointsMapper(endpoint: .dishes) }
}
