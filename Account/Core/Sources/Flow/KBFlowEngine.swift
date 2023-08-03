//
//  KBFlowEngine.swift
//  Core
//
//  Created by João Pedro Mata on 26/07/23.
//

import UIKit
import Network
import DesignSystem
import Account

public class KBFlowEngine {
    
    public var tabBarNavControllers: [UINavigationController]
    public let serviceManager: KBServiceManagerProtocol
    private var accountManager: KBAccountFlowManager
    
    public init(tabBarNavControllers: [UINavigationController], serviceManager: KBServiceManagerProtocol) {
        self.tabBarNavControllers = tabBarNavControllers
        self.serviceManager = serviceManager
        accountManager = KBAccountFlowManager(serviceManager: serviceManager)
        accountManager.accountIntegration = self
    }
    
    public func assembleTabBar() -> UITabBarController? {
        let tabBar = KBTabBarController()
        addAccountTab(to: tabBar)
        tabBarNavControllers.append(contentsOf: tabBar.navigationControllers)
        return tabBar
    }
    
    private func addAccountTab(to tabBar: KBTabBarController) {
        let accountVC = accountManager.makeAccountViewController()
        tabBar.addTab(tabRootController: accountVC,
                      title: "Minha Conta",
                      image: UIImage.accountIcon)
    }
}

extension KBFlowEngine: KBAccountModuleIntegrationProtocol { }
