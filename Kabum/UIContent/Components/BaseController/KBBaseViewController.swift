//
//  KBBaseViewController.swift
//  Kabum
//
//  Created by João Pedro Mata on 30/05/23.
//

import UIKit

class KBBaseViewController: UIViewController, KBViewControllerProtocol {
    var tabIndex: Int?
}

protocol KBViewControllerProtocol: UIViewController {
    var tabIndex: Int? { get set }
}
