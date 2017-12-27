//
//  InformationViewController.swift
//  SwiftTrade
//
//  Created by Jerry Yao on 2017/10/14.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//  资讯页面

import UIKit

class InformationViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchInfoList()
    }

    // 获取资讯
    func fetchInfoList() {
        let params = ["page" : pageNumber, "rows" : pageCount]
        InfoServices.fetchInfoList(params: params, showHUD: true, success: { (infoArray) in
            self.infoArray = infoArray
            self.tableView?.reloadData()

        }) { (error) in

        }
    }

    // MARK: - Private Method
    override func pullDownHandle() {
        fetchInfoList()
    }

    // MARK: - Getter / Setter
    override func setupSubViews() {
        tableView = createTableView(delegate: self, style: .plain, needRefresh: true)
        tableView?.tableHeaderView = tableHeaderView
        tableView?.backgroundColor = AppConstants.gapColor
        view.addSubview(tableView!)
    }

    lazy var infoArray: [InfoModel]? = {
        return Array<InfoModel>()
    }()

    lazy var tableHeaderView: UIView = {
        let tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: GlobalConstants.screenWidth, height: GlobalConstants.screenHeight / 3.8))
        let imageView = UIImageView(image: UIImage(named: "account_banner"))
        imageView.frame = CGRect(x: 0, y: 0, width: GlobalConstants.screenWidth, height: GlobalConstants.screenHeight / 3.8)
        tableHeaderView.addSubview(imageView)

        return tableHeaderView
    }()
}

extension InformationViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return (infoArray?.count) ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = InfoCell.cellWithTableView(tableView: tableView) as! InfoCell
        cell.setupInfoModel(infoModel: infoArray![indexPath.section])
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let infoDetailVC = InformationDetailViewController()
        infoDetailVC.infoModel = infoArray?[indexPath.section]
        navigationController?.pushViewController(infoDetailVC, animated: true)
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
}
