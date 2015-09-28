//
//  AudioRecorder.swift
//  PitchPerfect
//
//  Created by Iovanna Popova on 28.09.15.
//  Copyright © 2015 Iovanna Popova. All rights reserved.
//

import Foundation
import AVFoundation

let audioFileURL : NSURL = {
    let fm = NSFileManager.defaultManager()
    let documentDirectory = fm.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    return documentDirectory.URLByAppendingPathComponent("recording.caf")
}()

let recordSettings : [String : AnyObject] = [
    AVEncoderAudioQualityKey: AVAudioQuality.Min.rawValue,
    AVEncoderBitRateKey: 16,
    AVNumberOfChannelsKey: 2,
    AVSampleRateKey: 44100.0
]

class AudioRecorder {
    
    var recorder : AVAudioRecorder!
    
    init(){
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try recorder = AVAudioRecorder(URL: audioFileURL, settings: recordSettings)
            recorder.prepareToRecord()
        }
        catch _ {
            
        }
    }
    
    func start() {
        recorder.record()
    }
    
    func pause() {
        recorder.pause()
    }
    
    func stop() {
        recorder.stop()
    }
}
