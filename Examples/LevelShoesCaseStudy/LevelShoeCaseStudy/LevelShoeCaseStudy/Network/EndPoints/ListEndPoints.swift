//
//  ListEndPoints.swift
//  LevelShoeCaseStudy
//
//  Created by Jyoti on 16/10/2022.
//

import Foundation

enum ListEndpoint {
    case shoppingList
}

extension ListEndpoint: Endpoint {
    var path: String {
        switch self {
        case .shoppingList:
            return "/v3/5c138271-d8dd-4112-8fb4-3adb1b7f689e"
        }
    }
    var method: RequestMethod {
        switch self {
        case .shoppingList:
            return .get
        }
    }
    var header: [String: String]? {
        switch self {
        case .shoppingList:
            return [
                "Content-Type": "application/json;charset=utf-8"
            ]
        }
    }
    
    var body: [String: String]? {
        switch self {
        case .shoppingList:
            return nil
        }
    }
}
