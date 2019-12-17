//
//  MyProfileControllerAnimations.swift
//  MyProfile
//
//  Created by Brian Corrieri on 17/12/2019.
//  Copyright © 2019 FairTrip. All rights reserved.
//

import Foundation
import UIKit

extension MyProfileController: CAAnimationDelegate {
    
    func buttonAnimation() {
        let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .medium)
        impactFeedbackgenerator.impactOccurred()
        
        pulseLayer.frame = button.bounds
        let centerPoint = CGPoint(x: button.frame.width/2 , y: button.frame.height/2)
        let circularPath = UIBezierPath(arcCenter: centerPoint, radius: button.bounds.width / 2, startAngle: -CGFloat.pi/2, endAngle: 2 * CGFloat.pi - CGFloat.pi/2, clockwise: true)
        pulseLayer.path = circularPath.cgPath
        button.layer.addSublayer(pulseLayer)
        animatePulseLayer()
    }
    
    func animatePulseLayer() {
        
        let pulseAnimation = CABasicAnimation(keyPath: "transform.scale")
        pulseAnimation.fromValue = 1.0
        pulseAnimation.toValue = 1.1
        
        let pulseOpacityAnimation = CABasicAnimation(keyPath: "opacity")
        pulseOpacityAnimation.fromValue = 0.7
        pulseOpacityAnimation.toValue = 0.0
        
        let groupedAnimation = CAAnimationGroup()
        groupedAnimation.animations = [pulseAnimation, pulseOpacityAnimation]
        groupedAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        groupedAnimation.duration = 0.4
        groupedAnimation.delegate = self
        
        pulseLayer.add(groupedAnimation, forKey: "pulseAnimation")
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        DispatchQueue.main.async {
            self.pulseLayer.removeFromSuperlayer()
        }
    }
    
    func setBackgroundViewLayer() {
        let gradient = CAGradientLayer()
        gradient.frame = backgroundView.bounds
        gradient.colors = [UIColor.yellow.cgColor, UIColor.orange.cgColor]
        gradient.startPoint = CGPoint(x:0, y:0)
        gradient.endPoint = CGPoint(x:1, y:1)
        gradient.drawsAsynchronously = true
        gradient.cornerRadius = 12
        backgroundView.layer.insertSublayer(gradient, at: 0)
        backgroundView.layer.cornerRadius = 12
    }
    
}
