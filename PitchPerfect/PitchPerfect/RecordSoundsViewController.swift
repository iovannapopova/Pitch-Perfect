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
    
    struct Colors {
        static let recordTextColor = UIColor(red: 33.0/225.0, green: 73.0/255.0, blue: 111.0/255.0, alpha: 1.0)
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
    
    let recButtonImageSize : CGFloat = 100.0
    let recButtonHeight : CGFloat = 125.0
    let stopButtonImageSize: CGFloat = 50.0
    let stopButtonTopEdge: CGFloat = 10.0

    override func viewDidLoad() {
        super.viewDidLoad()
        recordButton = UIButton()
        recordButton.setImage(UIImage(named: "microphone2x-iphone"), forState: .Normal)
        recordButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: recButtonHeight - recButtonImageSize, right: 0)
        recordButton.titleEdgeInsets = UIEdgeInsets(top: recButtonImageSize, left: -2*recButtonImageSize, bottom: 0, right: 0)
        recordButton.setTitleColor(Colors.recordTextColor, forState: .Normal)
        recordButton.addTarget(self, action: "recordButtonTapped:", forControlEvents:.TouchUpInside)
        view.addSubview(recordButton)
        
        stopButton = UIButton()
        stopButton.setImage(UIImage(named: "stop2x-iphone"), forState: .Normal)
        stopButton.addTarget(self, action: "stopButtonTapped:", forControlEvents: .TouchUpInside)
        view.addSubview(stopButton)
        
        updateView()
    }

    override func viewWillLayoutSubviews() {
        recordButton.frame = CGRect(x: view.bounds.midX - recButtonImageSize / 2, y: view.bounds.midY - recButtonHeight / 2, width: recButtonImageSize, height: recButtonHeight)
        stopButton.frame = CGRect(x: 0, y: recordButton.frame.maxY + stopButtonTopEdge, width: stopButtonImageSize, height: stopButtonImageSize)
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

