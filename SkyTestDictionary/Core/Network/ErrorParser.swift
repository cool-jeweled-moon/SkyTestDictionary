//
//  ErrorParser.swift
//  SkyTestDictionary
//
//  Created by Борис Анели on 20.09.2020.
//

import Foundation
import JeweledKit

struct SkyError: LocalizedError, Codable {
    let status: Int
    let title: String
    let detail: String
    let type: String
    
    var errorDescription: String? {
        return "\(title) \"\(detail)\""
    }
}

class ErrorParser: JeweledErrorParser {
    func parse(from data: Data?) -> Error? {
        guard let data = data else { return nil }
        
        do {
            let error = try JSONDecoder().decode(SkyError.self, from: data)
            return error
        } catch {
            return nil
        }
    }
}
