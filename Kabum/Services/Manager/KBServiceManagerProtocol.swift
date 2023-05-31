//
//  KBServiceManagerProtocol.swift
//  Kabum
//
//  Created by João Pedro Mata on 30/05/23.
//

import Foundation

protocol KBServiceManagerProtocol {
    func execute<T: Decodable>(request: KBServiceRequestProtocol,
                               completion: @escaping (Result<T, Error>) -> Void)
}
