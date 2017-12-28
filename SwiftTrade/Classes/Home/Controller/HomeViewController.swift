//
//  HomeViewController.swift
//  SwiftTrade
//
//  Created by Jerry Yao on 2017/10/14.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//  首页

import UIKit

class HomeViewController: BaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMarketSummary()
    }
    
    // 获取市场
    func fetchMarketSummary() {
        HomeServices.fetchMarketSummary(params: [:], showHUD: true, success: { (marketSummaryArray) in
            self.markets = marketSummaryArray
            self.tableView?.reloadData()

        }) { (error) in
            
        }
    }

    // MARK: - Private Method
    override func pullDownHandle() {
        fetchMarketSummary()
    }

    // 消息
    func messageBtnClick() {
        let messageVC = MessageViewController()
        navigationController?.pushViewController(messageVC, animated: true)
    }

    // MARK: - Getter / Setter
    override func setupSubViews() {
        tableView = createTableView(delegate: self, style: .plain, needRefresh: true)
        tableView?.tableHeaderView = tableHeaderView
        view.addSubview(tableView!)

        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "home_news"), style: .plain, target: self, action: #selector(messageBtnClick))
    }

    lazy var markets: [MarketSummaryModel] = {
        return Array<MarketSummaryModel>()
    }()
    
    lazy var tableHeaderView: UIView = {
        let tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: GlobalConstants.screenWidth, height: GlobalConstants.screenHeight / 3.8))
        let imageView = UIImageView(image: UIImage(named: "home_banner"))
        imageView.frame = CGRect(x: 0, y: 0, width: GlobalConstants.screenWidth, height: GlobalConstants.screenHeight / 3.8)
        tableHeaderView.addSubview(imageView)
        
        return tableHeaderView
    }()
}

extension HomeViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return markets.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = HomeCell.cellWithTableView(tableView: tableView) as! HomeCell
        cell.marketSummaryModel = markets[indexPath.section]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeader: UIView = UIView(frame: CGRect(x: 0, y: 0, width: GlobalConstants.screenWidth, height: 10))
        sectionHeader.backgroundColor = AppConstants.gapColor;
        return sectionHeader;
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {

        let remindAction = UITableViewRowAction(style: .default, title: "提醒") { (action, indexPath) in

        }
        remindAction.backgroundColor = AppConstants.grayColor

        let buyInAction = UITableViewRowAction(style: .default, title: "买入") { (action, indexPath) in

        }
        buyInAction.backgroundColor = UIColor.orange

        let sellOutAction = UITableViewRowAction(style: .default, title: "卖出") { (action, indexPath) in

        }
        sellOutAction.backgroundColor = UIColor.red

        return [sellOutAction, buyInAction, remindAction]
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }


    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {

    }


    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
}
