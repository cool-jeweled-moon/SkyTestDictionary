//
//  MainCoordinator.swift
//  SkyTestDictionary
//
//  Created by Борис Анели on 23.09.2020.
//

import UIKit
import JeweledKit

class MainCoordinator: JeweledCoordinator {
    
    var childCoordinators = [JeweledCoordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let controller = WordsSearchViewController()
        controller.coordinator = self
        navigationController.pushViewController(controller, animated: true)
    }
    
    func wordDetails(word: Word) {
        let controller = WordDetailsViewController(word: word)
        controller.coordinator = self
        navigationController.pushViewController(controller, animated: true)
    }
}
