//
//  RecordedAudio.swift
//  PitchPerfect
//
//  Created by Iovanna Popova on 26.09.15.
//  Copyright © 2015 Iovanna Popova. All rights reserved.
//

import Foundation

class RecordedAudio : NSObject {
    let title : NSString
    let filePathURL : NSURL
    
    init(title: String, filePathURL: NSURL) {
        self.title = title
        self.filePathURL = filePathURL
        super.init ()
    }
}
