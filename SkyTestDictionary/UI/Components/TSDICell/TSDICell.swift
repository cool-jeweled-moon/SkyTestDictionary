//
//  TSDICell.swift
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

class TSDICell: UITableViewCell, JeweledConfigurableView {
    
    struct ConfigurationModel {
        let title: String
        let subtitle: String?
        let description: String?
        let imageUrl: String?
    }
    
    @IBOutlet weak var largeImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        largeImageView.layer.cornerRadius = Constants.cornerRadius
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        largeImageView.image = nil
    }
    
    func configure(with model: ConfigurationModel) {
        titleLabel.text = model.title.capitalizedFirstLetter
        subtitleLabel.text = model.subtitle
        descriptionLabel.text = model.description
        largeImageView.setImage(model.imageUrl)
        largeImageView.isHidden = model.imageUrl == nil
    }
}
