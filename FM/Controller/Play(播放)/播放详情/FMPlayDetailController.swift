//
//  FMPlayDetailController.swift
//  FM
//
//  Created by fengsong on 2020/5/11.
//  Copyright © 2020 fengsong. All rights reserved.
//

import UIKit


class FMPlayDetailController: UIViewController {

    private var albumId: Int = 0
    convenience init(albumId: Int = 0) {
        self.init()
        self.albumId = albumId
    }
    fileprivate let kNavBarBottom = WRNavigationBar.navBarBottom()
    //VM
    lazy var viewModel:FMPlayViewModel={
        return FMPlayViewModel()
    }()
    // - headerView
    private lazy var headerView:FMPlayDetailHeaderView = {
        let view = FMPlayDetailHeaderView.init(frame: CGRect(x:0, y:0, width:FMScreenWidth, height:240))
        view.backgroundColor = UIColor.white
        return view
    }()
    //
    private lazy var layout: LTLayout = {
        let layout = LTLayout()
        layout.isAverage = true
        layout.sliderWidth = 80
        layout.titleViewBgColor = UIColor.white
        layout.titleColor = UIColor(r: 178, g: 178, b: 178)
        layout.titleSelectColor = UIColor(r: 16, g: 16, b: 16)
        layout.bottomLineColor = UIColor.red
        layout.sliderHeight = 56
        /* 更多属性设置请参考 LTLayout 中 public 属性说明 */
        return layout
    }()
    private let oneVc = FMPlayDetailIntroController()
    private let twoVc = FMPlayController()
    private lazy var viewControllers: [UIViewController] = {
        return [oneVc, twoVc]
    }()
    
    private lazy var titles: [String] = {
        return ["简介", "节目"]
    }()
    private lazy var advancedManager: LTAdvancedManager = {
        let statusBarH = UIApplication.shared.statusBarFrame.size.height
        let advancedManager = LTAdvancedManager(frame: CGRect(x: 0, y: 0, width: FMScreenWidth, height: FMScreenHeight + FMNavBarHeight), viewControllers: viewControllers, titles: titles, currentViewController: self, layout: layout, headerViewHandle: {[weak self] in
            guard let strongSelf = self else { return UIView() }
            let headerView = strongSelf.headerView
            return headerView
        })
        /* 设置代理 监听滚动 */
        advancedManager.delegate = self
        /* 设置悬停位置 */
        advancedManager.hoverY = FMNavBarHeight
        /* 点击切换滚动过程动画 */
        //        advancedManager.isClickScrollAnimation = true
        /* 代码设置滚动到第几个位置 */
        //        advancedManager.scrollToIndex(index: viewControllers.count - 1)
        return advancedManager
    }()
    //Mark: - 导航栏右边按钮
      private lazy var rightBarButton1:UIButton = {
          let button = UIButton.init(type: UIButton.ButtonType.custom)
          button.frame = CGRect(x:0, y:0, width:30, height: 30)
          button.setImage(UIImage(named: "icon_more_h_30x31_"), for: UIControl.State.normal)
          button.addTarget(self, action: #selector(rightBarButtonClick1), for: UIControl.Event.touchUpInside)
          return button
      }()
      
      //Mark: - 导航栏右边按钮
      private lazy var rightBarButton2:UIButton = {
          let button = UIButton.init(type: UIButton.ButtonType.custom)
          button.frame = CGRect(x:0, y:0, width:30, height: 30)
          button.setImage(UIImage(named: "icon_share_h_30x30_"), for: UIControl.State.normal)
          button.addTarget(self, action: #selector(rightBarButtonClick2), for: UIControl.Event.touchUpInside)
          return button
      }()
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.navBarBackgroundAlpha = 0
        view.backgroundColor = UIColor.white
       
        view.addSubview(advancedManager)
        advancedManagerConfig()
        let rightBarButtonItem1:UIBarButtonItem = UIBarButtonItem.init(customView: rightBarButton1)
         let rightBarButtonItem2:UIBarButtonItem = UIBarButtonItem.init(customView: rightBarButton2)
         self.navigationItem.rightBarButtonItems = [rightBarButtonItem1, rightBarButtonItem2]
        
        setUpLoadData()
    }
    
    func setUpLoadData() {
        
        self.viewModel.getPlayDetailData(albumId: self.albumId)
        viewModel.playDetailDataBlock = {[weak self] in
            
            // 传值给headerView
            self?.headerView.playDetailAlbumModel = self!.viewModel.playDetailAlbum
            // 传值给简介界面
            self?.oneVc.playDetailAlbumModel = self!.viewModel.playDetailAlbum
            self?.oneVc.playDetailUserModel = self!.viewModel.playDetailUser
        }
        
    }
    // - 导航栏左边消息点击事件
    @objc func rightBarButtonClick1() {
        
    }
    
    // - 导航栏左边消息点击事件
    @objc func rightBarButtonClick2() {
        
    }
}

extension FMPlayDetailController : LTAdvancedScrollViewDelegate {
    // 具体使用请参考以下
    private func advancedManagerConfig() {
        // 选中事件
        advancedManager.advancedDidSelectIndexHandle = {
            print("选中了 -> \($0)")
        }
    }
    
    func glt_scrollViewOffsetY(_ offsetY: CGFloat) {
        if (offsetY > 5)
        {
            let alpha = offsetY / CGFloat(kNavBarBottom)
            navBarBackgroundAlpha = alpha
            self.rightBarButton1.setImage(UIImage(named: "icon_more_n_30x31_"), for: UIControl.State.normal)
            self.rightBarButton2.setImage(UIImage(named: "icon_share_n_30x30_"), for: UIControl.State.normal)
            
            self.navigationController!.navigationBar.tintColor = UIColor.init(r: 226/255, g: 108/255, b: 77/255)
        }else{
            navBarBackgroundAlpha = 0
            self.rightBarButton1.setImage(UIImage(named: "icon_more_h_30x31_"), for: UIControl.State.normal)
            self.rightBarButton2.setImage(UIImage(named: "icon_share_h_30x30_"), for: UIControl.State.normal)
            
            self.navigationController!.navigationBar.tintColor = UIColor.orange
        }
    }
}
