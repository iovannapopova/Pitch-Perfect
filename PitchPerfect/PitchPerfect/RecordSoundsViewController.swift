//
//  PPRecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Iovanna Popova on 26.09.15.
//  Copyright © 2015 Iovanna Popova. All rights reserved.
//

import UIKit

class RecordSoundsViewController: UIViewController, RecordingUI {
    
    struct ViewModel {
        let buttonTitle : String
        let stopButtonHidden : Bool
    }
    
    var recordButton : UIButton!
    var stopButton : UIButton!
    
    let observer : RecordingStateObserver
    
    var viewModel : ViewModel = ViewModel(buttonTitle: "Record!", stopButtonHidden: true) {
        didSet {
            updateView()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        let controller = RecordingController()
        observer = controller
        super.init(coder: aDecoder)
        controller.UI = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        recordButton = UIButton()
        recordButton.setImage(UIImage(named: "microphone2x-iphone"), forState: .Normal)
        recordButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        recordButton.titleEdgeInsets = UIEdgeInsets(top: 200, left: -200, bottom: 0, right: 0)
        recordButton.setTitleColor(UIColor(red: 33.0/225.0, green: 73.0/255.0, blue: 111.0/255.0, alpha: 1.0), forState: .Normal)
        recordButton.addTarget(self, action: "recordButtonTapped:", forControlEvents:.TouchUpInside)
        view.addSubview(recordButton)
        
        stopButton = UIButton()
        stopButton.setImage(UIImage(named: "stop2x-iphone"), forState: .Normal)
        stopButton.addTarget(self, action: "stopButtonTapped:", forControlEvents: .TouchUpInside)
        view.addSubview(stopButton)
        
        updateView()
    }

    override func viewWillLayoutSubviews() {
        let recButtonWidth : CGFloat = 200.0
        let recButtonHeight : CGFloat = 250.0
        recordButton.frame = CGRect(x: view.bounds.midX - recButtonWidth / 2, y: view.bounds.midY - recButtonHeight / 2, width: recButtonWidth, height: recButtonHeight)
        stopButton.frame = CGRect(x: 0, y: recordButton.frame.maxY, width: 50, height: 50)
        stopButton.center = CGPointMake(recordButton.center.x, stopButton.center.y)
    }
    
    func updateView() {
        recordButton.setTitle(viewModel.buttonTitle, forState: .Normal)
        stopButton.hidden = viewModel.stopButtonHidden
    }
    
    func recordButtonTapped(sender:UIButton!)
    {
        observer.recordingStarted()
    }
    
    func stopButtonTapped(sender:UIButton!){
        observer.recordingStoped()
        let playSoundsViewController = PlaySoundsViewController()
        navigationController?.pushViewController(playSoundsViewController, animated: true)
    }

}

