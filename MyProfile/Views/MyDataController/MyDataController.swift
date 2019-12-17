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
        
        configureNavigationBar()
        self.navigationItem.title = "My Data"
        
        self.collectionView.alpha = 0
        UIView.animate(withDuration: 1) {
            self.collectionView.alpha = 1
        }
        
        let defaults = UserDefaults.standard
        if !defaults.bool(forKey: "isUserRegistered") {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false, completion: nil)
        }
        
        for _ in 1...5 {
            let numberOfCharacters = arc4random_uniform(UInt32(ipsum.count)) + 1
            randomIpsums.append(Int(numberOfCharacters))
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        cell.icon.image = UIImage(named: titles[indexPath.row])
        cell.title.text = titles[indexPath.row]
        let text = ipsum.prefix(randomIpsums[indexPath.row])
        cell.details.text = text.description
        cell.view.layer.cornerRadius = 12
        cell.detailsLabelWidth.constant = self.view.frame.width - 100
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toProfile", sender: nil)
    }
    
    func configureNavigationBar() {
        if let navigationBar = self.navigationController?.navigationBar {
            let gradient = CAGradientLayer()
            var bounds = navigationBar.bounds
            bounds.size.height += UIApplication.shared.statusBarFrame.size.height
            gradient.frame = bounds
            gradient.colors = [UIColor.red.cgColor, UIColor.blue.cgColor]
            gradient.startPoint = CGPoint(x: 0, y: 0)
            gradient.endPoint = CGPoint(x: 1, y: 0)

            if let image = gradient.image() {
                navigationBar.setBackgroundImage(image, for: UIBarMetrics.default)
            }
            navigationBar.tintColor = .white
            navigationBar.isTranslucent = true
            let font:UIFont = UIFont.boldSystemFont(ofSize: 25)
            let navbarTitleAtt = [
                NSAttributedString.Key.font:font,
                NSAttributedString.Key.foregroundColor: UIColor.white
            ]
            navigationBar.titleTextAttributes = navbarTitleAtt
        }
    }
    
    
}
