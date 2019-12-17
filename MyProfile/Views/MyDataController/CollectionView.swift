//
//  CollectionView.swift
//  MyProfile
//
//  Created by Brian Corrieri on 17/12/2019.
//  Copyright © 2019 FairTrip. All rights reserved.
//

import Foundation
import UIKit

extension MyDataController {

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

}
