//
//  LoadingViewController.swift
//  TopReddits
//
//  Created by Arthur Givigir on 20/11/22.
//

import UIKit

final class LoadingViewController: UIViewController {
    private lazy var loadingActivityIndicator: UIActivityIndicatorView = {
        let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .medium)
        activityIndicator.color = .fontColorPrimary
        activityIndicator.startAnimating()
        activityIndicator.autoresizingMask = [
            .flexibleLeftMargin, .flexibleRightMargin,
            .flexibleTopMargin, .flexibleBottomMargin
        ]
        return activityIndicator
    }()
    
    private lazy var blurEffectView: UIVisualEffectView = {
        let effect = UIBlurEffect(style: .dark)
        let effectView = UIVisualEffectView(effect: effect)
        effectView.alpha = 0.8
        effectView.autoresizingMask = [
            .flexibleWidth, .flexibleHeight
        ]
        
        return effectView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
}

// MARK: - Private functions
private extension LoadingViewController {
    func setupViews()  {
        view.backgroundColor = .backgroundPrimary?.withAlphaComponent(0.5)
        
        blurEffectView.frame = self.view.bounds
        view.insertSubview(blurEffectView, at: 0)
        
        loadingActivityIndicator.center = CGPoint(
            x: view.bounds.midX,
            y: view.bounds.midY
        )
        
        view.addSubview(loadingActivityIndicator)
    }
}
