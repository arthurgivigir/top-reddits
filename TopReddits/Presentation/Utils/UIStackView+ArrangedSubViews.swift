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
