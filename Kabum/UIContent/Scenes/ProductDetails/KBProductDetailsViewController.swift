//
//  KBProductDetailsViewController.swift
//  Kabum
//
//  Created by João Pedro Mata on 30/05/23.
//

import UIKit

///View implemented only to show product detail navigation flow
final class KBProductDetailsViewController: UIViewController {
    
    // MARK: - PROPERTIES
    
    let productUrl: String
    let service: KBServiceManagerProtocol
    
    // MARK: - INITIALIZERS
    
    init(productUrl: String, service: KBServiceManagerProtocol) {
        self.productUrl = productUrl
        self.service = service
        super.init(nibName: nil, bundle: nil)
    }
    
    @available (*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Detalhes do Produto"
        view.backgroundColor = .gray200
        fetchProductDetails()
    }
    
    // MARK: - PRIVATE METHODS
    
    ///Product endpoint without authetication to complete request
    private func fetchProductDetails() {
        service.execute(request: KBHomeRequest.productDetails(url: productUrl)) { (result: Result<ProductDetailsResponse, Error>) in
            switch result {
                case .success(let data):
                    print(data)
                case .failure:
                    return
            }
        }
    }
}

struct ProductDetailsResponse: Codable { }
