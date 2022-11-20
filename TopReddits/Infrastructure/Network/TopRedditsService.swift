//
//  TopRedditsService.swift
//  TopReddits
//
//  Created by Arthur Givigir on 19/11/22.
//

import Foundation

protocol TopRedditsService {
    func fetchTopReddits(completion: @escaping((Result<TopRedditsModel, NetworkError>) -> Void))
    func fetchTopReddits(_ afterPage: String?, completion: @escaping((Result<TopRedditsModel, NetworkError>) -> Void))
}

class DefaultTopRedditsService: TopRedditsService {
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }

    func fetchTopReddits(completion: @escaping ((Result<TopRedditsModel, NetworkError>) -> Void)) {
        guard let url = TopRedditsEndpoints.topReddits.url else {
            completion(.failure(.badlyFormattedUrl))
            return
        }
        
        networkManager.makeRequest(with: url, decode: TopRedditsModel.self) { result in
            completion(result)
        }
    }
    
    func fetchTopReddits(_ afterPage: String?, completion: @escaping ((Result<TopRedditsModel, NetworkError>) -> Void)) {
        guard let url = TopRedditsAPIEndpoints.topReddits(afterPage).url else {
            completion(.failure(.badlyFormattedUrl))
            return
        }
        
        networkManager.makeRequest(with: url, decode: TopRedditsModel.self) { result in
            completion(result)
        }
    }
}
