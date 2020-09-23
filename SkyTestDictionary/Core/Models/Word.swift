//
//  Word.swift
//  SkyTestDictionary
//
//  Created by Борис Анели on 20.09.2020.
//

import Foundation

class Word: Codable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case text
        case shortMeanings = "meanings"
    }
    
    let id: Int
    let text: String
    let shortMeanings: [MeaningShort]
    var meanings: [Meaning]?
    
    init(id: Int,
         text: String,
         shortMeanings: [MeaningShort]) {
        self.id = id
        self.text = text
        self.shortMeanings = shortMeanings
    }
}

struct MeaningShort: Codable {
    let id: Int
    let translation: Translation
    let transcription: String
    let partOfSpeechCode: String
    let previewUrl: String
    let imageUrl: String
    let soundUrl: String
}

struct Translation: Codable {
    let text: String
    let note: String?
}
