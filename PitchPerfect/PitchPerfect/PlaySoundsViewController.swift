//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Iovanna Popova on 26.09.15.
//  Copyright © 2015 Iovanna Popova. All rights reserved.
//

import Foundation
import UIKit

class PlaySoundsViewController : UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, PlayingUI {
    
    struct ViewModel {
        var stopButtonEnabled : Bool
    }
    
    let observer : PlayingStateObserver
    
    var collectionView : UICollectionView!
    var dataSource : CollectionViewDataSource!
    var stopButton : UIButton!
    let player = AudioPlayer(fileURL: audioFileURL)
    
    var viewModel : ViewModel = ViewModel(stopButtonEnabled: false){
        didSet {
            updateView()
        }
    }
    
    init() {
        let controller = PlayingController(audioPlayer: player)
        observer = controller
        super.init(nibName: nil, bundle: nil)
        controller.UI = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .whiteColor()
        dataSource = CollectionViewDataSource()
        dataSource.array = ["slow2x-iphone","fast2x-iphone","chipmunk2x-iphone","darthvader2x-iphone"]
        
        let layoutSectionInset : CGFloat = 10.0
        let itemSize : CGFloat = 100.0
        let edgeCollectionView: CGFloat = 30.0
        let heightCollectionView : CGFloat = 250.0
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: layoutSectionInset, left: layoutSectionInset, bottom: layoutSectionInset, right: layoutSectionInset)
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        
        collectionView = UICollectionView(frame: CGRect(x: edgeCollectionView, y: edgeCollectionView + 60, width: view.bounds.size.width - 2 * edgeCollectionView, height: heightCollectionView), collectionViewLayout: layout)
        collectionView.backgroundColor = .whiteColor()
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        collectionView.registerClass(AudioEffectCollectionViewCell.self, forCellWithReuseIdentifier: "AudioEffectCellID")
        
        stopButton = UIButton()
        stopButton.setImage(UIImage(named: "stop2x-iphone"), forState: .Normal)
        stopButton.addTarget(self, action: "stopButtonTapped:", forControlEvents: .TouchUpInside)
        view.addSubview(stopButton)
        view.addSubview(collectionView)
        updateView()
    }
    
    override func viewWillLayoutSubviews() {
        let playButtonSize : CGFloat = 50.0
        stopButton.frame = CGRectMake(self.view.bounds.size.width / 2 - playButtonSize / 2, self.collectionView.frame.maxY + 10.0, playButtonSize, playButtonSize)
    }
    
    func updateView() {
        stopButton.enabled = viewModel.stopButtonEnabled
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        observer.playingStoped()
        switch indexPath.item {
            case 0 : observer.playingStartWithEffect(.Slow)
            case 1 : observer.playingStartWithEffect(.Fast)
            case 2 : observer.playingStartWithEffect(.High)
            case 3 : observer.playingStartWithEffect(.Low)
            default : break
        }
    }
    
    func stopButtonTapped(sender:UIButton!)
    {
        observer.playingStoped()
    }
    
}
