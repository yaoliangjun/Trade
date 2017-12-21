//
//  CancelOrderViewController.swift
//  SwiftTrade
//
//  Created by yaoliangjun on 2017/12/7.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//  撤单页面

import UIKit

class CancelOrderViewController: BaseTableViewController {

    lazy var cancelOrderArray: [CancelOrderModel] = {
        var cancelOrderArray = [CancelOrderModel]()
        return cancelOrderArray
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCancelOrders()
    }

    // MARK: - HTTP
    func fetchCancelOrders() {
        TradeServices.fetchCancelOrders(params: [:], showHUD: true, success: { (response) in
            self.cancelOrderArray = response
            self.tableView?.reloadData()

        }) { (error) in

        }
    }

    // MARK: - Getter / Setter
    override func setupSubViews() {
        tableView = createTableView(style: .plain, needRefresh: true)
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.rowHeight = 160
        view.addSubview(tableView!)
    }
}

extension CancelOrderViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return cancelOrderArray.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CancelOrderCell.cellWithTableView(tableView: tableView) as! CancelOrderCell
        cell.setupModel(cancelOrderModel: cancelOrderArray[indexPath.section])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeader: UIView = UIView(frame: CGRect(x: 0, y: 0, width: GlobalConstants.screenWidth, height: 15))
        sectionHeader.backgroundColor = AppConstants.gapColor;
        return sectionHeader;
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.layoutMargins = UIEdgeInsets.zero
    }
}
