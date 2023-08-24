//
//  KBCoverViewController.swift
//  Kabum
//
//  Created by João Pedro Mata on 30/05/23.
//

import UIKit
import RxSwift

protocol KBCoverViewControllerDelegate: AnyObject {
    func goToHomePage()
}

final public class KBCoverViewController: UIViewController {
    
    // MARK: - PROPERTIES
    
    private let viewModel: KBCoverViewModelProtocol
    private let contentView: KBCoverViewProtocol
    
    weak var delegate: KBCoverViewControllerDelegate?
    private let disposeBag = DisposeBag()

    // MARK: - INITIALIZERS
    
    init(viewModel: KBCoverViewModelProtocol,
         contentView: KBCoverViewProtocol = KBCoverView()) {
        self.viewModel = viewModel
        self.contentView = contentView
        super.init(nibName: nil, bundle: nil)
    }
    
    @available (*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LIFE CYCLE
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupController()
        bindObservables()
    }
    
    func start() {
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
    func goToHomePage() {
        delegate?.goToHomePage()
    }
}
