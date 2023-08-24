//
//  KBAccountFlowManager.swift
//  
//
//  Created by João Pedro Mata on 30/07/23.
//

import UIKit
import Network
import DesignSystem

final public class KBAccountFlowManager: KBModuleIntegrator {
    
    private var navigationController: UINavigationController?
    private let serviceManager: KBServiceManagerProtocol
    
    public weak var integration: KBAccountModuleIntegrationProtocol?
    
    public init(serviceManager: KBServiceManagerProtocol) {
        self.serviceManager = serviceManager
    }
    
    // MARK: - MODULE INTEGRATOR
    
    public func makeAccountViewController() -> KBAccountViewController {
        let viewController = KBAccountViewController()
        return viewController
    }
    
    public func setNavigation(with navigation: UINavigationController?) {
        navigationController = navigation
    }
}
