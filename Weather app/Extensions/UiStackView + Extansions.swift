//
//  UiStackView + Extansions.swift
//  Weather app
//
//  Created by Сергей Золотухин on 27.12.2021.
//

import UIKit

extension UIStackView {
    convenience init(arrangedSubViews: [UIView],
                     axis: NSLayoutConstraint.Axis,
                     spacing: CGFloat,
                     distribution: UIStackView.Distribution) {
        self.init(arrangedSubviews: arrangedSubViews)
        self.axis = axis
        self.spacing = spacing
        self.distribution = distribution
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
