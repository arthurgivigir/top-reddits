//
//  TopRedditsModel.swift
//  TopReddits
//
//  Created by Arthur Givigir on 19/11/22.
//

import Foundation

struct TopRedditsModel: Decodable {
    let quantityItems: Int
    let reddits: [RedditMessageModel]
    
    enum CodingKeys: String, CodingKey {
        case quantityItems = "dist"
        case reddits = "children"
    }
    
    enum PageCodingKeys: String, CodingKey {
        case actionPage = "data"
    }
    
    init(from decoder: Decoder) throws {
        let pageContainer = try decoder.container(keyedBy: PageCodingKeys.self)
        let page = try pageContainer.decode(TopRedditsModel.self, forKey: .actionPage)
        
        self.quantityItems = page.quantityItems
        self.reddits = page.reddits
    }
}

struct RedditMessageModel: Decodable {
    let author: String
    let postHint: String
    let title: String
    let thumbnail: String?
    let thumbnailHeight: Float?
    let thumbnailWidth: Float?
    let text: String?
    let created: String
    let subredditName: String
    
    enum CodingKeys: String, CodingKey {
        case author
        case postHint
        case title
        case thumbnail
        case thumbnailHeight
        case thumbnailWidth
        case text = "selftext"
        case created = "created_utc"
        case subredditName = "subreddit_name_prefixed"
    }
}
