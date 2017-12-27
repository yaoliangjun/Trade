//
//  MessageViewController.swift
//  SwiftTrade
//
//  Created by yaoliangjun on 2017/12/27.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//

import UIKit

class MessageViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func setupSubViews() {
        self.title = "我的消息"
        tableView = createTableView(delegate: self, style: .plain, needRefresh: true)
        view.addSubview(tableView!)
    }
}

extension MessageViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MessageCell.cellWithTableView(tableView: tableView)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeader: UIView = UIView(frame: CGRect(x: 0, y: 0, width: GlobalConstants.screenWidth, height: 1))
        sectionHeader.backgroundColor = AppConstants.gapColor;
        return sectionHeader
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
