//
//  HelperMethods.swift
//  MyProfile
//
//  Created by Brian Corrieri on 31/10/2019.
//  Copyright © 2019 FairTrip. All rights reserved.
//

import Foundation
import CryptoKit

class HelperMethods {
        
    func getUID() -> String {
        let defaults = UserDefaults.standard
        if let UID = defaults.string(forKey: "UID") {
            return UID
        } else {
            let UID = UUID().uuidString
            defaults.set(UID, forKey: "UID")
            return UID
        }
    }
    
    func decodeJSONProfile(data: Data) -> Profile? {
        let decoder = JSONDecoder()
        if let profile = try? decoder.decode(Profile.self, from: data) {
            return profile
        } else {
            return nil
        }
    }
    
    
}
