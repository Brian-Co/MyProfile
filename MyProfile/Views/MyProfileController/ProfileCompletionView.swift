//
//  ProfileCompletionView.swift
//  MyProfile
//
//  Created by Brian Corrieri on 01/11/2019.
//  Copyright © 2019 FairTrip. All rights reserved.
//

import Foundation
import UIKit

class ProfileCompletionView: UIView {
    
    private var profileCompletion = 0
    
    private lazy var profileCompletionLabel: UILabel = {
           let profileCompletionLabel = UILabel(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: bounds.width, height: bounds.height)))
           profileCompletionLabel.font = UIFont.systemFont(ofSize: 32, weight: .heavy)
           profileCompletionLabel.textAlignment = NSTextAlignment.center
           return profileCompletionLabel
       }()
    
    private lazy var foregroundLayer: CAShapeLayer = {
        let foregroundLayer = CAShapeLayer()
        foregroundLayer.lineWidth = 20
        foregroundLayer.strokeColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1).cgColor
        foregroundLayer.lineCap = .round
        foregroundLayer.fillColor = UIColor.clear.cgColor
        foregroundLayer.strokeEnd = 0
        foregroundLayer.frame = bounds
        return foregroundLayer
    }()
    
    private lazy var backgroundLayer: CAShapeLayer = {
        let backgroundLayer = CAShapeLayer()
        backgroundLayer.lineWidth = 20
        backgroundLayer.strokeColor = UIColor.lightGray.cgColor
        backgroundLayer.lineCap = .round
        backgroundLayer.fillColor = UIColor.clear.cgColor
        backgroundLayer.frame = bounds
        return backgroundLayer
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        loadLayers()
    }
    
    private func loadLayers() {
        
        let centerPoint = CGPoint(x: frame.width/2 , y: frame.height/2)
        let profileCompletion: CGFloat = CGFloat(self.profileCompletion)/100
        let circularPath = UIBezierPath(arcCenter: centerPoint, radius: bounds.width / 2 - 20, startAngle: -CGFloat.pi/2,
                                        endAngle: (2 * CGFloat.pi * profileCompletion) - CGFloat.pi/2, clockwise: true)
        
        backgroundLayer.path = circularPath.cgPath
        layer.addSublayer(backgroundLayer)
        
        foregroundLayer.path = circularPath.cgPath
        layer.addSublayer(foregroundLayer)
        
        addSubview(profileCompletionLabel)
        
    }
    
    private func beginAnimation() {
        loadLayers()
        animateForegroundLayer()
    }
    
    private func animateForegroundLayer() {
        let foregroundAnimation = CABasicAnimation(keyPath: "strokeEnd")
        foregroundAnimation.fromValue = 0
        foregroundAnimation.toValue = 1
        foregroundAnimation.duration = CFTimeInterval(1)
        foregroundAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        foregroundAnimation.fillMode = CAMediaTimingFillMode.forwards
        foregroundAnimation.isRemovedOnCompletion = false
        
        foregroundLayer.add(foregroundAnimation, forKey: "foregroundAnimation")
    }
    
    func animateProfileCompletion(profileCompletion: Int) {
        self.profileCompletion = profileCompletion
        profileCompletionLabel.text = "\(profileCompletion)%"
        beginAnimation()
    }
    
}


