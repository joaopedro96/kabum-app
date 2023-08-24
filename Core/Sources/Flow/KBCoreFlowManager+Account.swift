//
//  File.swift
//  
//
//  Created by João Pedro Mata on 23/08/23.
//

import UIKit
import Account
import DesignSystem

extension KBCoreFlowManager {
    func setAccountManager() {
        accountManager = KBAccountFlowManager(serviceManager: serviceManager)
        accountManager?.accountIntegration = self
    }
    
    func addAccountTab(to tabBar: KBTabBarController) {
        guard let accountVC = accountManager?.makeAccountViewController() else { return }
        tabBar.addTab(tabRootController: accountVC,
                      title: "Minha Conta",
                      image: UIImage.accountIcon)
        accountManager?.setNavigation(with: tabBar.navigationControllers.last)
    }
}

extension KBCoreFlowManager: KBAccountModuleIntegrationProtocol { }
