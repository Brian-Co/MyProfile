//
//  String+Extensions.swift
//  MyProfile
//
//  Created by Brian Corrieri on 17/12/2019.
//  Copyright © 2019 FairTrip. All rights reserved.
//

import Foundation
import CryptoKit

extension String {
    
    func hashString() -> String {
        let inputData = Data(self.utf8)
        let hashed = SHA256.hash(data: inputData)
        let hashString = hashed.compactMap { String(format: "%02x", $0) }.joined()
        return hashString
    }
    
    func isValidEmail() -> String? {
        let email = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        if emailPred.evaluate(with: email) {
            return email
        } else {
            return nil
        }
    }
    
    func isValidPassword() -> String? {
        let password = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        if (password.rangeOfCharacter(from: CharacterSet.uppercaseLetters) == nil) || (password.rangeOfCharacter(from: CharacterSet.decimalDigits) == nil) || password.count < 10 {
            return nil
        } else {
            return password
        }
    }
    
}
