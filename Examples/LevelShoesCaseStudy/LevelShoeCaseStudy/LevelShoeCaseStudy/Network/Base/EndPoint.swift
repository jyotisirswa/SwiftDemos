//
//  EndPoint.swift
//  LevelShoeCaseStudy
//  Created by Jyoti on 16/10/2022.
//

import Foundation

//MARK: - Endpoints declaration 
protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var body: [String: String]? { get }
}

extension Endpoint {
    var scheme: String {
        return "https"
    }

    var host: String {
        return "run.mocky.io"
    }
}
