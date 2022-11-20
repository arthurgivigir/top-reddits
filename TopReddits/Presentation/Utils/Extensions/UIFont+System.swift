//
//  UIFont+System.swift
//  TopReddits
//
//  Created by Arthur Givigir on 20/11/22.
//

import UIKit

extension UIFont {
    enum TopRedditSizeFont: CGFloat {
        case title = 16
        case subtitle = 12
        case description = 10
    }
    
    static func appFont(_ size: TopRedditSizeFont) -> UIFont {
        .systemFont(ofSize: size.rawValue)
    }
    
    static func appFont(_ size: TopRedditSizeFont, weight: Weight) -> UIFont {
        .systemFont(ofSize: size.rawValue, weight: weight)
    }
}
