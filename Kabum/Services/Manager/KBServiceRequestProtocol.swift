//
//  KBServiceRequestProtocol.swift
//  Kabum
//
//  Created by João Pedro Mata on 30/05/23.
//

import Foundation
import Alamofire

protocol KBServiceRequestProtocol {
    var baseURL: String { get }
    var url: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any]? { get }
    var headers: HTTPHeaders? { get }
}

extension KBServiceRequestProtocol {
    var baseURL: String {
        return "https://servicespub.prod.api.aws.grupokabum.com.br"
    }
    
    var url: String {
        return baseURL + path
    }
}
