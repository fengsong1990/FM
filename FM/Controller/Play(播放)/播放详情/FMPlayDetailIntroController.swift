//
//  FMPlayDetailIntroController.swift
//  FM
//
//  Created by fengsong on 2020/5/11.
//  Copyright © 2020 fengsong. All rights reserved.
//

import UIKit

class FMPlayDetailIntroController: UIViewController,LTTableViewProtocal {

    private var playDetailAlbum:FMPlayDetailAlbumModel?
    private var playDetailUser:FMPlayDetailUserModel?
    
    private let LBFMPlayContentIntroCellID = "LBFMPlayContentIntroCell"
    private let LBFMPlayAnchorIntroCellID  = "LBFMPlayAnchorIntroCell"
    private lazy var tableView: UITableView = {
        let tableView = tableViewConfig(CGRect(x: 0, y: 0, width:FMScreenWidth, height: FMScreenHeight), self, self, nil)
        tableView.register(FMPlayContentIntroCell.self, forCellReuseIdentifier: LBFMPlayContentIntroCellID)
        tableView.register(FMPlayAnchorIntroCell.self, forCellReuseIdentifier: LBFMPlayAnchorIntroCellID)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
        glt_scrollView = tableView
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        self.tableView.tableFooterView = UIView()
    }
    // 内容简介model
    var playDetailAlbumModel:FMPlayDetailAlbumModel? {
        didSet{
            guard let model = playDetailAlbumModel else {return}
            self.playDetailAlbum = model
            // 防止刷新分区的时候界面闪烁
            UIView.performWithoutAnimation {
                self.tableView.reloadSections(NSIndexSet(index: 0) as IndexSet, with: UITableView.RowAnimation.none)
            }
        }
    }
    // 主播简介model
    var playDetailUserModel:FMPlayDetailUserModel? {
        didSet{
            guard let model = playDetailUserModel else {return}
            self.playDetailUser = model
            // 防止刷新分区的时候界面闪烁
            UIView.performWithoutAnimation {
                self.tableView.reloadSections(NSIndexSet(index: 1) as IndexSet, with: UITableView.RowAnimation.none)
            }        }
        
    }

}
extension FMPlayDetailIntroController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            let introHeight = FMPlayContentIntroCell.getCellHeight(model: self.playDetailAlbum)
            return introHeight
        }else if indexPath.section == 1{
            return 120
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell:FMPlayContentIntroCell = tableView.dequeueReusableCell(withIdentifier: LBFMPlayContentIntroCellID, for: indexPath) as! FMPlayContentIntroCell
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.playDetailAlbumModel = self.playDetailAlbum
            return cell
        }else {
            let cell:FMPlayAnchorIntroCell = tableView.dequeueReusableCell(withIdentifier: LBFMPlayAnchorIntroCellID, for: indexPath) as! FMPlayAnchorIntroCell
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.playDetailUserModel = self.playDetailUser
            return cell
        }
    }
}
