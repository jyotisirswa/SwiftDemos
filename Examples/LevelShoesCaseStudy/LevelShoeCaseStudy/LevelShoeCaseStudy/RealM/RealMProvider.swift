//
//  RealMProvider.swift
//  LevelShoeCaseStudy
//
//  Created by Jyoti on 20/10/2022.
//

import Foundation

import Foundation
import RealmSwift

struct RealmProvider {
    
    let configuration: Realm.Configuration
    
    internal init(config: Realm.Configuration) {
        configuration = config
    }
    
    var realm: Realm? {
        return try? Realm(configuration: configuration)
    }
    
    private static let defaultConfig = Realm.Configuration()
    private static let mainConfig = Realm.Configuration(
        fileURL:  URL.inDocumentsFolder(fileName: "main.realm"),
        schemaVersion: 1)
    
    public static var `default`: RealmProvider = {
        return RealmProvider(config: RealmProvider.defaultConfig)
    }()
}

extension URL {
    // returns an absolute URL to the desired file in documents folder
    static func inDocumentsFolder(fileName: String) -> URL {
        return URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0], isDirectory: true)
            .appendingPathComponent(fileName)
    }
}
