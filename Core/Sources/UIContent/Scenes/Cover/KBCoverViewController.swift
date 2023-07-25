//
//  KBCoverViewController.swift
//  Kabum
//
//  Created by João Pedro Mata on 30/05/23.
//

import UIKit
import RxSwift
import Home

protocol KBCoverViewControllerDelegate: AnyObject {
    func goToHomePage(with response: KBHomeResponse)
}

final class KBCoverViewController: UIViewController {
    
    // MARK: - PROPERTIES
    
    private let viewModel: KBCoverViewModelProtocol
    private let contentView: KBCoverViewProtocol
    
    weak var delegate: KBCoverViewControllerDelegate?
    private let disposeBag = DisposeBag()

    // MARK: - INITIALIZERS
    
    init(viewModel: KBCoverViewModelProtocol, contentView: KBCoverViewProtocol = KBCoverView()) {
        self.viewModel = viewModel
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
        bindObservables()
        viewModel.initState()
    }
    
    // MARK: - PRIVATE METHODS
    
    private func setupController() {
        view = contentView.content
        contentView.delegate = self
    }
    
    private func bindObservables() {
        viewModel.viewState.subscribe(onNext: { [weak self] state in
            
            self?.contentView.updateState(with: state)
            
        }).disposed(by: disposeBag)
    }
}

// MARK: - EXTENSIONS

extension KBCoverViewController: KBCoverViewDelegate {
    func goToHomePage(with response: KBHomeResponse) {
        delegate?.goToHomePage(with: response)
    }
}
