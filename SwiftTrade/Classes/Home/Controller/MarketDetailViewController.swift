//
//  MarketDetailViewController.swift
//  SwiftTrade
//
//  Created by yaoliangjun on 2018/1/5.
//  Copyright © 2018年 Jerry Yao. All rights reserved.
//

import UIKit

class MarketDetailViewController: BaseTableViewController {

    var marketSummaryModel: MarketSummaryModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    // MARK: - Private Method
    override func pullDownHandle() {

    }
    
    func fullScreenBtnClick() {

    }

    // MARK: - Getter / Setter
    override func setupSubViews() {
        title = String(format: "%@(%@)", marketSummaryModel?.coinName ?? "", marketSummaryModel?.coinSymbol?.uppercased() ?? "")
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "home_fullscreen_press", target: self, selector: #selector(fullScreenBtnClick))

        tableView = createTableView(delegate: self, style: .plain, needRefresh: true)
        tableView!.tableHeaderView = tableHeaderView
        view.addSubview(tableView!)
    }

    lazy var tableHeaderView: UIView = {
        let tableViewHeight: CGFloat = 15 + 100 + 15 + 400
        let tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: GlobalConstants.screenWidth, height: tableViewHeight))

        // 市场详情控件
        tableHeaderView.addSubview(self.marketDetailView)
        self.marketDetailView.snp.makeConstraints({ (make) in
            make.left.right.equalTo(tableHeaderView)
            make.top.equalTo(tableHeaderView).offset(15)
            make.height.equalTo(100)
        })

        // K线控件
        tableHeaderView.addSubview(self.klineView)
        self.klineView.snp.makeConstraints({ (make) in
            make.left.right.equalTo(tableHeaderView)
            make.top.equalTo(self.marketDetailView.snp.bottom).offset(15)
            make.height.equalTo(400)
        })

        return tableHeaderView
    }()

    lazy var marketDetailView: MarketDetailView = {
        var marketDetailView = MarketDetailView()
        marketDetailView.backgroundColor = UIColor.white
        return marketDetailView
    }()

    lazy var klineView: KLineView = {
        var klineView = KLineView()
        klineView.backgroundColor = UIColor.white

        return klineView
    }()
}

extension MarketDetailViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellReuseId = "CellReuseId"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellReuseId)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellReuseId)
        }
        return cell!
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeader: UIView = UIView(frame: CGRect(x: 0, y: 0, width: GlobalConstants.screenWidth, height: 15))
        sectionHeader.backgroundColor = AppConstants.gapColor;
        return sectionHeader
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
}
