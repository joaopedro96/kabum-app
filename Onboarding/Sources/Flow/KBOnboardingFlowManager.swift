//
//  KBOnboardingFlowManager.swift
//  Kabum
//
//  Created by João Pedro Mata on 30/05/23.
//

import UIKit
import Network
import DesignSystem

public class KBOnboardingFlowManager: KBModuleIntegrator {
    
    // MARK: - PROPERTIES
    
    private var coverViewController: KBCoverViewController
    
    public weak var integration: KBOnboardingModuleIntegrationProtocol?
    
    // MARK: - INITIALIZERS
    
    public init(serviceManager: KBServiceManagerProtocol) {
        let viewModel = KBCoverViewModel(service: serviceManager)
        self.coverViewController = KBCoverViewController(viewModel: viewModel)
        self.coverViewController.delegate = self
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
        integration?.setupTabBar()
    }
}
