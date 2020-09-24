//
//  WordTitleView.swift
//  SkyTestDictionary
//
//  Created by Борис Анели on 23.09.2020.
//

import UIKit
import JeweledKit

class WordTitleView: UIView, JeweledConfigurableView {
    
    enum State {
        case soundLoading
        case soundLoaded
        case soundLoadingFailed
    }
    
    struct ConfigurationModel {
        let title: String
        let subtitle: String?
        let state: State
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var speakerButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var state: State {
        get {
            if speakerButton.isEnabled {
                return activityIndicator.isAnimating ? .soundLoading : .soundLoadingFailed
            } else {
                return .soundLoaded
            }
        }
        
        set {
            switch newValue {
            case .soundLoaded:
                activityIndicator.isHidden = true
                activityIndicator.stopAnimating()
                speakerButton.isEnabled = true
            case .soundLoading:
                activityIndicator.isHidden = false
                activityIndicator.startAnimating()
                speakerButton.isEnabled = false
            case .soundLoadingFailed:
                activityIndicator.isHidden = true
                activityIndicator.stopAnimating()
                speakerButton.isEnabled = false
            }
        }
    }
    
    func configure(with model: ConfigurationModel) {
        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle
        state = model.state
    }
}
