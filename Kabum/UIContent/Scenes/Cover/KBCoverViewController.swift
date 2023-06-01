//
//  KBCoverViewController.swift
//  Kabum
//
//  Created by João Pedro Mata on 30/05/23.
//

import UIKit

protocol KBCoverViewControllerDelegate: AnyObject {
    func goToHomePage(with homeData: KBHomeModel)
}

final class KBCoverViewController: UIViewController {
    
    // MARK: - PROPERTIES
    
    private let contentView: KBCoverView
    weak var delegate: KBCoverViewControllerDelegate?
    
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
        contentView.setSpinnerAnimation(true)
    }
    
    private func fetchHome() {
        let firstPage = KBRequest.firstHomePage
        KBServiceManager.shared.execute(request: KBRequest.home(page: firstPage)) { [weak self] (result: Result<KBHomeModel, Error>) in
            switch result {
                case .success(let data):
                    self?.contentView.setSpinnerAnimation(false)
                    self?.delegate?.goToHomePage(with: data)
                    
                ///Errors should be handled here.
                case .failure(let error):
                    print(error)
            }
        }
    }
}
