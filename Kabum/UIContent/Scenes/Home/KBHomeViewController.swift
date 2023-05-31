//
//  KBHomeViewController.swift
//  Kabum
//
//  Created by João Pedro Mata on 30/05/23.
//

import UIKit

final class KBHomeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        title = "Home"
        let image = UIView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .purple
        view.addSubview(image)
        image.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        image.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        image.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        image.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
}
