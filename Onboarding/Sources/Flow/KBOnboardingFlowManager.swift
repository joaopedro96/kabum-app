//
//  KBOnboardingFlowManager.swift
//  Kabum
//
//  Created by João Pedro Mata on 30/05/23.
//

import UIKit
import Network

public class KBOnboardingFlowManager {
    
    // MARK: - PROPERTIES
    
//    private var tabBarNavControllers: [UINavigationController] = []
    private let serviceManager: KBServiceManagerProtocol
    private var coverViewController: KBCoverViewController
//    private let flowEngine: KBFlowEngine
    
    public weak var onboardingIntegration: KBOnboardingModuleIntegrationProtocol?
    
    // MARK: - INITIALIZERS
    
    public init(serviceManager: KBServiceManagerProtocol) {
//        self.flowEngine = KBFlowEngine(tabBarNavControllers: tabBarNavControllers,
//                                       serviceManager: serviceManager)
        self.serviceManager = serviceManager
        let viewModel = KBCoverViewModel(service: serviceManager)
        self.coverViewController = KBCoverViewController(viewModel: viewModel)
        self.coverViewController.delegate = self
//        let viewModel = KBCoverViewModel(service: serviceManager)
//        let rootVC = KBCoverViewController(viewModel: viewModel)
//        super.init(rootViewController: rootVC)
//        navigationBar.isHidden = true
//        rootVC.delegate = self
    }
    
    public func makeCoverViewController() -> KBCoverViewController {
        return coverViewController
    }
    
    public func start() {
        coverViewController.start()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension KBOnboardingFlowManager: KBCoverViewControllerDelegate {
    public func goToHomePage() {
        onboardingIntegration?.setupTabBar()
        
        ///Delete CoverView from navigation stack to prevent going back to cover page
//        viewControllers.removeAll()
//        
//        guard let tabBar = flowEngine.assembleTabBar() else { return }
//        pushViewController(tabBar, animated: false)
    }
}
