//
//  RedditDetailsViewController.swift
//  TopReddits
//
//  Created by Arthur Givigir on 09/11/22.
//

import Foundation
import UIKit

final class RedditDetailsViewController: UIViewController {
    private let viewModel: RedditDetailsViewModel
    
    private lazy var contentStackView: UIStackView = buildStackView(spacing: .medium)
    private lazy var headerStackView = buildStackView(spacing: .minimum)
    private lazy var background: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .backgroundSeconday
        view.layer.cornerRadius = Space.medium.rawValue
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var contentImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .fontColorSeconday
        label.font = .appFont(.subtitle, weight: .thin)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var urlLabel: UILabel = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(openLink))
        let label = UILabel()
        label.textColor = .fontColorSeconday
        label.font = .appFont(.subtitle, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(tap)
        return label
    }()
    
    private lazy var subredditLabel: UILabel = {
        let label = UILabel()
        label.textColor = .fontColorSeconday
        label.font = .appFont(.subtitle, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .fontColorPrimary
        label.font = .appFont(.title, weight: .heavy)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    init(viewModel: RedditDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationController()
        buildContent()
        setupContent()
        configureConstraints()
    }
}
private extension RedditDetailsViewController {
    func configureNavigationController() {
        navigationItem.title = "Details"
    }
    
    func buildContent() {
        view.backgroundColor = .backgroundPrimary
        
        titleLabel.text = viewModel.message.title
        authorLabel.text = viewModel.message.author
        subredditLabel.text = viewModel.message.subredditName
        
        if viewModel.message.postHint == .image {
            contentImageView.load(viewModel.message.url)
        } else if viewModel.message.postHint == .link {
            guard let url = viewModel.message.url else { return }
            let textRange = NSMakeRange(0, url.count)
            let atributtedText = NSMutableAttributedString(string: url)
            atributtedText.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: textRange)
            urlLabel.attributedText = atributtedText
        }
    }
    
    func setupContent() {
        headerStackView.addArrangedSubviews(
            subredditLabel,
            authorLabel
        )
        
        contentStackView.addArrangedSubviews(
            headerStackView,
            titleLabel,
            contentImageView,
            urlLabel
        )
        
        contentStackView.backgroundColor = .backgroundSeconday
        
        background.addSubview(contentStackView)
        scrollView.addSubview(background)
        view.addSubview(scrollView)
    }
    
    @objc
    func openLink(_ sender: AnyObject?) {
        viewModel.openLink()
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
        
        let scrollContentGuide = scrollView.contentLayoutGuide
        let scrollFrameGuide = scrollView.frameLayoutGuide
        
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: background.topAnchor, constant: Space.medium.rawValue),
            contentStackView.bottomAnchor.constraint(equalTo: background.bottomAnchor, constant: -Space.medium.rawValue),
            contentStackView.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: Space.medium.rawValue),
            contentStackView.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -Space.medium.rawValue),
            background.topAnchor.constraint(equalTo: scrollContentGuide.topAnchor),
            background.bottomAnchor.constraint(equalTo: scrollContentGuide.bottomAnchor),
            background.leadingAnchor.constraint(equalTo: scrollFrameGuide.leadingAnchor, constant: Space.medium.rawValue),
            background.trailingAnchor.constraint(equalTo: scrollFrameGuide.trailingAnchor, constant: -Space.medium.rawValue),
        ])
        
        if viewModel.message.postHint == .image {
            NSLayoutConstraint.activate([
                contentImageView.widthAnchor.constraint(equalTo: contentStackView.widthAnchor),
                contentImageView.centerXAnchor.constraint(equalTo: contentStackView.centerXAnchor),
                contentImageView.heightAnchor.constraint(equalToConstant: 300),
            ])
        }
    }
}
