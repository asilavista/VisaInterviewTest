//
//  NetworkError.swift
//  VisaInterviewTest
//
//  Created by Asi Givati on 21/11/2024.
//

import Foundation

enum NetworkError:Error {
    case invalidUrl, invalidResponse
    case custom(Error)
    
    init(_ error:Error) {
        self = .custom(error)
    }
    
    var description:String {
        switch self {
        case .invalidUrl:
            return "Invalid Url"
        case .invalidResponse:
            return "Invalid Response"
        case .custom(let error):
            return error.localizedDescription
        }
    }
}
