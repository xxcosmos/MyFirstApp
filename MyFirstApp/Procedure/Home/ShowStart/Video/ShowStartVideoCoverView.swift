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
            avatarNameButton.kf.setImage(with: URL(string: model.avatar!), for: .normal)
            avatarNameButton.setTitle(model.authorName, for: .normal)
        }
    }
    
    private lazy var avatarNameButton = UIButton(type: .infoLight).then { (button) in
        button.imageView?.contentMode = .scaleAspectFit
        button.titleLabel?.font = .boldSystemFont(ofSize: 12)
        button.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        button.backgroundColor = .blue
        button.setTitleColor(.black, for: .normal)
    }
    
    private lazy var coverView = UIImageView().then { (view) in
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
    }
    
    private lazy var playButton = UIImageView().then { (view) in
        view.image = R.image.location()?.withTintColor(.white)
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
        self.addSubview(avatarNameButton)
        self.addSubview(coverView)
        coverView.addSubview(playButton)
        let width = self.frame.width
        avatarNameButton.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview()
            make.width.equalTo(width / 2)
            make.height.equalTo(50)
        }
        
        coverView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalTo(avatarNameButton.snp.bottom).offset(10)
            make.width.equalToSuperview()
            make.height.equalTo(width / 16 * 9)
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
