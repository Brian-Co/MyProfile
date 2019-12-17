//
//  CreateAccountViewModel.swift
//  MyProfile
//
//  Created by Brian Corrieri on 17/12/2019.
//  Copyright © 2019 FairTrip. All rights reserved.
//

import Foundation
import AdSupport


protocol CreateAccountViewModelDelegate: class {
    func showPopup(_ popup: Popups)
}

class CreateAccountViewModel {
    
    private weak var delegate: CreateAccountViewModelDelegate?
    
    init(delegate: CreateAccountViewModelDelegate) {
      self.delegate = delegate
    }
    
    let networking = Networking()
    let helper = HelperMethods()
    
    func createAccount(email: String, password: String, passwordConfirmation: String) {
        
        if let email = email.isValidEmail() {
            print("Email valid \(email)")
            
            if let password = password.isValidPassword() {
                print("password is \(password)")
                let confirmPasswordTrimmed = passwordConfirmation.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                
                if password == confirmPasswordTrimmed {
                    print("passwords match")
                    createAccountRequest(email: email, password: password)
                } else {
                    delegate?.showPopup(.passwordsDoNotMatch)
                }
            } else {
                print("password invalid")
                delegate?.showPopup(.invalidPassword)
            }
        } else {
            print("Email invalid")
            delegate?.showPopup(.invalidEmail)
        }
    }
    
    func createAccountRequest(email: String, password: String) {
        
        let IDManager = ASIdentifierManager.shared()
        let adID = IDManager.advertisingIdentifier.description
        print("adID \(IDManager.isAdvertisingTrackingEnabled) \(adID)")
        
        let account = Account(email: email.hashString(), uuid: helper.getUID(), password: password.hashString(), deviceId: adID)
        
        guard let uploadData = try? JSONEncoder().encode(account) else {
            return
        }
        print("uploadData" + String(data: uploadData, encoding: .utf8)!)
        
        networking.sendData(uploadData: uploadData, to: "https://lfdjdev.appconsent.io/register") { bool in
            if bool {
                let defaults = UserDefaults.standard
                defaults.set(true, forKey: "isUserRegistered")
                DispatchQueue.main.async {
                    self.delegate?.showPopup(.accountCreated)
                }
            } else {
                DispatchQueue.main.async {
                    self.delegate?.showPopup(.error)
                }
            }
        }
        
    }
    
    
}
