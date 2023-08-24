//
//  File.swift
//  
//
//  Created by João Pedro Mata on 23/08/23.
//

import Favorites
import UIKit
import DesignSystem

extension KBCoreFlowManager {
    func setFavoritesManager() {
        let flowManager = KBFavoritesFlowManager(serviceManager: serviceManager)
        flowManager.integration = self
        favoritesManager = flowManager
    }
    
    func addFavoritesTab(to tabBar: KBTabBarController) {
        guard let favoritesManager = favoritesManager as? KBFavoritesFlowManager else { return }
        let favoritesVC = favoritesManager.makeFavoritesViewController()
        tabBar.addTab(tabRootController: favoritesVC,
                      title: "Favoritos",
                      image: UIImage.heartIcon)
        favoritesManager.setNavigation(with: tabBar.navigationControllers.last)
    }
}

extension KBCoreFlowManager: KBFavoritesModuleIntegrationProtocol { }
