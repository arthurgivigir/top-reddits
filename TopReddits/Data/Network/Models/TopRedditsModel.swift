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
    let after: String?
    let reddits: [RedditMessageModel]
    
    enum CodingKeys: String, CodingKey {
        case after
        case quantityItems = "dist"
        case reddits = "children"
    }
}

extension TopRedditsModel {
    var toEntity: [RedditMessage] {
        data.reddits.map {
            let message = $0.message
            let postHint = PostHint.build(rawValue: message.postHint)
            return RedditMessage(
                author: message.author,
                postHint: postHint,
                title: message.title,
                url: message.url,
                thumbnail: message.thumbnail,
                thumbnailHeight: message.thumbnailHeight,
                thumbnailWidth: message.thumbnailWidth,
                text: message.text,
                created: message.created,
                subredditName: message.subredditName
            )
        }
    }
}
