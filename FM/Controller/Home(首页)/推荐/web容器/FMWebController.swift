//
//  FMWebController.swift
//  FM
//
//  Created by fengsong on 2020/4/30.
//  Copyright © 2020 fengsong. All rights reserved.
//

import UIKit
import WebKit
class FMWebController: UIViewController {

    private var url:String = ""
    
    convenience init(url: String = "") {
        self.init()
        self.url = url
    }
    private lazy var webView:WKWebView = {
        let webView = WKWebView(frame: self.view.bounds)
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(webView)
        webView.load(URLRequest.init(url: URL.init(string: self.url)!))
    }

}
