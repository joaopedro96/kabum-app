//
//  KBCategoriesModuleIntegrationProtocol.swift
//  
//
//  Created by João Pedro Mata on 30/07/23.
//

import Foundation

public protocol KBCategoriesModuleIntegrationProtocol: AnyObject {
    func appendProductToCartList(for productCode: Int)
    func removeProductFromCartList(for productCode: Int)
}
