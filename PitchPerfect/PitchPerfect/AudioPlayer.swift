//
//  AudioPlayer.swift
//  PitchPerfect
//
//  Created by Iovanna Popova on 28.09.15.
//  Copyright © 2015 Iovanna Popova. All rights reserved.
//

import Foundation
import AVFoundation

enum AudioEffect {
    case Fast
    case Slow
    case Low
    case High
}

class AudioPlayer {
    
    let engine = AVAudioEngine()
    let player = AVAudioPlayerNode()
    var buffer : AVAudioPCMBuffer!
    let effectAudioUnit = AVAudioUnitTimePitch()
    var currentEffect : AudioEffect!
    
    init(fileURL : NSURL) {
        do {
            let audioFile = try AVAudioFile(forReading: fileURL)
            buffer = AVAudioPCMBuffer(PCMFormat: audioFile.processingFormat, frameCapacity: AVAudioFrameCount(audioFile.length))
            try audioFile.readIntoBuffer(buffer)
        }
        catch _ {
            
        }
        engine.attachNode(player)
        engine.attachNode(effectAudioUnit)
        engine.connect(player, to: effectAudioUnit, format: buffer.format)
        engine.connect(effectAudioUnit, to: engine.mainMixerNode, format: buffer.format)
    }
    
    func playWithEffect(effect : AudioEffect) {
        currentEffect = effect
        switch effect {
        case .Fast :
            effectAudioUnit.pitch = 1.0
            effectAudioUnit.rate = 2.0
        case .Slow :
            effectAudioUnit.pitch = 1.0
            effectAudioUnit.rate = 0.5
        case .Low :
            effectAudioUnit.pitch = -1200.0
            effectAudioUnit.rate = 1.0
        case .High :
            effectAudioUnit.pitch = 1200.0
            effectAudioUnit.rate = 1.0
        }
        player.scheduleBuffer(buffer, completionHandler: nil)
        engine.prepare()
        do {
            try engine.start()
        }
        catch _ {
            
        }
        player.play()
    }
    
    func play() {
        playWithEffect(currentEffect)
    }
    
    func stop() {
        player.stop()
    }

}
