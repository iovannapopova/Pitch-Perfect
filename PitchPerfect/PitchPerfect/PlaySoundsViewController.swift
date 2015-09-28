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
        view.backgroundColor = .yellowColor()
        dataSource = CollectionViewDataSource()
        dataSource.array = ["chipmunk2x-iphone","echo","fast2x-iphone","darthvader2x-iphone"]
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
        layout.itemSize = CGSize(width: 100, height: 100)
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 320), collectionViewLayout: layout)
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
            case 0 : player.playWithEffect(.High)
            case 1 : player.playWithEffect(.Low)
            case 2 : player.playWithEffect(.Fast)
            case 3 : player.playWithEffect(.Slow)
            default : break
        }
    }
    
}
