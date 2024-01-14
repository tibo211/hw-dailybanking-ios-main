//
//  URLSessionProtocol.swift
//
//
//  Created by Tibor Felföldy on 2024-01-14.
//

import Foundation

protocol URLSessionProtocol {
    func data(from url: URL) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}
