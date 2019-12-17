//
//  ProfileRequest.swift
//  MyProfile
//
//  Created by Brian Corrieri on 17/12/2019.
//  Copyright © 2019 FairTrip. All rights reserved.
//

import Foundation

struct ProfileRequest: Codable {
    let email: String
    let uuid: String
    let status: Int
    let deviceId: String
    let timestamp: Int
}
