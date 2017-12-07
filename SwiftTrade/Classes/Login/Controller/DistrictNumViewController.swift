//
//  DistrictNumViewController.swift
//  SwiftTrade
//
//  Created by yaoliangjun on 2017/12/5.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//  选择区号页面

import UIKit

class DistrictNumViewController: BaseTableViewController {

    var districtArray: [DistrictModel]?
    var resultArray: [DistrictModel]?
    var searchController: UISearchController?

    typealias SelectedDistrictNumBlock = (_ districtModel: DistrictModel?) -> ()
    var didSelectedDistrictNumBlock: SelectedDistrictNumBlock!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.setBackgroundImage(UIImage.createImage(color: AppConstants.navigationBarColor), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage.createImage(color: AppConstants.navigationBarColor)
    }

    override func setupSubViews() {
        self.title = "选择国家/地区"
        self.automaticallyAdjustsScrollViewInsets = false
        self.definesPresentationContext = true

        tableView = createTableView(style: .grouped)
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.rowHeight = 60
        view.addSubview(tableView!)

        searchController = UISearchController(searchResultsController: nil)
        searchController?.searchBar.sizeToFit()
        searchController?.dimsBackgroundDuringPresentation = false // 因为在当前控制器展示结果, 所以不需要这个透明视图
        searchController?.hidesNavigationBarDuringPresentation = true // 是否隐藏导航栏
        searchController?.searchResultsUpdater = self // 设置结果更新代理
        searchController?.searchBar.backgroundImage = UIImage.createImage(color: AppConstants.navigationBarColor)
        tableView?.tableHeaderView = searchController?.searchBar
    }
}

extension DistrictNumViewController: UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {

    func numberOfSections(in tableView: UITableView) -> Int {
        if (searchController?.isActive)! {
            return (resultArray?.count)!
        }

        return (districtArray?.count)!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = DistrictNumCell.cellWithTableView(tableView: tableView) as! DistrictNumCell
        var model: DistrictModel? = nil
        if (searchController?.isActive)! {
            model = resultArray![indexPath.section]
        } else {
            model = districtArray![indexPath.section]
        }
        cell.setupDistrictModel(districtModel: model!)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        var model: DistrictModel? = nil
        if (searchController?.isActive)! {
            model = resultArray![indexPath.section]
        } else {
            model = districtArray![indexPath.section]
        }

        if let block = didSelectedDistrictNumBlock {
            block(model)
        }
        navigationController?.popViewController(animated: true)
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

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.00001
    }

    // MARK: - UISearchResultsUpdating
    func updateSearchResults(for searchController: UISearchController) {
        let filterString = searchController.searchBar.text
        resultArray = districtArray?.filter( { (districtModel: DistrictModel) -> Bool in
            return (districtModel.chineseName?.contains(filterString!))! ||      (districtModel.nationalName?.contains(filterString!))! || (districtModel.code?.contains(filterString!))!
        })

        tableView?.reloadData()
    }
}
