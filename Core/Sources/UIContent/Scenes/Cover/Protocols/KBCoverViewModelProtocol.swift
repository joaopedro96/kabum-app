//
//  KBCoverProtocols.swift
//  Kabum
//
//  Created by João Pedro Mata on 04/06/23.
//

import Foundation
import UIKit
import RxSwift

protocol KBCoverViewModelProtocol: AnyObject {
    var viewState: BehaviorSubject<KBCoverViewState> { get }
    func initState()
}

protocol KBCoverViewProtocol: AnyObject {
    var content: UIView { get }
    var delegate: KBCoverViewDelegate? { get set }
    func updateState(with viewState: KBCoverViewState)
}

extension KBCoverViewProtocol where Self: UIView {
    var content: UIView { return self }
}

enum KBCoverViewState {
    case hasError(Error)
    case isEmpty
    case isLoading
}
