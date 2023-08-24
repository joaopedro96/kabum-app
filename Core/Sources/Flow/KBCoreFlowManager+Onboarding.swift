//
//  File.swift
//  
//
//  Created by João Pedro Mata on 23/08/23.
//

import Onboarding
import UIKit
import DesignSystem

extension KBCoreFlowManager {
    func setOnboardingManager() {
        let flowManager = KBOnboardingFlowManager(serviceManager: serviceManager)
        flowManager.integration = self
        onboardingManager = flowManager
    }
    
    func getOnboardingRootViewController() -> UIViewController? {
        guard let onboardingManager = onboardingManager as? KBOnboardingFlowManager else { return nil }
        let rootVC = onboardingManager.makeCoverViewController()
        return rootVC
    }
    
    func startOnboarding() {
        guard let onboardingManager = onboardingManager as? KBOnboardingFlowManager else { return }
        onboardingManager.start()
    }
}

extension KBCoreFlowManager: KBOnboardingModuleIntegrationProtocol {
    public func setupTabBar() {
        rootNavigation?.viewControllers.removeAll()
        
        guard let tabBar = assembleTabBar() else { return }
        rootNavigation?.pushViewController(tabBar, animated: false)
    }
}
