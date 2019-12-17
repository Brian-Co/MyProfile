//
//  MyProfileControllerViewModel.swift
//  MyProfile
//
//  Created by Brian Corrieri on 17/12/2019.
//  Copyright © 2019 FairTrip. All rights reserved.
//

import Foundation
import AdSupport


protocol MyProfileControllerViewModelDelegate: class {
    func configureProfile(with profile: Profile)
    func updateButton(_ isProfileVisible: Bool)
}

class MyProfileControllerViewModel {
    
    private weak var delegate: MyProfileControllerViewModelDelegate?
    
    let networking = Networking()
    let helper = HelperMethods()
    
    var profile: Profile?
    var isProfileVisible = true
    
    init(delegate: MyProfileControllerViewModelDelegate) {
        self.delegate = delegate
        
        networking.getData(urlString: "https://lfdjdev.appconsent.io/user") { data in
            if let data = data {
                if let profile = self.helper.decodeJSONProfile(data: data) {
                    self.profile = profile
                    DispatchQueue.main.async {
                        self.delegate?.configureProfile(with: profile)
                    }
                    print("got profile \(profile)")
                }
            }
        }
    }
    
    func changeStatus() {
        let IDManager = ASIdentifierManager.shared()
        let adID = IDManager.advertisingIdentifier.description
        let timestamp = Int(NSDate().timeIntervalSince1970)
        let status = !isProfileVisible ? 1 : 0
        
        let profileRequest = ProfileRequest(email: profile!.email.hashString(), uuid: helper.getUID(), status: status, deviceId: adID, timestamp: timestamp)
        guard let uploadData = try? JSONEncoder().encode(profileRequest) else {
            return
        }
        print("uploadData" + String(data: uploadData, encoding: .utf8)!)
        
        networking.sendData(uploadData: uploadData, to: "https://lfdjdev.appconsent.io/status") { bool in
            if bool {
                DispatchQueue.main.async {
                    if self.isProfileVisible {
                        self.isProfileVisible = false
                        self.delegate?.updateButton(self.isProfileVisible)
                    } else {
                        self.isProfileVisible = true
                        self.delegate?.updateButton(self.isProfileVisible)
                    }
                }
            }
        }
        
    }
    
    
    
}

