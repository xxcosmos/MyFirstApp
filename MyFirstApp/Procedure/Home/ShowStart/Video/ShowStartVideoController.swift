//
//  ShowStartVideoController.swift
//  MyFirstApp
//
//  Created by 张啸宇 on 2020/3/4.
//  Copyright © 2020 xiaoyuu. All rights reserved.
//

import UIKit

class ShowStartVideoController: XYBaseViewController {

    private lazy var videoModel = ShowStartVideoViewModel()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: ScreenWidth * 0.9, height: ScreenHeight/2)
        let view = UICollectionView(frame: SafeBounds, collectionViewLayout: layout)
        view.delegate = self
        view.dataSource = self
        view.register(cellType: ShowStartVideoCoverView.self)
        view.backgroundColor = .white
        view.uHead = URefreshHeader{[weak self] in self?.getVideo(isHead: true)}
        view.uFoot = URefreshAutoFooter{[weak self] in self?.getVideo(isHead: false)}
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "演出视频"
        self.view.addSubview(collectionView)
        self.collectionView.uHead.beginRefreshing()
    }
    
    func getVideo(isHead: Bool){
        videoModel.getVideoListBlock = { [unowned self] in
            self.collectionView.reloadData()
            if isHead {
                self.collectionView.uHead.endRefreshing()
            } else {
                self.collectionView.uFoot.endRefreshing()
            }
        }
        
        videoModel.getData(isReload: isHead)
    }
    

}

extension ShowStartVideoController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return videoModel.videoList.count

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: ShowStartVideoCoverView.self)
        
        cell.videoModel = videoModel.videoList[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let videoCell = cell as? ShowStartVideoCoverView else {return}
        videoCell.removeVideo()
    }
    
    
}
