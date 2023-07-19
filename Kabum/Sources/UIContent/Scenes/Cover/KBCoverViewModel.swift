//
//  KBCoverViewModel.swift
//  Kabum
//
//  Created by João Pedro Mata on 04/06/23.
//

import Foundation
import RxSwift

final class KBCoverViewModel: KBCoverViewModelProtocol {
    
    // MARK: - PROPERTIES
    
    private let service: KBServiceManagerProtocol
    let viewState = BehaviorSubject<KBCoverViewState>(value: .isEmpty)
    
    // MARK: - INITIALIZER
    
    init(service: KBServiceManagerProtocol) {
        self.service = service
    }
    
    // MARK: - PUBLIC METHODS
    
    func initState() {
        viewState.onNext(.isLoading)
        fetchHomeData()
    }
    
    // MARK: - FETCH METHODS
    
    private func fetchHomeData() {
        service.execute(request: KBHomeRequest.home(page: 1)) { [weak self] (result: Result<KBHomeResponse, Error>) in
            switch result {
                case .success(let data):
                    self?.viewState.onNext(.hasData(data))
                case .failure(let error):
                    self?.viewState.onNext(.hasError(error))
            }
        }
    }
}
