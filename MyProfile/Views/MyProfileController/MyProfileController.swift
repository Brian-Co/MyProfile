//
//  MyProfileController.swift
//  MyProfile
//
//  Created by Brian Corrieri on 31/10/2019.
//  Copyright © 2019 FairTrip. All rights reserved.
//

import Foundation
import UIKit
import AdSupport

class MyProfileController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var street: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var buttonLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var profileCompletionView: ProfileCompletionView!
    @IBOutlet weak var separatorLine1: UIView!
    @IBOutlet weak var separatorLine2: UIView!
    
    private var viewModel: MyProfileControllerViewModel!
        
    lazy var pulseLayer: CAShapeLayer = {
        let pulseLayer = CAShapeLayer()
        pulseLayer.lineWidth = 7
        pulseLayer.strokeColor = UIColor.lightGray.cgColor
        pulseLayer.lineCap = .round
        pulseLayer.fillColor = UIColor.clear.cgColor
        return pulseLayer
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "My Profile"
        
        button.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        button.layer.cornerRadius = button.frame.height/2
        buttonLabel.text = "Profile visible, tap to hide"
        
        separatorLine1.layer.borderWidth = 1.0
        separatorLine1.layer.borderColor = UIColor.lightGray.cgColor
        separatorLine2.layer.borderWidth = 1.0
        separatorLine2.layer.borderColor = UIColor.lightGray.cgColor
        
        viewModel = MyProfileControllerViewModel(delegate: self)
        
    }
    
    override func viewDidLayoutSubviews() {
        setBackgroundViewLayer()
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        buttonAnimation()
        
        if viewModel.profile != nil {
            viewModel.changeStatus()
        }
        
//        let defaults = UserDefaults.standard
//        defaults.set(false, forKey: "isUserRegistered")
    }
    
}

extension MyProfileController: MyProfileControllerViewModelDelegate {
    
    func configureProfile(with profile: Profile) {
        username.text = profile.username
        email.text = profile.email
        profileCompletionView.animateProfileCompletion(profileCompletion: profile.profileCompletion)
        street.text = profile.adress.street
        city.text = profile.adress.city
    }
    
    func updateButton(_ isProfileVisible: Bool) {
        if !isProfileVisible {
            self.button.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            self.buttonLabel.text = "Profile hidden, tap to show"
        } else {
            self.button.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            self.buttonLabel.text = "Profile visible, tap to hide"
        }
        
    }
        
}

