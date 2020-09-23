//
//  WordsSearchViewController.swift
//  SkyTestDictionary
//
//  Created by Борис Анели on 20.09.2020.
//

import UIKit
import JeweledKit

private enum Constants {
    static let title = "Dictionary"
    static let searchBarPlaceholder = "Введите текст"
    static let estimatedRowHeight: CGFloat = 100.0
}

class WordsSearchViewController: UIViewController {
    
    private let searchBar = UISearchBar()
    private let tableContainer: JeweledPaginationTableViewController<WordsSearchDataSource> = {
        var configuration = JeweledPaginationTableViewConfiguration()
        configuration.emptyDataSourceMessage = nil
        
        return JeweledPaginationTableViewController(dataSource: WordsSearchDataSource(),
                                                    configuration: configuration)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        configureUI()
    }
    
    private func setupUI() {
        view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        searchBar.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        searchBar.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        
        addChild(tableContainer)
        view.addSubview(tableContainer.view)
        tableContainer.didMove(toParent: self)
        tableContainer.view.translatesAutoresizingMaskIntoConstraints = false
        tableContainer.view.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        tableContainer.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableContainer.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableContainer.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    private func configureUI() {
        searchBar.placeholder = Constants.searchBarPlaceholder
//        searchBar.searchTextField.returnKeyType = .done
        tableContainer.tableView.keyboardDismissMode = .onDrag
        
        title = Constants.title
        navigationController?.navigationBar.prefersLargeTitles = true
        searchBar.delegate = tableContainer
    }
}
