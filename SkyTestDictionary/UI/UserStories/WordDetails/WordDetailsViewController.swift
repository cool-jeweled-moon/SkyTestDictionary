//
//  WordDetailsViewController.swift
//  SkyTestDictionary
//
//  Created by Борис Анели on 23.09.2020.
//

import UIKit
import JeweledKit

class WordDetailsViewController: UIViewController {
    
    weak var coordinator: MainCoordinator?
    
    private let stackScrollView = JeweledStackScrollView()
    private lazy var meaningsContainer = WordMeaningsViewController(meanings: word.shortMeanings)
    
    private let requestLoader = JeweledRequestLoader(errorParser: ErrorParser())
    
    private let word: Word
    
    init(word: Word) {
        self.word = word
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(stackScrollView)
        stackScrollView.translatesAutoresizingMaskIntoConstraints = false
        stackScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        stackScrollView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        stackScrollView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        stackScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        stackScrollView.placeController(meaningsContainer)
        
        navigationItem.largeTitleDisplayMode = .never
        
        let request = MeaningsRequest(ids: word.shortMeanings.map { $0.id })
        requestLoader.loadModels(request) { result in
            switch result {
            case .success(let meanings):
                self.word.meanings = meanings
            case .failure(let error):
                print(error)
            }
        }
    }
}
