//
//  File.swift
//  
//
//  Created by João Pedro Mata on 23/08/23.
//

import Foundation
import Onboarding
import DesignSystem

extension KBCoreFlowManager {
    func setOnboardingManager() {
        onboardingManager = KBOnboardingFlowManager(serviceManager: serviceManager)
        onboardingManager?.onboardingIntegration = self
    }
}

extension KBCoreFlowManager: KBOnboardingModuleIntegrationProtocol {
    public func setupTabBar() {
        rootNavigation?.viewControllers.removeAll()
        
        guard let tabBar = assembleTabBar() else { return }
        rootNavigation?.pushViewController(tabBar, animated: false)
    }
}
