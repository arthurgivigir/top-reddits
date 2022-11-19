//
//  DefaultTopRedditsRepository.swift
//  TopReddits
//
//  Created by Arthur Givigir on 19/11/22.
//

import Foundation

final class DefaultTopRedditsRepository: TopRedditsRepository {
    
    private let topRedditsService: TopRedditsService
    
    init(topRedditsService: TopRedditsService) {
        self.topRedditsService = topRedditsService
    }
    
    func fecthTopReddits(completion: @escaping (Result<TopRedditsModel, NetworkError>) -> Void) {
        topRedditsService.fetchTopReddits { result in
            completion(result)
        }
    }
}
