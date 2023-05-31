//
//  KBServiceRequestProtocol.swift
//  Kabum
//
//  Created by João Pedro Mata on 30/05/23.
//

import Foundation
import Alamofire

protocol KBServiceRequestProtocol {
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any]? { get }
    var headers: HTTPHeaders? { get }
}
