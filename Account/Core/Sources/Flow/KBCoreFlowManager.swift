//
//  KBCoreFlowManager.swift
//  Core
//
//  Created by João Pedro Mata on 26/07/23.
//

import UIKit
import Network
import DesignSystem
import Account
import Onboarding

public class KBCoreFlowManager: UINavigationController {
    
    private var tabBarNavControllers: [UINavigationController] = []
    private let serviceManager: KBServiceManagerProtocol = KBServiceManager()
    private var onboardingManager: KBOnboardingFlowManager
    private var accountManager: KBAccountFlowManager
    
    public init() {
        onboardingManager = KBOnboardingFlowManager(serviceManager: serviceManager)
        accountManager = KBAccountFlowManager(serviceManager: serviceManager)
        let rootVC = onboardingManager.makeCoverViewController()
        super.init(rootViewController: rootVC)
        onboardingManager.onboardingIntegration = self
        accountManager.accountIntegration = self
        navigationBar.isHidden = true
        start()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func start() {
        onboardingManager.start()
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

extension KBCoreFlowManager: KBOnboardingModuleIntegrationProtocol {
    public func setupTabBar() {
        viewControllers.removeAll()
        
        guard let tabBar = assembleTabBar() else { return }
        pushViewController(tabBar, animated: false)
    }
}

extension KBCoreFlowManager: KBAccountModuleIntegrationProtocol { }
