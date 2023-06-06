//
//  KBCategoriesViewController.swift
//  Kabum
//
//  Created by João Pedro Mata on 30/05/23.
//

import UIKit

protocol KBCategoriesViewControllerDelegate: AnyObject {
    func goToSearchPage(from tabIndex: Int)
}

///View implemented only to show TabBar navigation
final class KBCategoriesViewController: KBBaseNavigationViewController {
    
    weak var delegate: KBCategoriesViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }
    
    override func didTapNavigationSearchBar() {
        guard let tabBarIndex = tabBarIndex else { return }
        delegate?.goToSearchPage(from: tabBarIndex)
    }
}
