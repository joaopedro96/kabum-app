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
        
        ///Timer setted only to aid sight perception of the transition between this CoverView and the HomeView. Not required in real applications.
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            self.fetchHome()
//        }
        fetchHome()
    }
    
    // MARK: - PRIVATE METHODS
    
    private func setupController() {
        view = contentView
        contentView.setSpinnerAnimation(true)
    }
    
    private func fetchHome() {
        KBServiceManager.shared.execute(request: KBRequest.home(page: 1)) { [weak self] (result: Result<KBHomeModel, Error>) in
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
