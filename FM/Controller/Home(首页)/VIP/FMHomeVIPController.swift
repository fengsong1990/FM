//
//  FMHomeVIPController.swift
//  FM
//
//  Created by fengsong on 2020/4/28.
//  Copyright © 2020 fengsong. All rights reserved.
//

import UIKit
import MJRefresh
///Section
let FMHomeVipSectionBanner    = 0   // 滚动图片section
let FMHomeVipSectionGrid      = 1   // 分类section
let FMHomeVipSectionHot       = 2   // 热section
let FMHomeVipSectionEnjoy     = 3   // 尊享section
let FMHomeVipSectionVip       = 4

//Cell
private let FMHomeVIPCellIdIdentifier           = "FMHomeVIPCellIdIdentifier"

let FMHomeVipBannerCellIdIdentifier     = "FMHomeVipBannerCellIdIdentifier"
let FMHomeVipCategoriesCellIdIdentifier = "FMHomeVipCategoriesCellIdIdentifier"
let FMHomeVipHotCellIdIdentifier        = "FMHomeVipHotCellIdIdentifier"


let FMHomeVipHeaderViewIdIdentifier     = "FMHomeVipHeaderViewIdIdentifier"
let FMHomeVipFooterViewIdIdentifier     = "FMHomeVipFooterViewIdIdentifier"

class FMHomeVIPController: UIViewController {
    
    lazy var tableView : UITableView = {
        let tableView = UITableView.init(frame: CGRect(x:0, y:0, width: FMScreenWidth, height:FMScreenHeight - FMNavBarHeight), style: UITableView.Style.grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        // 注册头尾视图
        tableView.register(FMHomeVipHeaderView.self, forHeaderFooterViewReuseIdentifier: FMHomeVipHeaderViewIdIdentifier)
        tableView.register(FMHomeVipFooterView.self, forHeaderFooterViewReuseIdentifier: FMHomeVipFooterViewIdIdentifier)
        // 注册分区cell
        //轮播
        tableView.register(FMHomeVipBannerCell.self, forCellReuseIdentifier: FMHomeVipBannerCellIdIdentifier)
        //顶部分类
        tableView.register(FMHomeVipCategoriesCell.self, forCellReuseIdentifier: FMHomeVipCategoriesCellIdIdentifier)
        //热播
        tableView.register(FMHomeVipHotCell.self, forCellReuseIdentifier: FMHomeVipHotCellIdIdentifier)
        //种类
        tableView.register(FMHomeVIPTypesCell.self, forCellReuseIdentifier: FMHomeVIPCellIdIdentifier)
        
        return tableView
    }()
    
    lazy var viewModel:FMHomeVIPViewModel={
        return FMHomeVIPViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.tableView)
        
        //下啦刷新对应的方法
        self.tableView.uHeader = FMRefresh{ [weak self] in self?.setUpUIData() }
        //刚进页面进行刷新
        self.tableView.uHeader.beginRefreshing()
    }
    //刷新数据
    func setUpUIData() {
        viewModel.updataBlock = { [unowned self] in
            // 数据加载完成，刷新数据
            self.tableView.uHeader.endRefreshing()
            self.tableView.reloadData()
        }
        viewModel.refreshDataSource()
    }
    
}

extension FMHomeVIPController:UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.categoryList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRowAt(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case FMHomeVipSectionBanner:
            let cell: FMHomeVipBannerCell = tableView.dequeueReusableCell(withIdentifier: FMHomeVipBannerCellIdIdentifier, for: indexPath) as! FMHomeVipBannerCell
            cell.vipBannerList = viewModel.focusImages
            cell.delegate = self
            return cell
        case FMHomeVipSectionGrid:
            let cell:FMHomeVipCategoriesCell = tableView.dequeueReusableCell(withIdentifier: FMHomeVipCategoriesCellIdIdentifier, for: indexPath) as! FMHomeVipCategoriesCell
            cell.categoryBtnModel = viewModel.categoryBtnList
            cell.delegate = self
            return cell
        case FMHomeVipSectionHot,FMHomeVipSectionEnjoy:
            let cell:FMHomeVipHotCell = tableView.dequeueReusableCell(withIdentifier: FMHomeVipHotCellIdIdentifier, for: indexPath) as! FMHomeVipHotCell
            cell.categoryContentsModel = viewModel.categoryList?[indexPath.section].list
            cell.delegate = self
            return cell
        default:
            
            let cell:FMHomeVIPTypesCell = tableView.dequeueReusableCell(withIdentifier: FMHomeVIPCellIdIdentifier, for: indexPath) as! FMHomeVIPTypesCell
            cell.categoryContentsModel = viewModel.categoryList?[indexPath.section].list?[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = FMPlayDetailController(albumId: (viewModel.categoryList?[indexPath.section].list?[indexPath.row].albumId)!)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return viewModel.heightForHeaderInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView:FMHomeVipHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: FMHomeVipHeaderViewIdIdentifier) as! FMHomeVipHeaderView
         headerView.titStr = viewModel.categoryList?[section].title
         return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return viewModel.heightForFooterInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = FMDownColor
        return view
    }
    
}

// - 点击轮播item delegate
extension FMHomeVIPController:FMHomeVipBannerCellDelegate{
    func homeVipBannerCellClick(url: String) {
        printLog(message: "暂时没有点击功能")
    }
}
// - 点击顶部分类按钮 delegate
extension FMHomeVIPController: FMHomeVipCategoriesCellDelegate{
    func homeVipCategoriesCellItemClick(id: String, url: String, title: String) {
        if url == ""{
            
        }else{
            let vc = FMWebController(url:url)
            vc.title = title
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
// - 点击热播item delegate
extension FMHomeVIPController:FMHomeVipHotCellDelegate{
    func homeVipHotCellItemClick(model: FMCategoryContents) {
        
    }
}
