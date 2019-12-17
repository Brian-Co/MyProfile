//
//  UINavigationBar+Extensions.swift
//  MyProfile
//
//  Created by Brian Corrieri on 17/12/2019.
//  Copyright © 2019 FairTrip. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationBar {
    
    func configure() {
        let gradient = CAGradientLayer()
        var bounds = self.bounds
        bounds.size.height += UIApplication.shared.statusBarFrame.size.height
        gradient.frame = bounds
        gradient.colors = [UIColor.red.cgColor, UIColor.blue.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 0)
        
        if let image = gradient.image() {
            self.setBackgroundImage(image, for: UIBarMetrics.default)
        }
        self.tintColor = .white
        self.isTranslucent = true
        let font:UIFont = UIFont.boldSystemFont(ofSize: 25)
        let navbarTitleAtt = [
            NSAttributedString.Key.font:font,
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        self.titleTextAttributes = navbarTitleAtt
    }
    
}
