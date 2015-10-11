//
//  RecordingControllerTests.swift
//  PitchPerfect
//
//  Created by Iovanna Popova on 11.10.15.
//  Copyright © 2015 Iovanna Popova. All rights reserved.
//

import XCTest

class RecordingUISpy: RecordingUI {
    var viewModel : RecordSoundsViewController.ViewModel =
        RecordSoundsViewController.ViewModel(buttonTitle: RecordButtonTitle.Record,stopButtonHidden: true)
}

class RecordingControllerTests: XCTestCase {
    let recordingUISpy = RecordingUISpy()
    let controller = RecordingController()
    
    override func setUp() {
        controller.UI = recordingUISpy
    }
    
    func test_defaultStateIsIdle() {
        XCTAssertEqual(controller.state, RecordingState.Idle)
        XCTAssertEqual(controller.UI?.viewModel.stopButtonHidden, true)
    }
    
    func test_whenRecordingStarted_stateIsActive() {
        controller.recordingStarted()
        XCTAssertEqual(controller.state, RecordingState.Active)
        XCTAssertEqual(controller.UI?.viewModel.stopButtonHidden, false)
        XCTAssertEqual(controller.UI?.viewModel.buttonTitle, RecordButtonTitle.Recording)
    }
    
    func test_whenRecordingPaused_stateIsPaused() {
        controller.recordingStarted()
        controller.recordingStarted()
        XCTAssertEqual(controller.state, RecordingState.Paused)
        XCTAssertEqual(controller.UI?.viewModel.stopButtonHidden, false)
        XCTAssertEqual(controller.UI?.viewModel.buttonTitle, RecordButtonTitle.Record)
    }
    
    func test_whenRecordingStartedAfterPause_stateIsActive() {
        controller.recordingStarted()
        controller.recordingStarted()
        controller.recordingStarted()
        XCTAssertEqual(controller.state, RecordingState.Active)
        XCTAssertEqual(controller.UI?.viewModel.stopButtonHidden, false)
        XCTAssertEqual(controller.UI?.viewModel.buttonTitle, RecordButtonTitle.Recording)
    }
    
    func test_whenRecordingStoped_stateIsIdle() {
        controller.recordingStarted()
        controller.recordingStoped()
        XCTAssertEqual(controller.state, RecordingState.Idle)
        XCTAssertEqual(controller.UI?.viewModel.stopButtonHidden, true)
    }
    
}
