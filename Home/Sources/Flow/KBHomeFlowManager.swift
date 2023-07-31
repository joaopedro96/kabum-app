//
//  KBHomeFlowManager.swift
//  
//
//  Created by João Pedro Mata on 29/07/23.
//

import UIKit
import Network
import DesignSystem

public class KBHomeFlowManager {
    
    private var navigationController: UINavigationController?
    private let serviceManager: KBServiceManagerProtocol
    
    public weak var homeIntegration: KBHomeModuleIntegrationProtocol?
    
    public init(serviceManager: KBServiceManagerProtocol) {
        self.serviceManager = serviceManager
    }
    
    // MARK: - MODULE INTEGRATOR
    
    public func makeHomeViewController() -> KBHomeViewController {
        let viewModel = KBHomeViewModel(service: serviceManager)
        let viewController = KBHomeViewController(viewModel: viewModel)
        viewController.navigationDelegate = self
        viewController.delegate = self
        return viewController
    }
    
    public func setNavigation(with navigation: UINavigationController?) {
        navigationController = navigation
    }
    
    private func makeProductsDetailViewController(with url: String) -> KBProductDetailsViewController {
        let viewController = KBProductDetailsViewController(productUrl: url, service: serviceManager)
        return viewController
    }
    
    private func presentShoppingCartPage() {
        let shoppingCartVC = UIViewController()
        shoppingCartVC.view.backgroundColor = .gray200
        navigationController?.present(shoppingCartVC, animated: true)
    }
    
    private func goToSearchPage() {
        let searchVC = UIViewController()
        searchVC.view.backgroundColor = .orange
        searchVC.title = "Pesquisar"
        navigationController?.pushViewController(searchVC, animated: true)
    }
    
}

extension KBHomeFlowManager: KBBaseNavigationViewControllerDelegate {
    public func didTapNavigationCartItem() {
        presentShoppingCartPage()
    }
    
    public func didTapNavigationSearchBar(from tabIndex: Int) {
        goToSearchPage()
    }
    
    public func appendProductToCartList(for productCode: Int) {
        homeIntegration?.appendProductToCartList(for: productCode)
    }
    
    public func removeProductFromCartList(for productCode: Int) {
        homeIntegration?.removeProductFromCartList(for: productCode)
    }
}

extension KBHomeFlowManager: KBHomeViewControllerDelegate {
    public func goToProductDetailsPage(from tabIndex: Int, with url: String) {
        let detailVC = makeProductsDetailViewController(with: url)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
