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

extension TopRedditsModel {
    var toEntity: [RedditMessage] {
        data.reddits.map {
            let message = $0.message
            return RedditMessage(
                author: message.author,
                postHint: message.postHint,
                title: message.title,
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
