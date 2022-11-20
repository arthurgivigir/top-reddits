//
//  TopRedditsUseCase.swift
//  TopReddits
//
//  Created by Arthur Givigir on 20/11/22.
//

import Foundation

protocol TopRedditsUseCase {
    func fecthTopReddits(reloadData: Bool, completion: @escaping (Result<[RedditMessage], NetworkError>) -> Void)
}

final class DefaultTopRedditsUseCase: TopRedditsUseCase {
    private let topRedditsRepository: TopRedditsRepository
    private var afterPage: String?
    
    init(topRedditsRepository: TopRedditsRepository = DefaultTopRedditsRepository()) {
        self.topRedditsRepository = topRedditsRepository
    }
    
    func fecthTopReddits(reloadData: Bool, completion: @escaping (Result<[RedditMessage], NetworkError>) -> Void) {
        if reloadData {
            afterPage = nil
        }
        
        topRedditsRepository.fetchTopReddits(afterPage) { [weak self] result in
            switch result {
            case .success(let model):
                self?.afterPage = model.data.after
                completion(.success(model.toEntity))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
