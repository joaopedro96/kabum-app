//
//  KBCoverProtocols.swift
//  Kabum
//
//  Created by João Pedro Mata on 04/06/23.
//

import Foundation
import RxSwift

protocol KBCoverViewModelProtocol: AnyObject {
    var viewState: BehaviorSubject<KBCoverViewState> { get }
    func initState()
}
