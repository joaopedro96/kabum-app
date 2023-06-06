//
//  KBHomeViewController.swift
//  Kabum
//
//  Created by João Pedro Mata on 30/05/23.
//

import UIKit
import RxSwift

protocol KBHomeViewControllerDelegate: AnyObject {
    func goToProductDetailsPage(from tabIndex: Int, with url: String)
    func goToSearchPage(from tabIndex: Int)
}

final class KBHomeViewController: KBBaseNavigationViewController {
    
    // MARK: - PROPERTIES
    
    private let viewModel: KBHomeViewModelProtocol
    private let contentView: KBHomeViewProtocol

    weak var delegate: KBHomeViewControllerDelegate?
    private let disposeBag = DisposeBag()
    
    // MARK: - INITIALIZERS
    
    init(viewModel: KBHomeViewModelProtocol,
         contentView: KBHomeViewProtocol = KBHomeView()) {
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
    
    // MARK: - OVERRIDE METHODS
    
    override func didTapNavigationSearchBar() {
        guard let tabBarIndex = tabBarIndex else { return }
        delegate?.goToSearchPage(from: tabBarIndex)
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

extension KBHomeViewController: KBHomeViewDelegate {
    func didTapProduct(with index: Int) {
        guard let tabBarIndex = tabBarIndex else { return }
        let url = viewModel.getProductDescriptionUrl(for: index)
        delegate?.goToProductDetailsPage(from: tabBarIndex, with: url)
    }
    
    func getNextProductList(for currentPage: Int) {
        let nextPage = currentPage + 1
        viewModel.getProductData(for: nextPage)
    }
}
