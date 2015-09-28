//
//  CollectionViewDataSource.swift
//  PitchPerfect
//
//  Created by Iovanna Popova on 27.09.15.
//  Copyright © 2015 Iovanna Popova. All rights reserved.
//

import Foundation
import UIKit

class CollectionViewDataSource : NSObject, UICollectionViewDataSource{
    
    var array : NSArray = []

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("AudioEffectCellID", forIndexPath: indexPath) as! AudioEffectCollectionViewCell
        cell.imageView.image = UIImage(named: array[indexPath.row] as! String)
        return cell
    }
    
}
