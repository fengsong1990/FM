//
//  FMPlayController.swift
//  FM
//
//  Created by fengsong on 2020/4/27.
//  Copyright © 2020 fengsong. All rights reserved.
//

import UIKit

private let FMPlayCellIdentifier           =  "FMPlayCellIdentifier"
private let FMPlayAnchorCellIdentifier     =  "FMPlayAnchorCellIdentifier"

class FMPlayController: UIViewController {
    
    // 外部传值请求接口
    private var albumId :Int = 0
    private var trackUid:Int = 0
    private var uid:Int = 0
    convenience init(albumId: Int = 0, trackUid: Int = 0, uid:Int = 0) {
        self.init()
        self.albumId = albumId
        self.trackUid = trackUid
        self.uid = uid
    }
    
    lazy var tableView : UITableView = {
        let tableView = UITableView.init(frame: CGRect(x:0, y:0, width: FMScreenWidth, height:FMScreenHeight), style: UITableView.Style.grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        // 注册头尾视图
        //tableView.register(FMHomeVipHeaderView.self, forHeaderFooterViewReuseIdentifier: FMHomeVipHeaderViewIdIdentifier)
        //tableView.register(FMHomeVipFooterView.self, forHeaderFooterViewReuseIdentifier: FMHomeVipFooterViewIdIdentifier)
        //注册Cell
        tableView.register(FMPlayCell.self, forCellReuseIdentifier: FMPlayCellIdentifier)
        //作者
        tableView.register(FMPlayAnchorCell.self, forCellReuseIdentifier: FMPlayAnchorCellIdentifier)
        
        
        return tableView
    }()
    
    lazy var viewModel: FMPlayViewModel = {
        return FMPlayViewModel(albumId:self.albumId,trackUid:self.trackUid, uid:self.uid)
    }()
    
    // - 导航栏左边按钮
    private lazy var leftBarButton:UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.frame = CGRect(x:0, y:0, width:30, height: 30)
        button.setImage(UIImage(named: "playpage_icon_down_black_30x30_"), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(leftBarButtonClick), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.red
        
        
//        if #available(iOS 11.0, *) {
//            tableView.contentInsetAdjustmentBehavior = .never
//        } else {
//            automaticallyAdjustsScrollViewInsets = false
//        }
        //navBarBackgroundAlpha = 0
        //self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: leftBarButton)
        self.view.addSubview(self.tableView)
        
        setUpUIData()
        
        
    }
    
    func setUpUIData() {
        viewModel.playBlock = { [unowned self] in
            // 数据加载完成，刷新数据
            self.tableView.reloadData()
        }
        viewModel.getPlayDataDataSource()
    }
    
    //    // 控制向上滚动显示导航栏标题和左右按钮
    //    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    //        let offsetY = scrollView.contentOffset.y
    //        if (offsetY > 0)
    //        {
    //            navBarBackgroundAlpha = 1
    //        }else{
    //            navBarBackgroundAlpha = 0
    //        }
    //    }
    
    
    
    // - 导航栏左边消息点击事件
    @objc func leftBarButtonClick() {
        //self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
}
extension FMPlayController:UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return FMScreenHeight * 0.7
        }else if indexPath.section == 1{
            let introHeight = FMPlayAnchorCell.getCellHeight(model: self.viewModel.userInfo)
            return introHeight
        }
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch (indexPath.section) {
        case 0:
            let cell: FMPlayCell = tableView.dequeueReusableCell(withIdentifier: FMPlayCellIdentifier, for: indexPath) as! FMPlayCell
            cell.playTrackInfo = self.viewModel.playTrackInfo
            return cell
        case 1:
            let cell: FMPlayAnchorCell = tableView.dequeueReusableCell(withIdentifier: FMPlayAnchorCellIdentifier, for: indexPath) as! FMPlayAnchorCell
            cell.userInfo = self.viewModel.userInfo
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    //    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //
    //    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let view = UIView()
//        view.backgroundColor = FMDownColor
//        return view
//    }
    
}
