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
    static let exampleText = "Например: Dog"
    static let notFoundText = "Ничего не найдено"
}

class WordsSearchDataSource: JeweledPaginationTableViewDataSource {
    
    typealias Cell = TSDICell
    typealias LoaderCell = JeweledLockLoaderTableViewCell
    typealias Model = Word
    
    var cellModels = [CellType]()
    var models = [Word]()
    
    private let requestLoader = ServiceLocator.shared.requestLoader()
    
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
            cellModels = [CellType.loader(model: LoaderCell.ConfigurationModel(message: Constants.exampleText,
                                                                               isMessage: true))]
            updateUI(nil)
            return
        }
        
        if cellModels.count < Constants.pageSize {
            cellModels = [CellType.loader(model: LoaderCell.ConfigurationModel())]
            updateUI(nil)
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
    
    private func handleResult(_ result: Result<[Word], Error>,
                              isFirstPage: Bool,
                              updateUI: @escaping (Error?) -> Void) {
        switch result {
        case .success(let models):
            updateFlags(with: models.count)
            
            var cellModels = models.map { CellType.cell(model: $0.configurationModel) }
            if !isLoaded {
                cellModels.append(CellType.loader(model: LoaderCell.ConfigurationModel()))
            } else if models.isEmpty {
                cellModels.append(CellType.loader(model: LoaderCell.ConfigurationModel(message: Constants.notFoundText,
                                                                                       isMessage: true)))
            }
            
            if isFirstPage {
                self.cellModels = cellModels
                self.models = models
            } else {
                self.cellModels = self.cellModels.filter({
                    if case .loader = $0 {
                        return false
                    }
                    
                    return true
                })
                
                self.cellModels.append(contentsOf: cellModels)
                self.models.append(contentsOf: models)
            }
            
            updateUI(nil)
        case .failure(let error):
            if cellModels.count < Constants.pageSize {
                cellModels = [CellType.loader(model: LoaderCell.ConfigurationModel(message: error.localizedDescription,
                                                                                   isMessage: true))]
                updateUI(nil)
            } else {
                updateUI(error)
            }
        }
    }
    
    private func updateFlags(with modelsCount: Int) {
        isLoading = false
        isLoaded = modelsCount < Constants.pageSize
    }
}

private extension Word {
    var configurationModel: TSDICell.ConfigurationModel {
        let meaning = shortMeanings.first
        
        var transcription: String? = nil
        if let meaningTranscription = meaning?.transcription {
            transcription = "\\\(meaningTranscription)\\"
        }
        
        var previewUrl: String? = nil
        if let previewUrlString = meaning?.previewUrl {
            previewUrl = previewUrlString
        }
        
        return TSDICell.ConfigurationModel(title: text.capitalizedFirstLetter,
                                           subtitle: transcription,
                                           description: meaning?.translation.text.capitalizedFirstLetter,
                                           imageUrl: previewUrl?.appendingNetworkProtocol)
    }
}
