//
//  File.swift
//  
//
//  Created by João Pedro Mata on 23/08/23.
//

import Account
import UIKit
import DesignSystem

extension KBCoreFlowManager {
    func setAccountManager() {
        let flowManager = KBAccountFlowManager(serviceManager: serviceManager)
        flowManager.integration = self
        accountManager = flowManager
    }
    
    func addAccountTab(to tabBar: KBTabBarController) {
        guard let accountManager = accountManager as? KBAccountFlowManager else { return }
        let accountVC = accountManager.makeAccountViewController()
        tabBar.addTab(tabRootController: accountVC,
                      title: "Minha Conta",
                      image: UIImage.accountIcon)
        accountManager.setNavigation(with: tabBar.navigationControllers.last)
    }
}

extension KBCoreFlowManager: KBAccountModuleIntegrationProtocol { }
