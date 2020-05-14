//
//  FMPlayDetailProgramController.swift
//  FM
//
//  Created by fengsong on 2020/5/12.
//  Copyright © 2020 fengsong. All rights reserved.
//

import UIKit

class FMPlayDetailProgramController: UIViewController,LTTableViewProtocal {

    var albumId: Int = 0{
        didSet{
            printLog(message: "值==\(albumId)")
        }
    }
    
    
    private var playDetailTracks:FMPlayDetailTracksModel?
       
       private let LBFMPlayDetailProgramCellID = "LBFMPlayDetailProgramCell"
       private lazy var tableView: UITableView = {
           let tableView = tableViewConfig(CGRect(x: 0, y:0, width:FMScreenWidth, height: FMScreenHeight), self, self, nil)
           tableView.register(FMPlayDetailProgramCell.self, forCellReuseIdentifier: LBFMPlayDetailProgramCellID)
           return tableView
       }()
    
    
    var playDetailTracksModel:FMPlayDetailTracksModel?{
        didSet{
            guard let model = playDetailTracksModel else {return}
            self.playDetailTracks = model
            self.tableView.reloadData()
        }
    }
    
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
        
        
        //下啦刷新对应的方法
        self.tableView.uFoot = URefreshFooter{ [weak self] in self?.requestNextPageData() }
        
    }
    //VM
    lazy var viewModel:FMPlayViewModel={
        return FMPlayViewModel()
    }()
    var currentPage = 1
    func requestNextPageData() {
        printLog(message: "加载更多")
        currentPage = currentPage + 1
        self.viewModel.getPlayDetailData(albumId: self.albumId, pageIndex: currentPage)
        viewModel.playDetailDataBlock = {[weak self] in
            
            // 数据加载完成，刷新数据
            self?.tableView.uFoot.endRefreshing()
            self?.playDetailTracksModel = self?.viewModel.playDetailTracks
            self?.tableView.reloadData()
        }
        
    }
    
}
extension FMPlayDetailProgramController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.playDetailTracks?.list?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let introHeight = FMPlayDetailProgramCell.getCellHeight(model: self.playDetailTracks?.list?[indexPath.row])
        return introHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:FMPlayDetailProgramCell = tableView.dequeueReusableCell(withIdentifier: LBFMPlayDetailProgramCellID, for: indexPath) as! FMPlayDetailProgramCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.playDetailTracksList = self.playDetailTracks?.list?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let albumId = self.playDetailTracks?.list?[indexPath.row].albumId ?? 0
        let trackUid = self.playDetailTracks?.list?[indexPath.row].trackId ?? 0
        let uid = self.playDetailTracks?.list?[indexPath.row].uid ?? 0
        
        let playVC = FMPlayController(albumId:albumId, trackUid:trackUid, uid:uid)
        self.navigationController?.pushViewController(playVC, animated: true)
//        let vc = FMNavigationController.init(rootViewController: playVC)
//        vc.modalPresentationStyle = .fullScreen
//        self.present(vc, animated: true, completion: nil)
    }
}
