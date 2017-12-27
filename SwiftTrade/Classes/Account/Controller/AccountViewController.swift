//
//  AccountViewController.swift
//  SwiftTrade
//
//  Created by Jerry Yao on 2017/10/14.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//  账户页面

import UIKit

class AccountViewController: BaseTableViewController {

    var assetModel: MyAssetModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAssets()
    }

    // MARK: - Private Method
    // 获取我的资产
    func fetchAssets() {
        AccountServices.myAssets(params: [:], showHUD: true, success: { (response) in
            self.assetModel = response
            self.tableView?.reloadData()

        }) { (error) in
            
        }
    }

    // 下拉刷新
    override func pullDownHandle() {
        fetchAssets()
    }

    // 个人中心
    func personalCenterBtnClick() {

    }

    // 设置
    func settingBtnClick() {
        let settingVC = SettingViewController()
        navigationController?.pushViewController(settingVC, animated: true)
    }

    // MARK: - Getter / Setter
    override func setupSubViews() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "account_personal-center"), style: .plain, target: self, action: #selector(personalCenterBtnClick))

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "account_set-up"), style: .plain, target: self, action: #selector(settingBtnClick))

        tableView = createTableView(delegate: self, style: .plain, needRefresh: true)
        tableView?.separatorColor = AppConstants.grayColor
        tableView?.separatorStyle = .singleLine
        view.addSubview(tableView!)
    }

    lazy var sectionTwoArray: [[String: String]] = {
        var sectionTwoArray = [["我的持仓": "account_position"],
                               ["充值提现": "account_cash-value"],
                               ["虚拟币转入": "account_virtual-currency-transfer"],
                               ["虚拟币转出": "account_virtual-currency"]]

        return sectionTwoArray
    }()

    lazy var sectionThreeArray: [[String: String]] = {
        var sectionThreeArray = [["委托管理": "account_entrusted-management"],
                                 ["成交记录": "account_transaction-record"]]

        return sectionThreeArray
    }()
}

extension AccountViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return 4
        } else if section == 2 {
            return 2
        }
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let section = indexPath.section
        if section == 0 {
            let cell = AccountInfoCell.cellWithTableView(tableView: tableView) as! AccountInfoCell
            cell.textLabel?.text = nil
            cell.accessoryType = .none
            cell.selectionStyle = .none
            cell.setupAssetInfo(assetModel: assetModel)
            
            return cell

        } else {
            let cellReuseId = "CellReuseId"
            var cell = tableView.dequeueReusableCell(withIdentifier: cellReuseId)
            if cell == nil {
                cell = UITableViewCell(style: .default, reuseIdentifier: cellReuseId)
                cell?.textLabel?.textColor = AppConstants.greyTextColor
                cell?.textLabel?.font = UIFont.systemFont(ofSize: 14)
            }
            cell?.selectionStyle = .default

            if section == 1 {
                let dict: [String: String] = sectionTwoArray[indexPath.row];
                cell?.textLabel?.text = dict.keys.first;
                cell?.imageView?.image = UIImage(named: dict.values.first!)
                cell?.accessoryType = .disclosureIndicator

            } else if section == 2 {
                let dict: [String: String] = sectionThreeArray[indexPath.row];
                cell?.textLabel?.text = dict.keys.first;
                cell?.imageView?.image = UIImage(named: dict.values.first!)
                cell?.accessoryType = .disclosureIndicator
            }
            
            return cell!
        }
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
        if indexPath.section == 0 {
            return 120
        }
        return 50
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.layoutMargins = UIEdgeInsets.zero
    }
}
