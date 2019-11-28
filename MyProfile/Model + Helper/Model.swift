//
//  Model.swift
//  Chandago Test
//
//  Created by Brian Corrieri on 30/10/2019.
//  Copyright © 2019 FairTrip. All rights reserved.
//

import Foundation

struct Account: Codable {
    let email: String
    let uuid: String
    let password: String
    let deviceId: String
}

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

struct ProfileRequest: Codable {
    let email: String
    let uuid: String
    let status: Int
    let deviceId: String
    let timestamp: Int
}



