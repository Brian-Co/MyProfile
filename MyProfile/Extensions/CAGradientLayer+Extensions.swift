//
//  CAGradientLayer+Extensions.swift
//  MyProfile
//
//  Created by Brian Corrieri on 17/12/2019.
//  Copyright © 2019 FairTrip. All rights reserved.
//

import Foundation
import UIKit


extension CAGradientLayer {
    
    func image() -> UIImage? {
        var gradientImage: UIImage?
        UIGraphicsBeginImageContext(self.frame.size)
        if let context = UIGraphicsGetCurrentContext() {
            self.render(in: context)
            gradientImage = UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch)
        }
        UIGraphicsEndImageContext()
        return gradientImage
    }
    
}
