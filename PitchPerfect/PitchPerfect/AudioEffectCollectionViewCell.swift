//
//  AudioEffectCollectionViewCell.swift
//  PitchPerfect
//
//  Created by Iovanna Popova on 27.09.15.
//  Copyright © 2015 Iovanna Popova. All rights reserved.
//

import Foundation
import UIKit

class AudioEffectCollectionViewCell : UICollectionViewCell {
    
    var imageView : UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView = UIImageView()
        contentView.addSubview(imageView)
    }
    
    override func layoutSubviews() {
        imageView.frame = contentView.bounds
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
