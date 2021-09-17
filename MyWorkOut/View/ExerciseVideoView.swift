//
//  ExerciseVideoView.swift
//  MyWorkOut
//
//  Created by Kittisak Boonchalee on 14/9/21.
//

import UIKit
import AVFoundation

class ExerciseVideoView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override static var layerClass: AnyClass {
        AVPlayerLayer.self
    }
    
    var player: AVPlayer? {
        get {
            playerLayer.player
        }
        set {
            playerLayer.player = newValue
            playerLayer.videoGravity = .resizeAspect
        }
    }
    
    private var playerLayer: AVPlayerLayer{
        layer as! AVPlayerLayer
        
    }
}
