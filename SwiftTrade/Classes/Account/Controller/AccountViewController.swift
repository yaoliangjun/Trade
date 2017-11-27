//
//  AccountViewController.swift
//  SwiftTrade
//
//  Created by Jerry Yao on 2017/10/14.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//  账户页面

import UIKit

class AccountViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
    }

    func setupSubViews() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "account_personal-center"), style: .plain, target: self, action: #selector(personalCenterBtnClick))

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "account_set-up"), style: .plain, target: self, action: #selector(settingBtnClick))

        tableView = createTableView(style: .plain, needRefresh: true)
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.separatorColor = AppConstants.gapColor
        tableView?.separatorStyle = .singleLine
        view.addSubview(tableView!)
    }

    // MARK: - Private Method
    // 个人中心
    func personalCenterBtnClick() {

    }

    // 设置
    func settingBtnClick() {

    }

    // MARK: - Getter / Setter
    lazy var sectionTwoTitleArray: [String] = {
        var sectionTwoTitleArray = ["我的持仓", "充值提现", "虚拟币转入", "虚拟币转出"]

        return sectionTwoTitleArray
    }()

    lazy var sectionThreeTitleArray: [String] = {
        var sectionThreeTitleArray = ["委托管理", "成交记录"]

        return sectionThreeTitleArray
    }()
}

extension AccountViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return 4
        } else if section == 2 {
            return 2
        }
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellReuseId = "CellReuseId"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellReuseId)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellReuseId)
            cell?.textLabel?.textColor = AppConstants.greyTextColor
            cell?.textLabel?.font = UIFont.systemFont(ofSize: 14)
        }


        let section = indexPath.section
        if section == 0 {
            cell?.textLabel?.text = nil

        } else if section == 1 {
            cell?.textLabel?.text = sectionTwoTitleArray[indexPath.row];

        } else if section == 2 {
            cell?.textLabel?.text = sectionThreeTitleArray[indexPath.row];
        }

        return cell!
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
