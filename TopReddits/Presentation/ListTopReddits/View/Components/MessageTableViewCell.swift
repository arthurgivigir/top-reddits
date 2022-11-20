//
//  MessageTableViewCell.swift
//  TopReddits
//
//  Created by Arthur Givigir on 20/11/22.
//

import UIKit

final class MessageTableViewCell: UITableViewCell {
    
    private var message: RedditMessage?
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var contentImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .blue
        label.font = .systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var subredditLabel: UILabel = {
        let label = UILabel()
        label.textColor = .blue
        label.font = .systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .blue
        label.font = .systemFont(ofSize: 12)
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
        titleLabel.text = message?.title
        authorLabel.text = message?.author
        subredditLabel.text = message?.subredditName
        contentImageView.load(message?.thumbnail)
    }
    
    func setupContent() {
        contentStackView.addArrangedSubviews(
            authorLabel,
            subredditLabel,
            titleLabel,
            contentImageView
        )
        contentView.addSubview(contentStackView)
    }
    
    func configureConstraints() {
        let layoutMarginsGuide = contentView.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            contentStackView.leftAnchor.constraint(equalTo: layoutMarginsGuide.leftAnchor, constant: 8),
            contentStackView.rightAnchor.constraint(equalTo: layoutMarginsGuide.rightAnchor, constant: 8),
            contentStackView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 0),
            contentStackView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor, constant: 0),
        ])
        
        if let width = message?.thumbnailWidth, let height = message?.thumbnailHeight {
            NSLayoutConstraint.activate([
                contentImageView.widthAnchor.constraint(equalToConstant: CGFloat(width)),
                contentImageView.heightAnchor.constraint(equalToConstant: CGFloat(height)),
            ])
        }
    }
}
