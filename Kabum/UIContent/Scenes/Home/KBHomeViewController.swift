//
//  KBHomeViewController.swift
//  Kabum
//
//  Created by João Pedro Mata on 30/05/23.
//

import UIKit

protocol KBHomeViewControllerDelegate: AnyObject {
    func goToProductDetailsPage(with url: String)
}

final class KBHomeViewController: UIViewController {
    
    // MARK: - PROPERTIES
    
    private let contentView: KBHomeView
    private let productList: [KBProductObject]
    weak var delegate: KBHomeViewControllerDelegate?
    
    // MARK: - INITIALIZERS
    
    init(contentView: KBHomeView = KBHomeView(),
         productList: [KBProductObject]) {
        self.contentView = contentView
        self.productList = productList
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
    }
    
    // MARK: - PRIVATE METHODS
    
    private func setupController() {
        view = contentView
        title = "Home"
        contentView.delegate = self
        contentView.updateView(with: productList)
    }
    
    private func fetchProducts(for page: Int) {
        KBServiceManager.shared.execute(request: KBRequest.home(page: page)) { [weak self] (result: Result<KBHomeModel, Error>) in
            switch result {
                case .success(let data):
                    self?.contentView.updateProductNextPage(with: data.products)
                    
                ///Errors should be handled here.
                case .failure(let error):
                    print(error)
            }
        }
    }
}

// MARK: - EXTENSIONS

extension KBHomeViewController: KBHomeViewDelegate {
    func didTapProduct(with url: String) {
        delegate?.goToProductDetailsPage(with: url)
    }
    
    func getNextProductList(for currentPage: Int) {
        let nextPage = currentPage + 1
        fetchProducts(for: nextPage)
    }
}
