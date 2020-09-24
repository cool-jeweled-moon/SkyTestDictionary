//
//  PartOfSpeech.swift
//  SkyTestDictionary
//
//  Created by Борис Анели on 24.09.2020.
//

import Foundation

enum PartOfSpeech: String, Codable {
    
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
    
    var title: String {
        switch self {
        case .noun: return "Существительное"
        case .verb: return "Глагол"
        case .adjective: return "Прилагательное"
        case .adverb: return "Наречие"
        case .preposition: return "Предлог"
        case .pronoun: return "Местоимение"
        case .cardinalNumber: return "Количественное числительное"
        case .conjunction: return "Союз"
        case .interjection: return "Междометие"
        case .article: return "Артикль"
        case .abbreviation: return "Аббревиатура"
        case .particle: return "Частица"
        case .ordinalNumber: return "Порядковый номер"
        case .modalVerb: return "Модальный глагол"
        case .phrase: return "Выражение"
        case .idiom: return "Идиома"
        }
    }
}
