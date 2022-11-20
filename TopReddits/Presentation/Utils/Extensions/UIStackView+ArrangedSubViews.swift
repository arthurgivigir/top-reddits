//
//  UIStackView+ArrangedSubViews.swift
//  TopReddits
//
//  Created by Arthur Givigir on 20/11/22.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        _ = views.map {
            addArrangedSubview($0)
        }
    }
}

extension UIView {
    func buildStackView(
        axis: NSLayoutConstraint.Axis = .vertical,
        distribution: UIStackView.Distribution = .fill,
        alignment: UIStackView.Alignment = .leading,
        spacing: Space = .minimum
    ) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = spacing.rawValue
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
    
    func buildStackView(
        _ views: UIView...,
        axis: NSLayoutConstraint.Axis = .vertical,
        distribution: UIStackView.Distribution = .fill,
        alignment: UIStackView.Alignment = .leading,
        spacing: Space = .minimum
    ) -> UIStackView {
        let stackView = buildStackView(
            axis: axis,
            distribution: distribution,
            alignment: alignment,
            spacing: spacing
        )
        _ = views.map {
            stackView.addArrangedSubview($0)
        }
        
        return stackView
    }
}
