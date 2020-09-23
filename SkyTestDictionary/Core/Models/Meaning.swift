//
//  Meaning.swift
//  SkyTestDictionary
//
//  Created by Борис Анели on 19.09.2020.
//

import Foundation

enum PartOfSpeech: String {
    case noun = "n"
    case verb = "v"
    case adjective = "j"
    case adverb = "r"
    case preposition = "prp"
    case pronoun = "prn"
    case cardinalNumber = "crd"
    case conjunction = "cjc"
    case interjection = "exc"
    case article = "det"
    case abbreviation = "abb"
    case particle = "x"
    case ordinalNumber = "ord"
    case modalVerb = "md"
    case phrase = "ph"
    case idiom = "phi"
}

struct Meaning: Codable {
    let id: String
    let wordId: Int
    let difficultyLevel: Int?
    let partOfSpeechCode: String
    let prefix: String
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
