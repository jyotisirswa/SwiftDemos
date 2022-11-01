//
//  RequestError.swift
//  LevelShoeCaseStudy
//
//  Created by Jyoti on 16/10/2022.
//

import Foundation

enum RequestError: Error {
    case decode(String)
    case invalidURL
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case unknown
    
    var customMessage: String {
        switch self {
        case .decode(let message):
            return "\(message)"
        case .unauthorized:
            return "Session expired"
        default:
            return "Unknown error"
        }
    }
}
