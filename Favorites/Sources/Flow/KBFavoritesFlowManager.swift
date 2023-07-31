//
//  KBFavoritesFlowManager.swift
//  
//
//  Created by João Pedro Mata on 30/07/23.
//

import UIKit
import Network
import DesignSystem

final public class KBFavoritesFlowManager {
    
    private var navigationController: UINavigationController?
    private let serviceManager: KBServiceManagerProtocol
    public weak var favoritesIntegration: KBFavoritesModuleIntegrationProtocol?
    
    public init(serviceManager: KBServiceManagerProtocol) {
        self.serviceManager = serviceManager
    }
    
    // MARK: - MODULE INTEGRATOR
    
    public func makeFavoritesViewController() -> KBFavoritesViewController {
        let viewController = KBFavoritesViewController()
        viewController.navigationDelegate = self
        return viewController
    }
    
    public func setNavigation(with navigation: UINavigationController?) {
        navigationController = navigation
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

extension KBFavoritesFlowManager: KBBaseNavigationViewControllerDelegate {
    public func didTapNavigationCartItem() {
        presentShoppingCartPage()
    }
    
    public func didTapNavigationSearchBar(from tabIndex: Int) {
        goToSearchPage()
    }
    
    public func appendProductToCartList(for productCode: Int) {
        favoritesIntegration?.appendProductToCartList(for: productCode)
    }
    
    public func removeProductFromCartList(for productCode: Int) {
        favoritesIntegration?.removeProductFromCartList(for: productCode)
    }
}
