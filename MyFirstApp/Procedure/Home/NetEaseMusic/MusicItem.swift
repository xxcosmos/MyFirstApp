//
//  MusicItem.swift
//  MyFirstApp
//
//  Created by 张啸宇 on 2020/3/4.
//  Copyright © 2020 xiaoyuu. All rights reserved.
//

import UIKit
import AVFoundation

@objc protocol MusicItemDelegate {
    @objc optional func musicItem(item: MusicItem, at second: TimeInterval, rate: CGFloat)
    @objc optional func musicItem(item: MusicItem, status: AVPlayerItem.Status)
}

class MusicItem: AVPlayerItem {
    
    var delegate: MusicItemDelegate?
    
    var name: String
    var artistName: String
    var coverURL: String
    var audioURL: String
    
    lazy var bufferSecond: TimeInterval =  {
        let timeRange = self.loadedTimeRanges.first?.timeRangeValue
        return CMTimeGetSeconds(timeRange!.start) + CMTimeGetSeconds(timeRange!.duration)
    }()
    
    lazy var durationSecond = CMTimeGetSeconds(self.duration)
    
    
    init(asset: AVAsset, automaticallyLoadedAssetKeys: [String]?, name: String, artistName:String, coverURL:String,audioURL:String){
        self.name = name
        self.artistName = artistName
        self.coverURL = coverURL
        self.audioURL = audioURL
        super.init(asset: asset, automaticallyLoadedAssetKeys: automaticallyLoadedAssetKeys)
        
        self.addObserver(self, forKeyPath: "status", options: .new, context: nil)
        self.addObserver(self, forKeyPath: "loadedTimeRanges", options: .new, context: nil)
        self.addObserver(self, forKeyPath: "playbackBufferEmpty", options: .new, context: nil)
        self.addObserver(self, forKeyPath: "playbackLikelyToKeepUp", options: .new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let delegate = self.delegate else {return}
        guard let path = keyPath else { return }
        if path.elementsEqual("status") {
            delegate.musicItem?(item: self, status: self.status)
        } else if path.elementsEqual("loadedTimeRanges"){
           delegate.musicItem?(item: self, at: self.bufferSecond, rate: CGFloat(self.bufferSecond / self.durationSecond))
        } else if path.elementsEqual("playbackBufferEmpty"){
            print("缓冲不足暂停")
        } else if path.elementsEqual("playbackLikelyToKeepUp"){
            print("可以播放了")
        }
        
        
    }
    
}

