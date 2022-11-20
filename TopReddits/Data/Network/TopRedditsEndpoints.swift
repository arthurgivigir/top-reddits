//
//  TopRedditsEndpoints.swift
//  TopReddits
//
//  Created by Arthur Givigir on 19/11/22.
//

import Foundation

enum TopRedditsEndpoints: String {
    case topReddits = "https://www.reddit.com/top.json?limit=25"
    
    var url: URL? {
        switch self {
        case .topReddits:
            return URL(string: rawValue)
        }
    }
}


enum TopRedditsAPIEndpoints {
    case topReddits(_ afterPage: String?)
    
    var url: URL? {
        let baseURL = "https://www.reddit.com/top.json?limit=25%@"
        
        if case .topReddits(let afterPage?) = self {
            return getUrl(baseURL, afterPage: afterPage)
        }
        
        return getUrl(baseURL)
    }
    
    private func getUrl(_ baseURL: String, afterPage: String? = nil) -> URL? {
        guard let afterPage = afterPage else {
            let baseUrlWithoutAfterPage: String = String(format: baseURL, "")
            return URL(string: baseUrlWithoutAfterPage)
        }
        
        let baseUrlWithAfterPage: String = String(format: baseURL, "&after=\(afterPage)")
        return URL(string: baseUrlWithAfterPage)
    }
}
