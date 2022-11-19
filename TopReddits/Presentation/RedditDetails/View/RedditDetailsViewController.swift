//
//  RedditDetailsViewController.swift
//  TopReddits
//
//  Created by Arthur Givigir on 09/11/22.
//

import Foundation
import UIKit

final class RedditDetailsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        
        configureNavigationController()
    }
    
    private func configureNavigationController() {
        navigationItem.title = "Reddit Details"
    }
}
