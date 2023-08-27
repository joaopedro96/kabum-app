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
        let flowManager = KBHomeFlowManager(serviceManager: serviceManager)
        flowManager.integration = self
        homeManager = flowManager
    }
    
    func addHomeTab(to tabBar: KBTabBarController) {
        guard let homeManager = homeManager as? KBHomeFlowManager else { return }
        let homeVC = homeManager.makeHomeViewController()
        tabBar.addTab(tabRootController: homeVC,
                      title: "Início",
                      image: UIImage.homeIcon)
        homeManager.setNavigation(with: tabBar.navigationControllers.last)
    }
}

extension KBCoreFlowManager: KBHomeModuleIntegrationProtocol { }
