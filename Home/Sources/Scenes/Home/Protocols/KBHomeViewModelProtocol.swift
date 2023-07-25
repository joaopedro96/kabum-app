//
//  KBHomeViewModelProtocol.swift
//  Kabum
//
//  Created by João Pedro Mata on 04/06/23.
//

import Foundation
import RxSwift

public protocol KBHomeViewModelProtocol: AnyObject {
    var viewState: BehaviorSubject<KBHomeViewState> { get }
    func initState()
    func getProductData(for page: Int)
    func getProductDescriptionUrl(for index: Int) -> String
    func getProductCode(for index: Int) -> Int
}
