//
//  HomeViewController.swift
//  SwiftTrade
//
//  Created by Jerry Yao on 2017/10/14.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//  首页

import UIKit

class HomeViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubViews()
        fetchMarketSummary()
    }
    
    // 获取市场
    func fetchMarketSummary() {
        HomeServices.fetchMarketSummary(params: Dictionary.init(), showHUD: true, success: { (marketSummaryArray) in
            self.markets = marketSummaryArray
            self.tableView.reloadData()
            
        }) { (error) in
            
        }
    }
    
    func setupSubViews() {
        view.addSubview(tableView)
    }
    
    // MARK: - Getter / Setter
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
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: GlobalConstants.screenWidth, height: GlobalConstants.tableViewHeight))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 70
        tableView.tableHeaderView = self.tableHeaderView
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = GlobalConstants.backgroundColor
        
        return tableView
    }()
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return markets.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let homeCellReuseId = "homeCellReuseId"
        var cell = tableView.dequeueReusableCell(withIdentifier: homeCellReuseId) as? HomeCell
        if cell == nil {
            cell = HomeCell(style: .default, reuseIdentifier: homeCellReuseId)
        }
        
        cell!.marketSummaryModel = markets[indexPath.section]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeader: UIView = UIView(frame: CGRect(x: 0, y: 0, width: GlobalConstants.screenWidth, height: 10))
        sectionHeader.backgroundColor = AppConstants.gapColor;
        return sectionHeader;
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
}
