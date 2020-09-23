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
    
    var cellModels = [CellType]()
    
    private let requestLoader = JeweledRequestLoader(errorParser: ErrorParser())
    
    private var isLoading = false
    private var isLoaded = false
    
    private var currentTask: URLSessionDataTask?
    private var currentSearchText: String?
    
    func loadData(searchText: String?, updateUI: @escaping (Error?) -> Void) {
        guard currentSearchText == searchText else {
            refresh(searchText: searchText, updateUI: updateUI)
            return
        }
        
        let page = cellModels.count / Constants.pageSize + 1
        loadData(page: page, searchText: searchText, updateUI: updateUI)
    }
    
    func refresh(searchText: String?, updateUI: @escaping (Error?) -> Void) {
        currentSearchText = searchText
        currentTask?.cancel()
        isLoading = false
        isLoaded = false
        loadData(page: 1, searchText: searchText, updateUI: updateUI)
    }
    
    private func loadData(page: Int, searchText: String?, updateUI: @escaping (Error?) -> Void) {
        guard !isLoading, !isLoaded else { return }
        guard let searchText = searchText, !searchText.isEmpty else {
            cellModels = [CellType.loader(model: LoaderCell.ConfigurationModel(message: "Example: Dog",
                                                                               isMessage: true))]
            updateUI(nil)
            return
        }
        
        isLoading = true
        
        let isFirstPage = page == 1
        let request = WordsSearchRequest(search: searchText,
                                         page: page,
                                         pageSize: Constants.pageSize)
        
        currentTask = requestLoader.loadModels(request) { [weak self] result in
            self?.handleResult(result, isFirstPage: isFirstPage, updateUI: updateUI)
        }
    }
    
    private func handleResult(_ result: Result<[Word], Error>, isFirstPage: Bool, updateUI: @escaping (Error?) -> Void) {
        switch result {
        case .success(let models):
            updateFlags(with: models.count)
            
            var cellModels = models.map { CellType.cell(model: $0.configurationModel) }
            if !isLoaded {
                cellModels.append(CellType.loader(model: LoaderCell.ConfigurationModel()))
            }
            
            if isFirstPage {
                self.cellModels = cellModels
            } else {
                self.cellModels = self.cellModels.filter({
                    if case .loader = $0 {
                        return false
                    }
                    
                    return true
                })
                
                self.cellModels.append(contentsOf: cellModels)
            }
            
            updateUI(nil)
        case .failure(let error):
            updateUI(error)
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
        
        var previewUrl: String? = nil
        if let previewUrlString = meaning?.previewUrl {
            previewUrl = "https:\(previewUrlString)"
        }
        
        return WordCell.ConfigurationModel(word: text,
                                           transcription: transcription,
                                           translation: meaning?.translation.text,
                                           imageUrl: previewUrl)
    }
}
