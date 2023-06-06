//
//  KBAccountViewController.swift
//  Kabum
//
//  Created by João Pedro Mata on 30/05/23.
//

import UIKit

///View implemented only to show TabBar navigation
final class KBAccountViewController: KBBaseNavigationViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        navigationController?.navigationBar.isHidden = true
    }
}
