//
//  RedditDetailsViewModel.swift
//  TopReddits
//
//  Created by Arthur Givigir on 20/11/22.
//

import Foundation
import UIKit

protocol RedditDetailsViewModelInput {
    func viewDidLoad()
}

protocol RedditDetailsViewModelOutput {
    var message: RedditMessage { get }
    
}

protocol RedditDetailsViewModel: RedditDetailsViewModelInput, RedditDetailsViewModelOutput {}

final class DefaultRedditDetailsViewModel: RedditDetailsViewModel {
    let message: RedditMessage
    
    init(message: RedditMessage) {
        self.message = message
    }
    
    func viewDidLoad() {
        
    }
}

private extension DefaultRedditDetailsViewModel {

    
}
