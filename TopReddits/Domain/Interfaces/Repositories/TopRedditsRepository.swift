//
//  TopRedditsRepository.swift
//  TopReddits
//
//  Created by Arthur Givigir on 19/11/22.
//

import Foundation

protocol TopRedditsRepository {
    func fecthTopReddits(completion: @escaping (Result<[RedditMessage], NetworkError>) -> Void)
}
