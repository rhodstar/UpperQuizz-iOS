//
//  UIView+RoudSelectedCorners.swift
//  UpperQuizz
//
//  Created by Rodrigo Francisco Pablo on 01/09/21.
//

import UIKit

class RoundedUIView: UIView {
    
    var customRadius: CGFloat = 10.0
    var customCorners: UIRectCorner = [.allCorners]
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: customCorners, cornerRadii: .init(width: customRadius, height: customRadius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask        
    }
}
