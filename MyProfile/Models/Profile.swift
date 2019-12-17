//
//  Profile.swift
//  MyProfile
//
//  Created by Brian Corrieri on 17/12/2019.
//  Copyright © 2019 FairTrip. All rights reserved.
//

import Foundation

struct Profile: Codable {
    let username: String
    let email: String
    let adress: adress
    let profileCompletion: Int
    
    struct adress: Codable {
        let street: String
        let city: String
    }
}
