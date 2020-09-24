//
//  MeaningsRequest.swift
//  SkyTestDictionary
//
//  Created by Борис Анели on 20.09.2020.
//

import Foundation
import JeweledKit

class MeaningsRequest: BaseRequest, JeweledModelRequest {
    
    typealias Model = Meaning
    
    private let ids: [Int]
    
    init(ids: [Int]) {
        self.ids = ids
    }
    
    override var path: String {
        return "meanings"
    }
    
    override var parameters: [String : String?] {
        let idsString = ids.map { String($0) }.joined(separator: ",")
        
        return ["ids": idsString]
    }
}
