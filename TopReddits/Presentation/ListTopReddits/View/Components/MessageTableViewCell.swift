//
//  MessageTableViewCell.swift
//  TopReddits
//
//  Created by Arthur Givigir on 20/11/22.
//

import UIKit

final class MessageTableViewCell: UITableViewCell {
    
    private var message: RedditMessage?
    
    private lazy var contentStackView: UIStackView = buildStackView(spacing: .small)
    private lazy var headerStackView = buildStackView(spacing: .minimum)
    
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
    
    func setup(with message: RedditMessage) {
        self.message = message
        setupViewCell()
    }
}

private extension MessageTableViewCell {
    func setupViewCell() {
        buildContent()
        setupContent()
        configureConstraints()
    }

    func buildContent() {
        backgroundColor = .backgroundSeconday
        
        titleLabel.text = message?.title
        authorLabel.text = message?.author
        subredditLabel.text = message?.subredditName
        contentImageView.load(message?.thumbnail)
    }
    
    func setupContent() {
        headerStackView.addArrangedSubviews(
            subredditLabel,
            authorLabel
        )
        
        contentStackView.addArrangedSubviews(
            headerStackView,
            titleLabel,
            contentImageView
        )
        contentView.addSubview(contentStackView)
    }
    
    func configureConstraints() {
        let layoutMarginsGuide = contentView.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            contentStackView.leftAnchor.constraint(equalTo: layoutMarginsGuide.leftAnchor, constant: Space.small.rawValue),
            contentStackView.rightAnchor.constraint(equalTo: layoutMarginsGuide.rightAnchor, constant: -Space.small.rawValue),
            contentStackView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: Space.small.rawValue),
            contentStackView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor, constant: -Space.small.rawValue),
        ])
        
        if let width = message?.thumbnailWidth, let height = message?.thumbnailHeight {
            NSLayoutConstraint.activate([
                contentImageView.widthAnchor.constraint(equalToConstant: CGFloat(width)),
                contentImageView.heightAnchor.constraint(equalToConstant: CGFloat(height)),
            ])
        }
    }
}
