//
//  TopRedditsRepository.swift
//  TopReddits
//
//  Created by Arthur Givigir on 19/11/22.
//

import Foundation

protocol TopRedditsRepository {
    func fetchTopReddits(_ afterPage: String?, completion: @escaping((Result<TopRedditsModel, NetworkError>) -> Void))
}
