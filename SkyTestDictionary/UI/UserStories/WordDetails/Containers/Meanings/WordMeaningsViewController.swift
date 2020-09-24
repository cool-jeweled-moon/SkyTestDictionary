//
//  WordMeaningsViewController.swift
//  SkyTestDictionary
//
//  Created by Борис Анели on 23.09.2020.
//

import UIKit
import JeweledKit

class WordMeaningsViewController: UIViewController {
    
    private let tableContainer = JeweledSimpleTableViewController<TSDICell>()
    
    private let meanings: [MeaningShort]
    
    init(meanings: [MeaningShort]) {
        self.meanings = meanings
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if meanings.isEmpty {
            view.isHidden = true
        } else {
            setupTableContainer()
            tableContainer.dataSource = meanings.map { $0.confgiruationModel }
        }
    }
    
    private func setupTableContainer() {
        addChild(tableContainer)
        view.addSubview(tableContainer.view)
        tableContainer.didMove(toParent: self)
        tableContainer.view.translatesAutoresizingMaskIntoConstraints = false
        tableContainer.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableContainer.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableContainer.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableContainer.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}

private extension MeaningShort {
    var confgiruationModel: TSDICell.ConfigurationModel {
        return TSDICell.ConfigurationModel(title: translation.text,
                                           subtitle: partOfSpeech.title,
                                           description: nil,
                                           imageUrl: previewUrl.appendingNetworkProtocol)
    }
}
