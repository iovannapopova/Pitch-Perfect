//
//  RecordingController.swift
//  PitchPerfect
//
//  Created by Iovanna Popova on 28.09.15.
//  Copyright © 2015 Iovanna Popova. All rights reserved.
//

import Foundation

protocol RecordingUI : class {
    var viewModel : RecordSoundsViewController.ViewModel { get set }
}

protocol RecordingStateObserver{
    func recordingStarted()
    func recordingStoped()
}

enum RecordingState{
    case Idle
    case Active
    case Paused
}

enum RecordButtonTitle : String {
    case Recording = "Recording"
    case Record = "Record!"
}

class RecordingController : RecordingStateObserver {
    weak var UI : RecordingUI?
    var state : RecordingState = .Idle {
        didSet {
            switch state {
            case .Idle :
                recorder.stop()
            case .Active :
                recorder.start()
            case .Paused :
                recorder.pause()
            }
        }
    }
    let recorder = AudioRecorder()
    
    func recordingStarted() {
        switch state {
        case .Idle :
            state = .Active
            UI?.viewModel = RecordSoundsViewController.ViewModel(buttonTitle: RecordButtonTitle.Recording, stopButtonHidden: false)
        case .Active :
            state = .Paused
            UI?.viewModel = RecordSoundsViewController.ViewModel(buttonTitle: RecordButtonTitle.Record, stopButtonHidden: false)
        case .Paused :
            state = .Active
            UI?.viewModel = RecordSoundsViewController.ViewModel(buttonTitle: RecordButtonTitle.Recording, stopButtonHidden: false)
        }
    }
    
    func recordingStoped() {
        precondition(state != .Idle)
        UI?.viewModel = RecordSoundsViewController.ViewModel(buttonTitle: RecordButtonTitle.Record, stopButtonHidden: true)
        state = .Idle
    }
    
}
