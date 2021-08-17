//
//  UIViewExtension.swift
//  UpperQuizz
//
//  Created by Emanuel Flores Martínez on 16/08/21.
//

import UIKit

extension UIView {
    func cardStyle(color: UIColor = .black, radius: CGFloat = 4.0, offsetY: CGFloat = 3.0) {
        self.layer.cornerRadius = radius
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: offsetY)
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = 0.15
        self.layer.masksToBounds = false
    }
}
