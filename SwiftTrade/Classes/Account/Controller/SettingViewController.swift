//
//  SettingViewController.swift
//  SwiftTrade
//
//  Created by yaoliangjun on 2017/11/28.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//

import UIKit

class SettingViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Private Method
    func logoutBtnClick() {
        let alertController = UIAlertController(title: "提示", message: "确定要退出登录吗?", preferredStyle: .alert, positiveActionTitle: "确定", positiveCompletionHandle: { (alert) in
            (UIApplication.shared.delegate as! AppDelegate).logout()

        }, negativeActionTitle: "取消") { (alert) in

        }
        self.present(alertController, animated: true, completion: nil)
    }

    // MARK: - Getter / Setter
    override func setupSubViews() {
        title = "设置"
        tableView = createTableView(delegate: self, style: .plain)
        tableView?.separatorColor = AppConstants.grayColor
        tableView?.separatorStyle = .singleLine
        tableView?.tableFooterView = tableFooterView
        view.addSubview(tableView!)
    }

    lazy var tableFooterView: UIView = {

        let tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: GlobalConstants.screenWidth, height: 100))
        let logoutBtn = UIButton(title: "退出登录", titleColor: AppConstants.redTextColor, highlightedTitleColor: UIColor.red, font: UIFont.systemFont(ofSize: 14), backgroundColor: UIColor.white, cornerRadius: 0, borderWidth: 0, borderColor: nil, target: self, selector: #selector(logoutBtnClick))
            tableFooterView.addSubview(logoutBtn)
            logoutBtn.snp.makeConstraints { (make) in
                make.left.right.equalTo(tableFooterView)
                make.top.equalTo(tableFooterView).offset(15)
                make.height.equalTo(50)
            }

        return tableFooterView

    }()

    lazy var sectionOneArray: [[String: String]] = {
        let sectionOneArray = [["行情刷新频率": "account_refresh-rate"]]
        return sectionOneArray
    }()

    lazy var sectionTwoArray: [[String: String]] = {
        let sectionTwoArray = [["联系客服": "account_online-service"], ["帮助中心": "account_help-center"]]
        return sectionTwoArray
    }()

    lazy var sectionThreeArray: [[String: String]] = {
        let sectionThreeArray = [["意见反馈": "account_feedback"], ["关于我们": "account_about-us"]]
        return sectionThreeArray
    }()
}

extension SettingViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 2
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellReuseId = "settingCellReuseId"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellReuseId)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellReuseId)
            cell?.textLabel?.textColor = AppConstants.greyTextColor
            cell?.textLabel?.font = UIFont.systemFont(ofSize: 14)
        }

        var dict: [String: String]? = nil
        let section = indexPath.section
        if section == 0 {
            dict = sectionOneArray[indexPath.row];

        } else if section == 1 {
            dict = sectionTwoArray[indexPath.row];

        } else {
            dict = sectionThreeArray[indexPath.row];
        }

        cell?.textLabel?.text = dict!.keys.first;
        cell?.imageView?.image = UIImage(named: dict!.values.first!)
        cell?.accessoryType = .disclosureIndicator

        return cell!
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
}
