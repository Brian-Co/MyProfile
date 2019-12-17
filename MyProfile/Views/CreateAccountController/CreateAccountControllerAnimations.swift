//
//  CreateAccountControllerAnimations.swift
//  MyProfile
//
//  Created by Brian Corrieri on 17/12/2019.
//  Copyright © 2019 FairTrip. All rights reserved.
//

import Foundation
import UIKit

extension ViewController: CAAnimationDelegate {

        func createGradientView() {
            
            gradientSet.append([colorOne, colorTwo])
            gradientSet.append([colorTwo, colorThree])
            gradientSet.append([colorThree, colorOne])
            
            gradient.frame = self.view.bounds
            gradient.colors = gradientSet[currentGradient]
            gradient.startPoint = CGPoint(x:0, y:0)
            gradient.endPoint = CGPoint(x:1, y:1)
            gradient.drawsAsynchronously = true
            
            self.view.layer.insertSublayer(gradient, at: 0)
            
            animateGradient()
        }
        
        func animateGradient() {
            if currentGradient < gradientSet.count - 1 {
                currentGradient += 1
            } else {
                currentGradient = 0
            }
            
            let gradientChangeAnimation = CABasicAnimation(keyPath: "colors")
            gradientChangeAnimation.duration = 3.0
            gradientChangeAnimation.toValue = gradientSet[currentGradient]
            gradientChangeAnimation.fillMode = CAMediaTimingFillMode.forwards
            gradientChangeAnimation.isRemovedOnCompletion = false
            gradientChangeAnimation.delegate = self
            gradient.add(gradientChangeAnimation, forKey: "gradientChangeAnimation")
        }
        
        func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
                gradient.colors = gradientSet[currentGradient]
                animateGradient()
        }
    
}
