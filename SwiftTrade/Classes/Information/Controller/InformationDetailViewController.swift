//
//  InformationDetailViewController.swift
//  SwiftTrade
//
//  Created by yaoliangjun on 2017/11/29.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//

import UIKit

class InformationDetailViewController: BaseViewController, UIWebViewDelegate {

    var infoModel: InfoModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
    }

    // MARK: - UIWebViewDelegate
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        MBProgressHUD.showLoading()
        return true
    }

    func webViewDidFinishLoad(_ webView: UIWebView) {
        MBProgressHUD.dismiss()

        // 修改字体颜色
        webView.stringByEvaluatingJavaScript(from: "document.getElementsByTagName('body')[0].style.webkitTextFillColor= '#333333'")

        // 修改所有元素的背景颜色
        let allElementsStr = "var objs = document.getElementsByTagName('*'); for(var i=0; i<objs.length; i++) { objs[i].style.backgroundColor='#EDEDED'; }"
        webView.stringByEvaluatingJavaScript(from: allElementsStr)
    }

    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        MBProgressHUD.dismiss()
    }

    // MARK: - Getter / Setter
    func setupSubViews() {
        title = "资讯详情"

        let webView = UIWebView(frame: view.bounds)
        webView.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 64, 0)
        webView.isOpaque = false
        webView.backgroundColor = AppConstants.gapColor
        webView.scrollView.backgroundColor = AppConstants.gapColor
        webView.delegate = self
        view.addSubview(webView)

        let htmlContennt = infoModel?.content
        guard let content = htmlContennt else {
            return
        }
        webView.loadHTMLString(content, baseURL: nil)
    }
}
