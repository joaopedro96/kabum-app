//
//  KBFlowManager.swift
//  Kabum
//
//  Created by João Pedro Mata on 30/05/23.
//

import UIKit
import Network
import Engine

public class KBFlowManager: UINavigationController {
    
    // MARK: - PROPERTIES
    
    private var tabBarNavControllers: [UINavigationController] = []
    private let serviceManager: KBServiceManagerProtocol = KBServiceManager()
    private let flowEngine: KBFlowEngine
    
    // MARK: - INITIALIZERS
    
    public init() {
        self.flowEngine = KBFlowEngine(tabBarNavControllers: tabBarNavControllers,
                                       serviceManager: serviceManager)
        let viewModel = KBCoverViewModel(service: serviceManager)
        let rootVC = KBCoverViewController(viewModel: viewModel)
        super.init(rootViewController: rootVC)
        navigationBar.isHidden = true
        rootVC.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension KBFlowManager: KBCoverViewControllerDelegate {
    public func goToHomePage() {
        ///Delete CoverView from navigation stack to prevent going back to cover page
        viewControllers.removeAll()
        
        guard let tabBar = flowEngine.assembleTabBar() else { return }
        pushViewController(tabBar, animated: false)
    }
}
