//
//  Word.swift
//  SkyTestDictionary
//
//  Created by Борис Анели on 20.09.2020.
//

import Foundation

struct Word: Codable {
    let id: Int
    let text: String
    let meanings: [MeaningShort]
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
