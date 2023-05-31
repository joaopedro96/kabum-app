//
//  KBRequest.swift
//  Kabum
//
//  Created by João Pedro Mata on 30/05/23.
//

import Foundation
import Alamofire

enum KBRequest: KBServiceRequestProtocol {
    
    case home(page: Int)
    case description(url: String)
    
    var path: String {
        switch self {
            case .home: return "https://servicespub.prod.api.aws.grupokabum.com.br/home/v1/home/produto"
            case .description(let url): return url
        }
    }

    var method: HTTPMethod {
        switch self {
            default: return .get
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
            case .home(let page):
                let params = ["app": 1, "limite": 10, "pagina": page]
                return params
            default: return nil
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
            default: return nil
        }
    }
}

