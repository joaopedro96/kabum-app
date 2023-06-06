//
//  KBFavoritesViewController.swift
//  Kabum
//
//  Created by João Pedro Mata on 30/05/23.
//

import UIKit

protocol KBFavoritesViewControllerDelegate: AnyObject {
    func goToSearchPage(from tabIndex: Int)
}

///View implemented only to show TabBar navigation
final class KBFavoritesViewController: KBBaseNavigationViewController {
    
    weak var delegate: KBFavoritesViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
    
    override func didTapNavigationSearchBar() {
        guard let tabBarIndex = tabBarIndex else { return }
        delegate?.goToSearchPage(from: tabBarIndex)
    }
}
