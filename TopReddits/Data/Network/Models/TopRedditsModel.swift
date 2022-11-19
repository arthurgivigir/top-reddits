//
//  TopRedditsModel.swift
//  TopReddits
//
//  Created by Arthur Givigir on 19/11/22.
//

import Foundation

struct TopRedditsModel: Decodable {
    let data: TopRedditsPageModel
}

struct TopRedditsPageModel: Decodable {
    let quantityItems: Int
    let reddits: [RedditMessageModel]
    
    enum CodingKeys: String, CodingKey {
        case quantityItems = "dist"
        case reddits = "children"
    }
}
