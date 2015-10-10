//
//  PlayingController.swift
//  PitchPerfect
//
//  Created by Iovanna Popova on 10.10.15.
//  Copyright © 2015 Iovanna Popova. All rights reserved.
//

import Foundation

protocol PlayingUI : class {
    var viewModel : PlaySoundsViewController.ViewModel { get set }
}

protocol PlayingStateObserver{
    func playingStartWithEffect(effect : AudioEffect)
    func playingStoped()
}

class PlayingController : PlayingStateObserver{
    weak var UI : PlayingUI?
    let player : AudioPlayer
        
    init(audioPlayer : AudioPlayer) {
        player = audioPlayer
    }
    
    func playingStartWithEffect(effect : AudioEffect) {
        UI?.viewModel = PlaySoundsViewController.ViewModel(stopButtonEnabled: true)
        player.playWithEffect(effect)
    }
    
    func playingStoped() {
        UI?.viewModel = PlaySoundsViewController.ViewModel(stopButtonEnabled: false)
        player.stop()
    }
}