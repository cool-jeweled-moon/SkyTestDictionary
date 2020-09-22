//
//  WordsSearchDataSource.swift
//  SkyTestDictionary
//
//  Created by Борис Анели on 20.09.2020.
//

import Foundation
import JeweledKit

private enum Constants {
    static let pageSize = 20
}

class WordsSearchDataSource: JeweledPaginationTableViewDataSource {
    
    typealias Cell = WordCell
    
    var configurationModels = [Cell.ConfigurationModel]()
    
    private let requestLoader = JeweledRequestLoader(errorParser: ErrorParser())
    
    private var isLoading = false
    private var isLoaded = false
    
    private var currentTask: URLSessionDataTask?
    private var currentSearchText: String?
    
    func loadData(searchText: String?, completion: @escaping (Error?) -> Void) {
        guard currentSearchText == searchText else {
            refresh(searchText: searchText, completion: completion)
            return
        }
        
        let page = configurationModels.count / Constants.pageSize + 1
        loadData(page: page, searchText: searchText, completion: completion)
    }
    
    func refresh(searchText: String?, completion: @escaping (Error?) -> Void) {
        currentSearchText = searchText
        currentTask?.cancel()
        isLoading = false
        isLoaded = false
        loadData(page: 1, searchText: searchText, completion: completion)
    }
    
    private func loadData(page: Int, searchText: String?, completion: @escaping (Error?) -> Void) {
        guard !isLoading, !isLoaded, let searchText = searchText else {
            completion(nil)
            return
        }
        
        isLoading = true
        
        let isFirstPage = page == 1
        let request = WordsSearchRequest(search: searchText,
                                         page: page,
                                         pageSize: Constants.pageSize)
        
        currentTask = requestLoader.loadModels(request) { [weak self] result in
            switch result {
            case .success(let models):
                
                self?.updateFlags(with: models.count)
                
                let confgiruationModels = models.map { $0.configurationModel }
                if isFirstPage {
                    self?.configurationModels = confgiruationModels
                } else {
                    self?.configurationModels.append(contentsOf: confgiruationModels)
                }
                
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    private func updateFlags(with modelsCount: Int) {
        isLoading = false
        isLoaded = modelsCount < Constants.pageSize
    }
}

private extension Word {
    var configurationModel: WordCell.ConfigurationModel {
        let meaning = meanings.first
        
        var transcription: String? = nil
        if let meaningTranscription = meaning?.transcription {
            transcription = "\\\(meaningTranscription)\\"
        }
        
        var previewUrl: URL? = nil
        if let previewUrlString = meaning?.previewUrl {
            previewUrl = URL(string: "https:\(previewUrlString)")
        }
        
        return WordCell.ConfigurationModel(word: text,
                                           transcription: transcription,
                                           translation: meaning?.translation.text,
                                           imageUrl: previewUrl)
    }
}
