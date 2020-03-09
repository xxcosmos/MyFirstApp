//
//  ShowStartVideoCoverView.swift
//  MyFirstApp
//
//  Created by 张啸宇 on 2020/3/4.
//  Copyright © 2020 xiaoyuu. All rights reserved.
//

import UIKit
import Kingfisher
import AVFoundation

class ShowStartVideoCoverView: XYBaseCollectionCell {
    
    var videoModel: ShowStartVideoModel? {
        didSet{
            guard let model = self.videoModel else { return }
            coverView.kf.setImage(with: URL(string: model.photo!))
            avatarView.kf.setImage(with: URL(string: model.avatar!))
            titleLabel.text = model.authorName
            mediaLabel.text = model.mediaName
         
        }
    }
    private lazy var avatarView = UIImageView().then { (view) in
        view.contentMode = .scaleAspectFit
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
    }
    private lazy var titleLabel = UILabel().then { (label) in
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        label.textAlignment = .left
    }
    
    private lazy var mediaLabel = UILabel().then { (label) in
        label.font = .systemFont(ofSize: 13)
        label.textColor = .black
    }
    
    private lazy var coverView = UIImageView().then { (view) in
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
    }
    
    private lazy var playButton = UIImageView().then { (view) in
        view.image = R.image.play()?.withTintColor(.white)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapToPlay))
        self.addGestureRecognizer(tapGesture)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupUI() {
        self.addSubview(avatarView)
        self.addSubview(titleLabel)
        self.addSubview(coverView)
        self.addSubview(mediaLabel)
        coverView.addSubview(playButton)
        
        let width = self.frame.width
        avatarView.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview()
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(avatarView.snp.right).offset(5)
            make.top.bottom.equalTo(avatarView)
            make.width.equalTo(100)
        }
        coverView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalTo(avatarView.snp.bottom).offset(10)
            make.width.equalToSuperview()
            make.height.equalTo(width / 16 * 9)
        }
        mediaLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.top.equalTo(coverView.snp.bottom).offset(5)
            make.height.equalTo(20)
            make.width.equalToSuperview()
        }
        
        playButton.snp.makeConstraints { (make) in
            make.width.height.equalTo(50)
            make.center.equalTo(coverView)
        }
        
    }
}

extension ShowStartVideoCoverView {
    
    @objc func tapToPlay(){
        guard let url = videoModel?.videoUrl else {return}
        XYVideoPlayer.shared.play(url: url, in: coverView)
    }
    
    func removeVideo() {
        XYVideoPlayer.shared.stop()
    }
    
}
