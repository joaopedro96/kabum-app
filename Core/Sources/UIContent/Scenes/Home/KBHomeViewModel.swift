//
//  KBHomeViewModel.swift
//  Kabum
//
//  Created by João Pedro Mata on 04/06/23.
//

import Foundation
import RxSwift

final class KBHomeViewModel: KBHomeViewModelProtocol {
    
    // MARK: - PROPERTIES
    
    private let service: KBServiceManagerProtocol
    private var homeResponse: KBHomeResponse
    let viewState = BehaviorSubject<KBHomeViewState>(value: .isEmpty)
    
    // MARK: - INITIALIZER
    
    init(service: KBServiceManagerProtocol, homeResponse: KBHomeResponse) {
        self.service = service
        self.homeResponse = homeResponse
    }
    
    // MARK: - PUBLIC METHODS
    
    func initState() {
        let entity = makeEntity(with: homeResponse)
        viewState.onNext(.hasData(entity))
    }
    
    func getProductData(for page: Int) {
        viewState.onNext(.isLoading)
        fetchProducts(for: page)
    }
    
    func getProductDescriptionUrl(for index: Int) -> String {
        let descriptionUrl = homeResponse.products[index].descriptionUrl
        return descriptionUrl
    }
    
    func getProductCode(for index: Int) -> Int {
        let productCode = homeResponse.products[index].code
        return productCode
    }
    
    // MARK: - FETCH METHODS
    
    private func fetchProducts(for page: Int) {
        service.execute(request: KBHomeRequest.home(page: page)) { [weak self] (result: Result<KBHomeResponse, Error>) in
            guard let self = self else { return }
            switch result {
                case .success(let newProducts):
                    updateResponse(with: newProducts)
                    let tableViewNewProducts = makeTableViewEntity(with: newProducts.products)
                    viewState.onNext(.hasNextPageData(tableViewNewProducts))
                    
                case .failure(let error):
                    viewState.onNext(.hasError(error))
            }
        }
    }
    
    // MARK: - PRIVATE METHODS
    
    private func updateResponse(with newProducts: KBHomeResponse) {
        homeResponse.products.append(contentsOf: newProducts.products)
    }
    
    private func makeEntity(with response: KBHomeResponse) -> KBHomeViewEntity {
        let tableViewEntity = makeTableViewEntity(with: response.products)
        let entity = KBHomeViewEntity(sectionTitle: "Produtos",
                                      offerTitle: "Em destaque",
                                      tableViewEntity: tableViewEntity)
        return entity
    }
    
    private func makeTableViewEntity(with products: [KBProductObject]) -> [KBHomeTableViewCellEntity] {
        let tableViewEntity: [KBHomeTableViewCellEntity] = products.map { product in
            KBHomeTableViewCellEntity(name: product.name,
                                      image: product.image,
                                      manufacturerName: product.manufacturer.name,
                                      formattedPrice: product.formattedPrice + " em até 10x",
                                      formattedDiscountPrice: product.formattedDiscountPrice,
                                      discountPrice: product.discountPrice,
                                      primeDiscountPrice: product.primeDiscountPrice,
                                      buyButtonTitle: "Comprar",
                                      isOffer: (product.offer?.code != nil),
                                      isOpenBox: product.isOpenBox,
                                      isFreeShipping: product.freeShipping)
        }
        return tableViewEntity
    }
}
