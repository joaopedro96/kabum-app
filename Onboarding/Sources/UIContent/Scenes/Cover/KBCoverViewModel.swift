//
//  KBCoverViewModel.swift
//  Kabum
//
//  Created by João Pedro Mata on 04/06/23.
//

import Foundation
import RxSwift
import Network

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
    }
}
