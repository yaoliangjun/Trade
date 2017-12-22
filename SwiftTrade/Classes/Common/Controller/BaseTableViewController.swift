//
//  BaseTableViewController.swift
//  SwiftTrade
//
//  Created by yaoliangjun on 2017/11/27.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//

import UIKit
import MJRefresh

class BaseTableViewController: BaseViewController {

    var tableView: UITableView? = nil;
    var pageNumber = 0 // 默认页码:第0页
    var pageCount = 15 // 默认每页显示条数

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func createTableView(style: UITableViewStyle) -> UITableView {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: GlobalConstants.screenWidth, height: GlobalConstants.tableViewHeight), style: style)
        tableView.rowHeight = 50
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = AppConstants.gapColor
        return tableView
    }

    func createTableView(style: UITableViewStyle, needRefresh: Bool) -> UITableView {
        let tableView = self.createTableView(style: style)
        if needRefresh {
            addRefreshComponentsWithTableView(tableView: tableView)
        }
        return tableView
    }

    func addRefreshComponentsWithTableView(tableView: UITableView) -> () {
        // 设置头部
        let header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(pullDownToRefresh))
        header?.lastUpdatedTimeLabel.isHidden = true;
        header?.setTitle("下拉刷新", for: .idle)
        header?.setTitle("松开刷新", for: .pulling)
        header?.setTitle("加载中...", for: .refreshing)
        header?.stateLabel.textColor = AppConstants.greyTextColor
        tableView.mj_header = header

        // 设置底部
        let footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(pullUpToRefresh))
        footer?.setTitle("下拉刷新", for: .idle)
        footer?.setTitle("松开刷新", for: .pulling)
        footer?.setTitle("加载中...", for: .refreshing)
        footer?.stateLabel.textColor = AppConstants.greyTextColor
        tableView.mj_footer = footer
        tableView.mj_footer.isHidden = true
    }

    // 子类重写该方法,请求数据
    func pullDownHandle() -> () {

    }

    // 子类重写该方法,请求数据
    func pullUpHandle() -> () {

    }

    @objc private func pullDownToRefresh() -> () {
        endRefreshingHeader()
        pullDownHandle()
    }

    @objc private func pullUpToRefresh() -> () {
        endRefreshingFooter()
        pullUpHandle()
    }

    fileprivate func endRefreshingHeader() -> () {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.tableView?.mj_header.endRefreshing()
        }
    }

    fileprivate func endRefreshingFooter() -> () {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.tableView?.mj_footer.endRefreshing()
        }
    }
}
