//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Iovanna Popova on 26.09.15.
//  Copyright © 2015 Iovanna Popova. All rights reserved.
//

import Foundation
import UIKit

class PlaySoundsViewController : UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var collectionView : UICollectionView!
    var dataSource : CollectionViewDataSource!
    let player = AudioPlayer(fileURL: audioFileURL)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .whiteColor()
        dataSource = CollectionViewDataSource()
        dataSource.array = ["slow2x-iphone","fast2x-iphone","chipmunk2x-iphone","darthvader2x-iphone"]
        
        let layoutSectionInset : CGFloat = 10.0
        let itemSize : CGFloat = 100.0
        let edgeCollectionView: CGFloat = 30.0
        let heightCollectionView : CGFloat = 320.0
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: layoutSectionInset, left: layoutSectionInset, bottom: layoutSectionInset, right: layoutSectionInset)
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        
        collectionView = UICollectionView(frame: CGRect(x: edgeCollectionView, y: edgeCollectionView, width: view.bounds.size.width - 2 * edgeCollectionView, height: heightCollectionView), collectionViewLayout: layout)
        collectionView.backgroundColor = .whiteColor()
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        collectionView.registerClass(AudioEffectCollectionViewCell.self, forCellWithReuseIdentifier: "AudioEffectCellID")
        
        view.addSubview(collectionView)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        player.stop()
        switch indexPath.item {
            case 0 : player.playWithEffect(.Slow)
            case 1 : player.playWithEffect(.Fast)
            case 2 : player.playWithEffect(.High)
            case 3 : player.playWithEffect(.Low)
            default : break
        }
    }
    
}
