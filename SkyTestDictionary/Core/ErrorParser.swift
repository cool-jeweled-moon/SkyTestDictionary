//
//  ErrorParser.swift
//  SkyTestDictionary
//
//  Created by Борис Анели on 20.09.2020.
//

import Foundation
import JeweledKit

class ErrorParser: JeweledErrorParser {
    func parse(from data: Data?) -> Error? {
        return nil
    }
    
    /*
     {
       "status" : 404,
       "title" : "An error occurred",
       "detail" : "Not Found",
       "type" : "https:\/\/tools.ietf.org\/html\/rfc2616#section-10"
     }
     */
}
