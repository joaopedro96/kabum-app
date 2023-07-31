//
//  File.swift
//  
//
//  Created by João Pedro Mata on 29/07/23.
//

import UIKit

public protocol KBHomeModuleIntegrationProtocol: AnyObject {
    func appendProductToCartList(for productCode: Int)
    func removeProductFromCartList(for productCode: Int)
}
