//
//  HomeViewController.swift
//  SwiftTrade
//
//  Created by Jerry Yao on 2017/10/14.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//  首页

import UIKit

class HomeViewController: BaseViewController {

//    let marketSummaryArray: [MarketSummaryModel]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubViews()
        fetchMarketSummary()
    }

//    override func viewWillAppear(_ animated: Bool) {
//        super .viewWillAppear(animated)
//        fetchMarketSummary()
//    }
    
    // 获取市场
    func fetchMarketSummary() {
        HomeServices.fetchMarketSummary(params: Dictionary.init(), showHUD: true, success: { (marketSummaryArray) in
            print(marketSummaryArray)
            
        }) { (error) in
            
        }
    }
    
    func setupSubViews() {
        view.addSubview(tableView)
    }
    
    // MARK: - Getter / Setter
    lazy var marketSummaryArray: [MarketSummaryModel] = {
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
        
        return tableView
    }()
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return marketSummaryArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let homeCellReuseId = "homeCellReuseId"
        var cell = tableView.dequeueReusableCell(withIdentifier: homeCellReuseId)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: homeCellReuseId)
        }
        
        cell?.textLabel?.text = "Jerry Yao"
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
