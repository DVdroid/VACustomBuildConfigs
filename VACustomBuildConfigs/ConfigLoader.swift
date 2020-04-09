//
//  ConfigLoader.swift
//  VACustomBuildConfigs
//
//  Created by Vikash Anand on 09/04/20.
//  Copyright © 2020 Vikash Anand. All rights reserved.
//

import Foundation

class ConfigLoader {
    static let ConfigName = "Config.plist"

    static func parseFile(named fileName: String = ConfigName) -> Configuration {
        guard let filePath = Bundle.main.path(forResource: fileName, ofType: nil),
            let fileData = FileManager.default.contents(atPath: filePath)
        else {
            fatalError("Config file '\(fileName)' not loadable!")
        }

        do {
            let config = try PropertyListDecoder().decode(Configuration.self, from: fileData)
            return config
        } catch {
            fatalError("Configuration not decodable from '\(fileName)': \(error)")
        }
    }
}

struct Configuration: Decodable {
    let config: String
    let backendUrl: String
    let testFlags: TestFlags?
}

struct TestFlags: Decodable {
    let resetData: Bool
    let noSplash: Bool
    let applyTestData: Bool
}
