//
//  TopRedditsEndpoints.swift
//  TopReddits
//
//  Created by Arthur Givigir on 19/11/22.
//

import Foundation

enum TopRedditsEndpoints: String {
    case topReddits = "https://www.reddit.com/top.json"
    
    var url: URL? {
        switch self {
        case .topReddits:
            return URL(string: rawValue)
        }
    }
}
