//
//  UIImageView+Kingfisher.swift
//  SkyTestDictionary
//
//  Created by Борис Анели on 22.09.2020.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(_ urlString: String?) {
        var resource: ImageResource?
        guard let urlString = urlString,
              let url = URL(string: urlString) else {
            kf.setImage(with: resource)
            return
        }
        
        resource = ImageResource(downloadURL: url)
        kf.setImage(with: resource)
    }
}
