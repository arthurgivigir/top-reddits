//
//  ListTopRedditsViewController.swift
//  TopReddits
//
//  Created by Arthur Givigir on 09/11/22.
//

import Foundation
import UIKit

final class ListTopRedditsViewController: UIViewController {
    
    lazy var nextButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("Next", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        view.addSubview(nextButton)
        
        configureNavigationController()
        configureActions()
        configureConstraints()
    }
    
    private func configureNavigationController() {
        navigationItem.title = "Top Reddits"
    }
    
    private func configureActions() {
        nextButton.addTarget(self, action: #selector(callRedditDetails), for: .touchUpInside)
    }
    
    private func configureConstraints() {
        let horizontalConstraint = nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let verticalConstraint = nextButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint])
    }
    
    @objc private func callRedditDetails() {
        navigationController?.show(RedditDetailsViewController(), sender: self)
    }
    
}
