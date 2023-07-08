//
//  KBServiceManagerProtocol.swift
//  Kabum
//
//  Created by João Pedro Mata on 30/05/23.
//

import Foundation
import Alamofire

protocol KBServiceManagerProtocol {
    func execute<T: Decodable>(request: KBServiceRequestProtocol,
                               completion: @escaping (Result<T, Error>) -> Void)
    func getStatusCode(request: KBServiceRequestProtocol, completion: @escaping ((Int?) -> Void))
    func logRequest(with response: AFDataResponse<Data?>, data: Data?, error: Error?)
    func logParseError(for error: Error)
}

extension KBServiceManagerProtocol {
    
    func logRequest(with response: AFDataResponse<Data?>, data: Data? = nil, error: Error? = nil) {
        guard let requestResponse = response.response,
              let url = requestResponse.url,
              let request = response.request,
              let method = request.method else { return }
        
        print("\n--------------------------------------------------------------")
        print("- URL: \(url)\n")
        print("- Method: \(method.rawValue)\n")
        print("- Status: \(requestResponse.statusCode)\n")
        
        if let data = data {
            print("- JSON: \(data.prettyPrintedJSONString)")
        } else if let error = error {
            print(error)
        }
    }
    
    func logParseError(for error: Error) {
        print("\n-------------------------PARSE ERROR--------------------------")
        print(error)
    }
    
}
