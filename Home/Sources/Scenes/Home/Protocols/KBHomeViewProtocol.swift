//
//  KBHomeViewProtocol.swift
//  Kabum
//
//  Created by João Pedro Mata on 04/06/23.
//

import UIKit

public protocol KBHomeViewProtocol: AnyObject {
    var content: UIView { get }
    var delegate: KBHomeViewDelegate? { get set }
    func updateState(with viewState: KBHomeViewState)
}

extension KBHomeViewProtocol where Self: UIView {
    public var content: UIView { return self }
}
