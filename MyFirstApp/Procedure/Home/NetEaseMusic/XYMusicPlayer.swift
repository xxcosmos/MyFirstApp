//
//  XYMusicPlayer.swift
//  MyFirstApp
//
//  Created by 张啸宇 on 2020/3/4.
//  Copyright © 2020 xiaoyuu. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

enum XYMusicPlayerMode {
    case Loop
    case One
    case Shuffle
}

@objc protocol XYMusicPlayerDelegate {
    @objc optional func xYMusicPlayer(_ player: XYMusicPlayer, playingAt item: MusicItem)
    @objc optional func xYMusicPlayer(_ player: XYMusicPlayer, pausedAt item: MusicItem)
    @objc optional func xYMusicPlayer(_ player: XYMusicPlayer, loadingAt item: MusicItem)
    @objc optional func xYMusicPlayer(_ player: XYMusicPlayer, FinishAt item: MusicItem)
    @objc optional func xYMusicPlayer(_ player: XYMusicPlayer, nextSong item: MusicItem)
    @objc optional func xYMusicPlayer(_ player: XYMusicPlayer, preSong item: MusicItem)
    @objc optional func xYMusicPlayer(_ player: XYMusicPlayer, currentSecond: TimeInterval,bufferSecond: TimeInterval, durationSecond: TimeInterval)
}

class XYMusicPlayer: AVPlayer {
    var delegate: XYMusicPlayerDelegate?
    
    var playlist: [MusicItem]
    
    var playMode: XYMusicPlayerMode = .Loop
    var playedStack = Stack<MusicItem>(capacity: 10)
    var currentMusicItem: MusicItem? {
        return self.playlist.first
    }
    var currentSecond: TimeInterval {
        return CMTimeGetSeconds(self.currentTime() )
    }
    
    init(playlist: [MusicItem]) {
        self.playlist = playlist
        super.init()
        
        self.addObserver(self, forKeyPath: "timeControlStatus", options: .new, context: nil)
//        self.addPeriodicTimeObserver(forInterval: .zero, queue: nil, using: .)
//        NotificationCenter.default.addObserver(self, selector: <#T##Selector#>, name: <#T##NSNotification.Name?#>, object: <#T##Any?#>)
    }
    
    override func play() {
        guard playlist.count > 0 else { return }
        super.play()
    }
    
    func replay(){
        guard playlist.count > 0 else { return }
        self.seek(to: .zero)
        self.play()
//        self.delegat
    }
    @objc func next() {
        guard playlist.count > 1 else { return }
        self.pause()
        self.seek(to: .zero)
        self.playedStack.push(item: playlist.removeFirst())
        self.replaceCurrentItem(with: playlist.first)
        self.play()
        self.delegate?.xYMusicPlayer?(self, nextSong: self.currentMusicItem!)
    }
    
    @objc func prev() {
        guard playedStack.count > 0 else { return }
        self.pause()
        self.seek(to: .zero)
        self.playlist.insert(playedStack.pop()!, at: 0)
        self.replaceCurrentItem(with: playlist.first)
        self.play()
        
        self.delegate?.xYMusicPlayer?(self, preSong: currentMusicItem!)
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard keyPath?.elementsEqual("timeControlStatus") ?? false else {return}
        guard let item = currentMusicItem else {return}
        
        switch self.timeControlStatus {
        case .playing:
            self.delegate?.xYMusicPlayer?(self, playingAt: item)
        case .paused:
            self.delegate?.xYMusicPlayer?(self, pausedAt: item)
        case .waitingToPlayAtSpecifiedRate:
            self.delegate?.xYMusicPlayer?(self, loadingAt: item)
   
        @unknown default:
            fatalError("Error")
        }
    }
    func shufflePlaylist() {
        playlist.shuffle()
    }
    
    func handleDeviceChangedNotifacation(_ notification: Notification) {
//        if let reason = notification.userInfo?[AVAudioSessionRouteChangeReasonKey] as? AVAudioSession.RouteChangeReason, reason == AVAudioSession.RouteChangeReason.oldDeviceUnavailable {
//
//        }
        
        
    }
    
    func handleDidPlayToEndNotifacation() {
        guard let item = currentMusicItem else {return}
        self.delegate?.xYMusicPlayer?(self, FinishAt: item)
        switch playMode {
        case .One:
            self.replay()
        default:
            self.next()
        }
        
    }
    
    //MARK: 设置系统播放器
    
    func configNowPlayingInfoCenter() {
        var nowPlayingInfo = [String: Any]()
        nowPlayingInfo[MPMediaItemPropertyTitle] = currentMusicItem?.name
        nowPlayingInfo[MPMediaItemPropertyArtist] = currentMusicItem?.artistName
        nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = currentItem?.duration
        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = currentSecond
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }
    
    func handleRemoteControlEvent() {
        let commandCenter = MPRemoteCommandCenter.shared()
        commandCenter.playCommand.addTarget(self, action: #selector(play))
        commandCenter.pauseCommand.addTarget(self, action: #selector(pause))
        commandCenter.previousTrackCommand.addTarget(self, action: #selector(prev))
        commandCenter.nextTrackCommand.addTarget(self, action: #selector(next))
        
        commandCenter.togglePlayPauseCommand.addTarget {[unowned self] (status) -> MPRemoteCommandHandlerStatus in
            if self.timeControlStatus == .playing {
                self.pause()
            } else {
                self.play()
            }
            return .success
        }
    }
    
}
