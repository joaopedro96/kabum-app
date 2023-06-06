//
//  KBBaseNavigationViewController.swift
//  Kabum
//
//  Created by João Pedro Mata on 05/06/23.
//

import UIKit

class KBBaseNavigationViewController: UIViewController, KBNavigationControllerDelegate {

    var tabBarIndex: Int?
    
    var rightImageIcon: KBNavigationCustomItemView?
    
    func didTapNavigationSearchBar() {
        print("searchBarTapped")
    }
    
    func didTapNavigationCartItem() {
        print("navigationRightItemTapped")
    }
    
}
