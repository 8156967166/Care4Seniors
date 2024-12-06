//
//  GradientView.swift
//  Care4Senior
//
//  Created by Aneesha on 21/02/24.
//

import Foundation

import UIKit

class GradientView: UIView {
    
    func setupGradient() {
        guard let gradientLayer = self.layer as? CAGradientLayer else { return }
        
        gradientLayer.colors = [UIColor.orange.cgColor, UIColor.white.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
    }
}

