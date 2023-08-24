//
//  File.swift
//  
//
//  Created by João Pedro Mata on 23/08/23.
//

import Home
import UIKit
import DesignSystem

extension KBCoreFlowManager {
    func setHomeManager() {
        homeManager = KBHomeFlowManager(serviceManager: serviceManager)
        homeManager?.homeIntegration = self
    }
    
    func addHomeTab(to tabBar: KBTabBarController) {
        guard let homeVC = homeManager?.makeHomeViewController() else { return }
        tabBar.addTab(tabRootController: homeVC,
                      title: "Início",
                      image: UIImage.homeIcon)
        homeManager?.setNavigation(with: tabBar.navigationControllers.last)
    }
}

extension KBCoreFlowManager: KBHomeModuleIntegrationProtocol {
    public func appendProductToCartList(for productCode: Int) {
        tabBarNavControllers.forEach { navigationController in
            let navController = navigationController as? KBSearchableNavigationController
            navController?.rootViewController.shoppingCartList.append(productCode)
        }
    }
    
    public func removeProductFromCartList(for productCode: Int) {
        tabBarNavControllers.forEach { navigationController in
            let navController = navigationController as? KBSearchableNavigationController
            navController?.rootViewController.shoppingCartList.removeAll(where: { $0 == productCode } )
        }
    }
}