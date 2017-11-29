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

        setupSubViews()
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
    func setupSubViews() {
        tableView = createTableView(style: .plain, needRefresh: true)
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.rowHeight = 70
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

extension InformationViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return (infoArray?.count) ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = InfoCell.cellWithTableView(tableView: tableView) as! InfoCell
        cell.setupInfoModel(infoModel: infoArray![indexPath.section])
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let infoDetailVC = InformationDetailViewController()
        infoDetailVC.infoModel = infoArray?[indexPath.section]
        navigationController?.pushViewController(infoDetailVC, animated: true)
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
