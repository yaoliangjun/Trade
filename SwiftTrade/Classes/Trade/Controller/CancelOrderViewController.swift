//
//  CancelOrderViewController.swift
//  SwiftTrade
//
//  Created by yaoliangjun on 2017/12/7.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//  撤单页面

import UIKit

class CancelOrderViewController: BaseTableViewController, CancelOrderCellDelegate {

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

    override func pullDownHandle() {
        fetchCancelOrders()
    }

    func cancelOrder(cancelOrderModel: CancelOrderModel) {
        TradeServices.cancelOrder(orderId: cancelOrderModel.id!, showHUD: true, success: { (response) in
            if response != nil {
                MBProgressHUD.show(withStatus: "撤单成功")
                let index = self.cancelOrderArray.index(of: cancelOrderModel)
                self.cancelOrderArray.remove(at: index!)
                self.tableView?.reloadData()
            }

        }) { (error) in

        }
    }

    // MARK: CancelOrderCellDelegate
    func cancelOrderCell(cell: CancelOrderCell, cancelOrderModel: CancelOrderModel) {

        let alertController = UIAlertController(title: "提示", message: "确定要撤单吗?", preferredStyle: .alert, positiveActionTitle: "确定", positiveCompletionHandle: { (alert) in
            self.cancelOrder(cancelOrderModel: cancelOrderModel)

        }, negativeActionTitle: "取消") { (alert) in

        }
        self.present(alertController, animated: true, completion: nil)
    }

    // MARK: - Getter / Setter
    override func setupSubViews() {
        tableView = createTableView(delegate: self, style: .plain, needRefresh: true)
        tableView?.frame = CGRect(x: 0, y: 0, width: GlobalConstants.screenWidth, height: GlobalConstants.tableViewHeight - 44)
        tableView?.allowsSelection = false
        view.addSubview(tableView!)
    }
}

extension CancelOrderViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return cancelOrderArray.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CancelOrderCell.cellWithTableView(tableView: tableView) as! CancelOrderCell
        cell.delegate = self
        cell.setupModel(cancelOrderModel: cancelOrderArray[indexPath.section])
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeader: UIView = UIView(frame: CGRect(x: 0, y: 0, width: GlobalConstants.screenWidth, height: 15))
        sectionHeader.backgroundColor = AppConstants.gapColor;
        return sectionHeader;
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
