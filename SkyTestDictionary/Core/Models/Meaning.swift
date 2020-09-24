//
//  Meaning.swift
//  SkyTestDictionary
//
//  Created by Борис Анели on 19.09.2020.
//

import Foundation

struct Meaning: Codable {
    let id: String
    let wordId: Int
    let difficultyLevel: Int? //1 to 6
    let partOfSpeechCode: String
    let prefix: String?
    let text: String
    let soundUrl: String
    let transcription: String
    let updatedAt: String
    let mnemonics: String?
    let translation: Translation
    let images: [Image]
    let definition: Sound
    let examples: [Sound]
    let meaningsWithSimilarTranslation: [MeaningWithSimilarTranslation]
    let alternativeTranslations: [AlternativeTranslation]
    
    var partOfSpeech: PartOfSpeech? {
        return PartOfSpeech(rawValue: partOfSpeechCode)
    }
}

struct AlternativeTranslation: Codable {
    let text: String
    let translation: Translation
}

struct MeaningWithSimilarTranslation: Codable {
    let meaningId: Int
    let frequencyPercent: String
    let partOfSpeechAbbreviation: String
    let translation: Translation
}

struct Sound: Codable {
    let text: String
    let soundUrl: String
}

struct Image: Codable {
    let url: String
}
