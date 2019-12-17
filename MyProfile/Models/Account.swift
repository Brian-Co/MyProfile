//
//  Account.swift
//  MyProfile
//
//  Created by Brian Corrieri on 17/12/2019.
//  Copyright © 2019 FairTrip. All rights reserved.
//

import Foundation

struct Account: Codable {
    let email: String
    let uuid: String
    let password: String
    let deviceId: String
}
