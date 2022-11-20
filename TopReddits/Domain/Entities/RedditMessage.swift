//
//  RedditMessage.swift
//  TopReddits
//
//  Created by Arthur Givigir on 19/11/22.
//

import Foundation

struct RedditMessage {
    let author: String
    let postHint: String?
    let title: String
    let thumbnail: String?
    let thumbnailHeight: Float?
    let thumbnailWidth: Float?
    let text: String?
    let created: Int?
    let subredditName: String
}
