//
//  XYVideoPlayer.swift
//  MyFirstApp
//
//  Created by 张啸宇 on 2020/3/4.
//  Copyright © 2020 xiaoyuu. All rights reserved.
//

import UIKit
import AVFoundation

class XYVideoPlayer: NSObject {
    static let shared = XYVideoPlayer()
    
    private var player: AVPlayer?
    private var videoItem: AVPlayerItem?
    private var layer: AVPlayerLayer?
    
    private var videoStatus = 0
    private var url = ""
    
    private func load(url: String, in view: UIView){
        self.stop()

        self.url = url
        videoItem = AVPlayerItem(url: URL(string: url)!)
        player = AVPlayer(playerItem: videoItem)
        layer = AVPlayerLayer(player: player)
        layer!.frame = view.bounds
        view.layer.addSublayer(layer!)
    
        NotificationCenter.default.addObserver(self, selector: #selector(videoDidPlayToEndTime), name: .AVPlayerItemDidPlayToEndTime, object: nil)
        videoItem?.addObserver(self, forKeyPath: "status", options: .new, context: nil)
        videoItem?.addObserver(self, forKeyPath: "loadedTimeRanges", options: .new, context: nil)
        player?.addPeriodicTimeObserver(forInterval: CMTime(value: 1, timescale: 1), queue: .main, using: { (time) in
            print("\(CMTimeGetSeconds(time))")
        })
       
        
    }
    
    func stop(){
        NotificationCenter.default.removeObserver(self)
        layer?.removeFromSuperlayer()
        videoStatus = 0
        url = ""
        player = nil
        layer = nil
        videoItem = nil
    }
    
    func play(url: String, in view: UIView){
        if self.url != url {
            videoStatus = 0
            self.url = url
        }
        switch videoStatus {
        case 0:
            load(url: url, in: view)
            videoStatus = 1
        case 1:
            player?.pause()
            videoStatus = 2
        case 2:
            player?.play()
            videoStatus = 1
        default:
            print("error")
        }
    }
    

    
    @objc func videoDidPlayToEndTime(){
        player?.seek(to: CMTime(value: 0, timescale: 1))
        player?.play()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        switch keyPath {
        case "status":
            // 加载完成
            if let value = change?[NSKeyValueChangeKey.newKey] as? Int, value == AVPlayerItem.Status.readyToPlay.rawValue{
                player?.play()
            } else {
                
            }
        case "loadedTimeRanges":
            print("loadedTimeRanges")
     
        default:
            print("error")
        }
        
    }
}
