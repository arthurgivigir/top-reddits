//
//  DefaultTopRedditsRepository.swift
//  TopReddits
//
//  Created by Arthur Givigir on 19/11/22.
//

import Foundation

final class DefaultTopRedditsRepository: TopRedditsRepository {
    private let topRedditsService: TopRedditsService
    
    init(topRedditsService: TopRedditsService = DefaultTopRedditsService()) {
        self.topRedditsService = topRedditsService
    }
    
    func fecthTopReddits(completion: @escaping (Result<[RedditMessage], NetworkError>) -> Void) {
        topRedditsService.fetchTopReddits { result in
            switch result {
            case .success(let topReddits):
                completion(.success(topReddits.toEntity))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchTopReddits(_ afterPage: String?, completion: @escaping ((Result<TopRedditsModel, NetworkError>) -> Void)) {
        topRedditsService.fetchTopReddits(afterPage) { result in
            completion(result)
        }
    }
}
