//
//  WordsSearchRequest.swift
//  SkyTestDictionary
//
//  Created by Борис Анели on 20.09.2020.
//

import Foundation
import JeweledKit

class WordsSearchRequest: BaseRequest, JeweledModelRequest {
    
    typealias Model = Word
    
    private let search: String
    private let page: Int
    private let pageSize: Int
    
    init(search: String,
         page: Int,
         pageSize: Int) {
        self.search = search
        self.page = page
        self.pageSize = pageSize
    }
    
    override var path: String {
        return "words/search"
    }
    
    override var parameters: [String : String?] {
        return ["search": search,
                "page": "\(page)",
                "pageSize": "\(pageSize)"]
    }
}
