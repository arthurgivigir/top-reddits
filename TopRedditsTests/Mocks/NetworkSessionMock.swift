//
//  NetworkSessionMock.swift
//  TopRedditsTests
//
//  Created by Arthur Givigir on 19/11/22.
//
@testable import TopReddits
import Foundation

class NetworkSessionMock: NetworkSession {
    private(set) var requestUrl: URL?

    var data: Data?
    var error: Error?
    
    func fetchData(with urlRequest: URLRequest, completion: @escaping (Data?, Error?) -> Void) {
        requestUrl = urlRequest.url
        completion(data, error)
    }
}
