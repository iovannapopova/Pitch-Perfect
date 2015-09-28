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
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 100, height: 100)
        
        collectionView = UICollectionView(frame: CGRect(x: 30, y: 30, width: view.bounds.size.width - 60, height: 320), collectionViewLayout: layout)
        collectionView.backgroundColor = .whiteColor()
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        collectionView.registerClass(AudioEffectCollectionViewCell.self, forCellWithReuseIdentifier: "AudioEffectCellID")
        
        view.addSubview(collectionView)
    }
    
    override func viewWillLayoutSubviews() {
        
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
