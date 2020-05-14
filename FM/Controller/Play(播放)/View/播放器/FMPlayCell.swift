//
//  FMPlayCell.swift
//  FM
//
//  Created by fengsong on 2020/5/12.
//  Copyright © 2020 fengsong. All rights reserved.
//

import UIKit
import StreamingKit

class FMPlayCell: UITableViewCell {
    
    var playUrl:String?
    var timer: Timer?
    var displayLink: CADisplayLink?
    // 是否是第一次播放
    private var isFirstPlay:Bool = true
    // 音频播放器
    private lazy var audioPlayer:STKAudioPlayer={
        let audioPlayer = STKAudioPlayer()
        audioPlayer.delegate = self
        return audioPlayer
    }()
//    //是否循环播放
//    var loop:Bool = false
//    //当前播放状态
//    var state:STKAudioPlayerState = []
//    //当前播放音乐的索引
//    var currentIndex:Int = -1
//    //播放列表
//    var queue = [String]()
    
    // 标题
    private var titleLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = NSTextAlignment.center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.red
        return label
    }()
    // 图片
    private var coverImageView:UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    // 弹幕按钮
    private lazy var barrageBtn:UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.setImage(UIImage(named: "NPProDMOff_24x24_"), for: UIControl.State.normal)
        return button
    }()
    // 播放机器按钮
    private lazy var machineBtn:UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.setImage(UIImage(named: "npXPlay_30x30_"), for: UIControl.State.normal)
        return button
    }()
    // 设置按钮
    private lazy var setBtn:UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.setImage(UIImage(named: "NPProSet_25x24_"), for: UIControl.State.normal)
        return button
    }()
    // 进度条
    private lazy var slider:UISlider = {
        let slider = UISlider(frame: CGRect.zero)
        slider.setThumbImage(UIImage(named: "playProcessDot_n_7x16_"), for: .normal)
        slider.maximumTrackTintColor = UIColor.lightGray
        slider.minimumTrackTintColor = FMButtonColor
        slider.minimumValue = 0
        // 滑块滑动停止后才触发ValueChanged事件
        //        slider.isContinuous = false
        
        slider.addTarget(self, action: #selector(FMPlayCell.change(slider:)), for: UIControl.Event.valueChanged)

        return slider
    }()
    // 当前时间
    private lazy var currentTime:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = FMButtonColor
        return label
    }()
    // 总时间
    private lazy var totalTime:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = FMButtonColor
        label.textAlignment = NSTextAlignment.right
        return label
    }()
    // 播放暂停按钮
    private lazy var playBtn:UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.setImage(UIImage(named: "toolbar_play_n_p_78x78_"), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(playBtn(button:)), for: UIControl.Event.touchUpInside)
        return button
    }()
    // 上一曲按钮
    private lazy var prevBtn:UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.setImage(UIImage(named: "toolbar_prev_n_p_24x24_"), for: UIControl.State.normal)
        return button
    }()
    
    // 下一曲按钮
    private lazy var nextBtn:UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.setImage(UIImage(named: "toolbar_next_n_p_24x24_"), for: UIControl.State.normal)
        return button
    }()
    // 消息列表按钮
    private lazy var msgBtn:UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.setImage(UIImage(named: "playpage_icon_list_24x24_"), for: UIControl.State.normal)
        return button
    }()
    // 定时按钮
    private lazy var timingBtn:UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.setImage(UIImage(named: "playpage_icon_timing_24x24_"), for: UIControl.State.normal)
        return button
    }()
    
    // 毛玻璃背景
    private lazy var blurImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    func setUpUI(){
        self.backgroundColor = UIColor.red
//        self.blurImageView = UIImageView.init(frame:  CGRect(x:0 , y:0 , width: FMScreenWidth, height: FMScreenHeight * 0.7))
//             self.blurImageView.image = UIImage(named: "1")
//             let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light)) as UIVisualEffectView
//             visualEffectView.frame = self.blurImageView.bounds
//             //添加毛玻璃效果层
//             //zcself.blurImageView.addSubview(visualEffectView)
//             self.insertSubview(self.blurImageView, belowSubview: self)
//
//        // 标题
//        self.blurImageView.addSubview(self.titleLabel)
//        self.titleLabel.snp.makeConstraints { (make) in
//            make.top.equalToSuperview().offset(15)
//            make.left.equalToSuperview().offset(20)
//            make.right.equalToSuperview().offset(-20)
//            make.height.equalTo(60)
//        }
//        // 图片
//        self.blurImageView.addSubview(self.coverImageView)
//        self.coverImageView.snp.makeConstraints { (make) in
//            make.top.equalTo(self.titleLabel.snp.bottom).offset(15)
//            make.left.equalToSuperview().offset(60)
//            make.right.equalToSuperview().offset(-60)
//            make.height.equalTo(FMScreenHeight * 0.7 - 260)
//        }
//        // 弹幕按钮
//        self.blurImageView.addSubview(self.barrageBtn)
//        self.barrageBtn.snp.makeConstraints { (make) in
//            make.left.equalTo(20)
//            make.top.equalTo(self.coverImageView.snp.bottom).offset(20)
//            make.height.width.equalTo(30)
//        }
//        // 设置按钮
//        self.blurImageView.addSubview(self.setBtn)
//        self.setBtn.snp.makeConstraints { (make) in
//            make.right.equalTo(-20)
//            make.top.equalTo(self.coverImageView.snp.bottom).offset(20)
//            make.height.width.equalTo(30)
//        }
//        // 播放机器按钮
//        self.blurImageView.addSubview(self.machineBtn)
//        self.machineBtn.snp.makeConstraints { (make) in
//            make.right.equalTo(self.setBtn.snp.left).offset(-20)
//            make.top.equalTo(self.coverImageView.snp.bottom).offset(20)
//            make.height.width.equalTo(30)
//        }
//        // 进度条
//        self.blurImageView.addSubview(self.slider)
//        self.slider.snp.makeConstraints { (make) in
//            make.left.equalToSuperview().offset(20)
//            make.right.equalToSuperview().offset(-20)
//            make.bottom.equalToSuperview().offset(-90)
//        }
//        // 当前时间
//        self.blurImageView.addSubview(self.currentTime)
//        self.currentTime.text = "00:00"
//        self.currentTime.snp.makeConstraints { (make) in
//            make.left.equalTo(self.slider)
//            make.top.equalTo(self.slider.snp.bottom).offset(5)
//            make.width.equalTo(60)
//            make.height.equalTo(20)
//        }
//        // 总时间
//        self.blurImageView.addSubview(self.totalTime)
//        self.totalTime.text = "21:33"
//        self.totalTime.snp.makeConstraints { (make) in
//            make.right.equalTo(self.slider)
//            make.top.equalTo(self.slider.snp.bottom).offset(5)
//            make.width.equalTo(60)
//            make.height.equalTo(20)
//        }
//        // 播放暂停按钮
//        self.blurImageView.addSubview(self.playBtn)
//        self.playBtn.snp.makeConstraints { (make) in
//            make.bottom.equalToSuperview().offset(-20)
//            make.height.width.equalTo(60)
//            make.centerX.equalToSuperview()
//        }
//        // 上一曲按钮
//        self.blurImageView.addSubview(self.prevBtn)
//        self.prevBtn.snp.makeConstraints { (make) in
//            make.right.equalTo(self.playBtn.snp.left).offset(-30)
//            make.height.width.equalTo(25)
//            make.centerY.equalTo(self.playBtn)
//        }
//        // 下一曲按钮
//        self.blurImageView.addSubview(self.nextBtn)
//        self.nextBtn.snp.makeConstraints { (make) in
//            make.left.equalTo(self.playBtn.snp.right).offset(30)
//            make.height.width.equalTo(25)
//            make.centerY.equalTo(self.playBtn)
//        }
//        // 消息列表按钮
//        self.blurImageView.addSubview(self.msgBtn)
//        self.msgBtn.snp.makeConstraints { (make) in
//            make.left.equalTo(15)
//            make.bottom.equalToSuperview().offset(-20)
//            make.height.width.equalTo(40)
//        }
//        // 定时按钮
//        self.blurImageView.addSubview(self.timingBtn)
//        self.timingBtn.snp.makeConstraints { (make) in
//            make.right.equalTo(-15)
//            make.bottom.equalToSuperview().offset(-20)
//            make.height.width.equalTo(40)
//        }
    }
    
    var playTrackInfo:FMPlayTrackInfo?{
        didSet{
            guard let model = playTrackInfo else {return}
            
            //self.blurImageView.kf.setImage(with: URL(string: model.coverLarge ?? ""))
            
//            self.titleLabel.text = model.title
//            self.coverImageView.kf.setImage(with: URL(string: model.coverLarge ?? ""))
//            self.blurImageView.kf.setImage(with: URL(string: model.coverLarge ?? ""))
//            
//            self.totalTime.text = getMMSSFromSS(duration: model.duration)
//            self.playUrl = model.playUrl64

            
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension FMPlayCell{
    
    func getMMSSFromSS(duration:Int)->(String){
        var min = duration / 60
        let sec = duration % 60
        var hour : Int = 0
        if min >= 60 {
            hour = min / 60
            min = min % 60
            if hour > 0 {
                return String(format: "%02d:%02d:%02d", hour, min, sec)
            }
        }
        return String(format: "%02d:%02d", min, sec)
    }
    
    func starTimer() {
        displayLink = CADisplayLink(target: self, selector: #selector(updateCurrentLabel))
        displayLink?.add(to: RunLoop.current, forMode: RunLoop.Mode.common)
    }
    
    func removeTimer() {
        displayLink?.invalidate()
        displayLink = nil
    }
}
extension FMPlayCell{
    
    @objc func playBtn(button:UIButton){
        button.isSelected = !button.isSelected
        if button.isSelected {
            button.setImage(UIImage(named: "toolbar_pause_n_p_78x78_"), for: UIControl.State.normal)
            if isFirstPlay {
                self.audioPlayer.play(URL(string: self.playUrl!)!)
                starTimer()
                isFirstPlay = false
            }else {
                starTimer()
                self.audioPlayer.resume()
            }
        }else{
            button.setImage(UIImage(named: "toolbar_play_n_p_78x78_"), for: UIControl.State.normal)
            removeTimer()
            self.audioPlayer.pause()
        }
        
    }
    
    //    @objc func setUpTimesView() {
    //        let currentTime:Int = Int(self.audioPlayer.progress)
    //        self.currentTime.text = getMMSSFromSS(duration: currentTime)
    //        let progress = Float(self.audioPlayer.progress / self.audioPlayer.duration)
    //        slider.value = progress
    //    }
    @objc func updateCurrentLabel() {
        let currentTime:Int = Int(self.audioPlayer.progress)
        self.currentTime.text = getMMSSFromSS(duration: currentTime)
        let progress = Float(self.audioPlayer.progress / self.audioPlayer.duration)
        slider.value = progress
    }
    @objc func change(slider:UISlider) {
        print("slider.value = %d",slider.value)
        audioPlayer.seek(toTime: Double(slider.value * Float(self.audioPlayer.duration)))
        
    }
    
}

extension FMPlayCell:STKAudioPlayerDelegate{
    func audioPlayer(_ audioPlayer: STKAudioPlayer, didStartPlayingQueueItemId queueItemId: NSObject) {
        printLog(message: "开始播放")
    }
    
    func audioPlayer(_ audioPlayer: STKAudioPlayer, didFinishBufferingSourceWithQueueItemId queueItemId: NSObject) {
        printLog(message: "完成加载")
    }
    
    func audioPlayer(_ audioPlayer: STKAudioPlayer, stateChanged state: STKAudioPlayerState, previousState: STKAudioPlayerState) {
        printLog(message: "播放状态改变")
    }
    
    func audioPlayer(_ audioPlayer: STKAudioPlayer, didFinishPlayingQueueItemId queueItemId: NSObject, with stopReason: STKAudioPlayerStopReason, andProgress progress: Double, andDuration duration: Double) {
        printLog(message: "结束播放\(stopReason)")
        
        
        
        
        
    }
    
    func audioPlayer(_ audioPlayer: STKAudioPlayer, unexpectedError errorCode: STKAudioPlayerErrorCode) {
        printLog(message: "错误原因\(errorCode)")
    }
    
    
}
