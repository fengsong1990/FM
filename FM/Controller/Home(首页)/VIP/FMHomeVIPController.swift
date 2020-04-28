//
//  FMHomeVIPController.swift
//  FM
//
//  Created by fengsong on 2020/4/28.
//  Copyright © 2020 fengsong. All rights reserved.
//

import UIKit

///Section
let FMHomeVipSectionBanner    = 0   // 滚动图片section

//Cell
let FMHomeVipBannerCellID     = "FMHomeVipBannerCell"


class FMHomeVIPController: UIViewController {
    
    lazy var tableView : UITableView = {
        let tableView = UITableView.init(frame: CGRect(x:0, y:0, width: FMScreenWidth, height:FMScreenHeight - FMNavBarHeight - FMTabBarHeight), style: UITableView.Style.grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.white
        // 注册头尾视图
        
        // 注册分区cell
        tableView.register(FMHomeVipBannerCell.self, forCellReuseIdentifier: FMHomeVipBannerCellID)
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.tableView)
    }
    
   


}

extension FMHomeVIPController:UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case FMHomeVipSectionBanner:
            let cell: FMHomeVipBannerCell = tableView.dequeueReusableCell(withIdentifier: FMHomeVipBannerCellID, for: indexPath) as! FMHomeVipBannerCell
            
            return cell
        default:
            return UITableViewCell()
        }
    }
}
