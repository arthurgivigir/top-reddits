//
//  RedditMessage.swift
//  TopReddits
//
//  Created by Arthur Givigir on 19/11/22.
//

import Foundation

struct RedditMessage {
    let author: String
    let postHint: PostHint?
    let title: String
    let url: String?
    let thumbnail: String?
    let thumbnailHeight: Float?
    let thumbnailWidth: Float?
    let text: String?
    let created: Int?
    let subredditName: String
}

enum PostHint: String {
    case image
    case link
    case other
    
    static func build(rawValue: String?) -> PostHint {
        guard let rawValue = rawValue else { return .other }
        return PostHint(rawValue: rawValue) ?? .other
    }
}
