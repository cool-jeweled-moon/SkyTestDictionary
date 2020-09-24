//
//  BaseRequest.swift
//  SkyTestDictionary
//
//  Created by Борис Анели on 20.09.2020.
//

import Foundation
import JeweledKit

class BaseRequest: JeweledRequest {
    
    var type: JeweledRequestType {
        return .get
    }
    
    var timeoutInterval: TimeInterval {
        return .minute
    }
    
    var baseUrl: String {
        return "https://dictionary.skyeng.ru/api/public/v1/"
    }
    
    var path: String { return "" }
    
    var parameters: [String: String?] { return [:] }
    
    var headerFields: [String: String] {
        ["Content-Type": "application/json"]
    }
    
    var body: Data? { return nil }
    
    var payloadKey: String? { return nil }
}
