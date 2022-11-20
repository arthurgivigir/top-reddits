//
//  RedditMessageModel.swift
//  TopReddits
//
//  Created by Arthur Givigir on 19/11/22.
//

import Foundation

struct RedditMessageModel: Decodable {
    let message: RedditMessageDataModel
    
    enum CodingKeys: String, CodingKey {
        case message = "data"
    }
}

struct RedditMessageDataModel: Decodable {
    let author: String
    let postHint: String?
    let title: String
    let url: String?
    let thumbnail: String?
    let thumbnailHeight: Float?
    let thumbnailWidth: Float?
    let text: String?
    let created: Int?
    let subredditName: String
    
    enum CodingKeys: String, CodingKey {
        case author
        case postHint = "post_hint"
        case title
        case url
        case thumbnail
        case thumbnailHeight = "thumbnail_height"
        case thumbnailWidth = "thumbnail_width"
        case text = "selftext"
        case created = "created_utc"
        case subredditName = "subreddit_name_prefixed"
    }
}
