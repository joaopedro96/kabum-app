//
//  KBCoverViewController.swift
//  Kabum
//
//  Created by João Pedro Mata on 30/05/23.
//

import UIKit

protocol KBCoverViewViewControllerDelegate: AnyObject {
    func goToHomePage(with homeData: KBHomeResponse)
}

final class KBCoverViewController: UIViewController {
    
    // MARK: - PROPERTIES
    
    private let contentView: KBCoverView
    weak var delegate: KBCoverViewViewControllerDelegate?
    
    // MARK: - INITIALIZERS
    
    init(contentView: KBCoverView = KBCoverView()) {
        self.contentView = contentView
        super.init(nibName: nil, bundle: nil)
    }
    
    @available (*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
        fetchHome()
    }
    
    // MARK: - PRIVATE METHODS
    
    private func setupController() {
        view = contentView
    }
    
    private func fetchHome() {
        KBServiceManager.shared.execute(request: KBRequest.home(page: 1)) { [weak self] (result: Result<KBHomeResponse, Error>) in
            switch result {
                case .success(let data):
                    self?.contentView.setSpinnerAnimation(false)
                    self?.delegate?.goToHomePage(with: data)
                case .failure(let error):
                    print(error)
            }
        }
    }
}
