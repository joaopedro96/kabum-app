//
//  File.swift
//  
//
//  Created by João Pedro Mata on 23/08/23.
//

import UIKit
import Favorites
import DesignSystem

extension KBCoreFlowManager {
    func setFavoritesManager() {
        favoritesManager = KBFavoritesFlowManager(serviceManager: serviceManager)
        favoritesManager?.favoritesIntegration = self
    }
    
    func addFavoritesTab(to tabBar: KBTabBarController) {
        guard let favoritesVC = favoritesManager?.makeFavoritesViewController() else { return }
        tabBar.addTab(tabRootController: favoritesVC,
                      title: "Favoritos",
                      image: UIImage.heartIcon)
        favoritesManager?.setNavigation(with: tabBar.navigationControllers.last)
    }
}

extension KBCoreFlowManager: KBFavoritesModuleIntegrationProtocol { }
