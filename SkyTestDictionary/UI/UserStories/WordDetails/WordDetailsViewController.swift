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
    
    private let stackScrollView = JeweledStackScrollView.fromNib()
    private let titleView = WordTitleView.fromNib()
    private lazy var meaningsContainer = WordMeaningsViewController(meanings: word.shortMeanings)
    
    private let player = SimpleAudioPlayer()
    
    private let soundLoader = ServiceLocator.shared.soundLoader()
    
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
        
        view.backgroundColor = .white
        
        setupUI()
        configureUI()
    }
    
    private func configureUI() {
        navigationItem.largeTitleDisplayMode = .never
        titleView.configure(with: word.configurationModel)
        titleView.speakerButton.addTarget(self, action: #selector(speakerButtonDidTap), for: .touchUpInside)
    }
    
    private func setupUI() {
        view.addSubview(stackScrollView)
        stackScrollView.translatesAutoresizingMaskIntoConstraints = false
        stackScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        stackScrollView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        stackScrollView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        stackScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        stackScrollView.addView(titleView)
        stackScrollView.placeController(meaningsContainer)
    }
    
    @objc private func speakerButtonDidTap() {
        guard let soundUrl = word.shortMeanings.first?.soundUrl.appendingNetworkProtocol else { return }
        
        titleView.state = .soundLoading
        soundLoader.downloadSoundIfNeeded(withLink: soundUrl) { resourceUrl in
            DispatchQueue.main.asyncIfNeeded {
                self.titleView.state = resourceUrl == nil ? .soundLoadingFailed : .soundLoaded
                if let resourceUrl = resourceUrl {
                    self.player.play(url: resourceUrl)
                }
            }
        }
    }
}

private extension Word {
    var configurationModel: WordTitleView.ConfigurationModel {
        let meaning = shortMeanings.first
        
        var transcription: String? = nil
        if let meaningTranscription = meaning?.transcription {
            transcription = "\\\(meaningTranscription)\\"
        }
        
        return WordTitleView.ConfigurationModel(title: text.capitalizedFirstLetter,
                                                subtitle: transcription,
                                                state: meaning?.soundUrl == nil ? .soundLoadingFailed : .soundLoaded)
    }
}
