//
//  MyDataController.swift
//  MyProfile
//
//  Created by Brian Corrieri on 31/10/2019.
//  Copyright © 2019 FairTrip. All rights reserved.
//

import Foundation
import UIKit

class MyDataController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let titles = ["My Profile", "My Data", "History", "Share", "Stats"]
    let ipsum = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    var randomIpsums = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        if !defaults.bool(forKey: "isUserRegistered") {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false, completion: nil)
        }
        
        if let navigationBar = self.navigationController?.navigationBar {
            navigationBar.configure()
        }
        self.navigationItem.title = "My Data"
        
        self.collectionView.alpha = 0
        UIView.animate(withDuration: 1) {
            self.collectionView.alpha = 1
        }
        
        for _ in 1...5 {
            let numberOfCharacters = arc4random_uniform(UInt32(ipsum.count)) + 1
            randomIpsums.append(Int(numberOfCharacters))
        }
        
    }
    
    
}
