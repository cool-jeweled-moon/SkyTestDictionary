//
//  String+Capitalization.swift
//  SkyTestDictionary
//
//  Created by Борис Анели on 20.09.2020.
//

import Foundation

extension String {
    var capitalizedFirstLetter: String {
        return prefix(1).capitalized + dropFirst()
    }
}

extension String {
    var appendingNetworkProtocol: String {
        return "https:\(self)"
    }
}
