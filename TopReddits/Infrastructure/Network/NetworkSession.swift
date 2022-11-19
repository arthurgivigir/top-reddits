//
//  NetworkSession.swift
//  TopReddits
//
//  Created by Arthur Givigir on 19/11/22.
//

import Foundation

protocol NetworkSession {
    func fetchData(with urlRequest: URLRequest, completion: @escaping (Data?, Error?) -> Void)
}

extension URLSession: NetworkSession {
    func fetchData(with urlRequest: URLRequest, completion: @escaping (Data?, Error?) -> Void) {
        let task = dataTask(with: urlRequest) { (data, _, error) in
            completion(data, error)
        }
        
        task.resume()
    }
}
