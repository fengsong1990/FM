//
//  FMHomeRecommendController.swift
//  FM
//
//  Created by fengsong on 2020/4/28.
//  Copyright © 2020 fengsong. All rights reserved.
//

import UIKit
import MJRefresh

private  let FMHomeRecommendTopBuzzIdentifier    = "FMHomeRecommendTopBuzzIdentifier"
private  let FMHomeRecommendTypesIdentifier      = "FMHomeRecommendTypesIdentifier"
private  let FMHomeRecommendVertical             = "FMHomeRecommendVertical"

class FMHomeRecommendController: UIViewController {

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
        //头条
        tableView.register(FMHomeRecommendTopBuzzCell.self, forCellReuseIdentifier: FMHomeRecommendTopBuzzIdentifier)
        //种类 竖
        tableView.register(FMHomeRecommendHotCell.self, forCellReuseIdentifier: FMHomeRecommendVertical)
        //种类 横
        tableView.register(FMHomeRecommendTypesCell.self, forCellReuseIdentifier: FMHomeRecommendTypesIdentifier)
        
        
        
        return tableView
    }()
    
        lazy var viewModel:FMHomeRecommendViewModel={
            return FMHomeRecommendViewModel()
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.tableView)
        
        //下啦刷新对应的方法
        self.tableView.uHeader = FMRefresh{ [weak self] in self?.setUpUIData() }
        //刚进页面进行刷新
        self.tableView.uHeader.beginRefreshing()
    }
    func setUpUIData() {
         viewModel.updataBlock = { [unowned self] in
             // 数据加载完成，刷新数据
             self.tableView.uHeader.endRefreshing()
             self.tableView.reloadData()
         }
         viewModel.refreshDataSource()
     }
 

}


extension FMHomeRecommendController:UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRowAt(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let moduleType = viewModel.homeRecommendList?[indexPath.section].moduleType
        let direction =  viewModel.homeRecommendList?[indexPath.section].direction
        switch (moduleType,direction) {
        case ("focus",_):
            let cell: FMHomeVipBannerCell = tableView.dequeueReusableCell(withIdentifier: FMHomeVipBannerCellIdIdentifier, for: indexPath) as! FMHomeVipBannerCell
            cell.vipBannerList = viewModel.focusImages
            cell.delegate = self
            return cell
        case ("square",_):
            let cell:FMHomeVipCategoriesCell = tableView.dequeueReusableCell(withIdentifier: FMHomeVipCategoriesCellIdIdentifier, for: indexPath) as! FMHomeVipCategoriesCell
            cell.categoryBtnModel = viewModel.categoryBtnList
            cell.delegate = self
            return cell
        case ("topBuzz",_):
            let cell:FMHomeRecommendTopBuzzCell = tableView.dequeueReusableCell(withIdentifier: FMHomeRecommendTopBuzzIdentifier, for: indexPath) as! FMHomeRecommendTopBuzzCell
            cell.categoryContentsModel = viewModel.topBuzzList
            cell.delegate = self
            return cell
        case (_,"column")://"categoriesForShort","playlist","categoriesForExplore"
            // 竖式排列布局cell
            let cell:FMHomeRecommendHotCell = tableView.dequeueReusableCell(withIdentifier: FMHomeRecommendVertical, for: indexPath) as! FMHomeRecommendHotCell
            cell.categoryContentsModel = viewModel.homeRecommendList?[indexPath.section].list
            cell.delegate = self
            return cell
        default:
            // 横式排列布局cell
            let cell:FMHomeRecommendTypesCell = tableView.dequeueReusableCell(withIdentifier: FMHomeRecommendTypesIdentifier, for: indexPath) as! FMHomeRecommendTypesCell
            cell.categoryContentsModel = viewModel.homeRecommendList?[indexPath.section].list?[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = FMPlayDetailController(albumId: (viewModel.homeRecommendList?[indexPath.section].list?[indexPath.row].albumId)!)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return viewModel.heightForHeaderInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView:FMHomeVipHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: FMHomeVipHeaderViewIdIdentifier) as! FMHomeVipHeaderView
         headerView.titStr = viewModel.homeRecommendList?[section].title ?? ""
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
extension FMHomeRecommendController:FMHomeVipBannerCellDelegate{
    func homeVipBannerCellClick(url: String) {
        printLog(message: "暂时没有点击功能")
    }
}
// - 点击顶部分类按钮 delegate
extension FMHomeRecommendController: FMHomeVipCategoriesCellDelegate{
    func homeVipCategoriesCellItemClick(id: String, url: String, title: String) {
        if url == ""{
            
        }else{
            let vc = FMWebController(url:url)
            vc.title = title
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

//- 点击头条 item delegate   横
extension FMHomeRecommendController:FMHomeRecommendTopBuzzCellDelegate{
    func homeRecommendTopBuzzCellItemClick(model: FMTopBuzzModel) {
        
    }
}
//- 点击头条 item delegate   竖
extension FMHomeRecommendController:FMHomeRecommendHotCellDelegate{
    func homeVipHotCellItemClick(model: FMRecommendListModel) {
        
    }
}
