//
//  NetworkError.swift
//  TopReddits
//
//  Created by Arthur Givigir on 19/11/22.
//

import Foundation

public enum NetworkError: Error {
    case error(statusCode: Int, data: Data?)
    case notConnected
    case generic(Error)
    case notFound
    case badlyFormattedUrl
}
