//
//  WordCell.swift
//  SkyTestDictionary
//
//  Created by Борис Анели on 19.09.2020.
//

import UIKit
import Kingfisher
import JeweledKit

private enum Constants {
    static let cornerRadius: CGFloat = 8.0
}

class WordCell: UITableViewCell, JeweledConfigurableView {
    
    struct ConfigurationModel {
        let word: String
        let transcription: String?
        let translation: String?
        let imageUrl: String?
    }
    
    @IBOutlet weak var wordImageView: UIImageView!
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var transcriptionLabel: UILabel!
    @IBOutlet weak var translationLabel: UILabel!
    
    var imageTask: DownloadTask?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        wordImageView.layer.cornerRadius = Constants.cornerRadius
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageTask?.cancel()
        wordImageView.image = nil
    }
    
    func configure(with model: ConfigurationModel) {
        wordLabel.text = model.word.capitalizedFirstLetter
        transcriptionLabel.text = model.transcription
        translationLabel.text = model.translation?.capitalizedFirstLetter
        wordImageView.setImage(model.imageUrl)
        wordImageView.isHidden = model.imageUrl == nil
    }
}
