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
        fetchMessages()
    }

    // MARK: - Private Method
    func fetchMessages() {
        let params = ["page": pageNumber, "rows": pageCount]
        HomeServices.fetchMessages(params: params, showHUD: true, success: { (response) in
//            self.messageArray = response
            self.tableView?.reloadData()

        }) { (error) in

        }
    }

    // 下拉刷新
    override func pullDownHandle() {
        fetchMessages()
    }

    // 清空
    func clearAllMessage() {

        let alertController = UIAlertController(title: "", message: "确定要清空所有消息吗?", preferredStyle: .actionSheet, positiveActionTitle: "确定", positiveCompletionHandle: { (alert) in

        }, negativeActionTitle: "取消") { (alert) in

        }
        self.present(alertController, animated: true, completion: nil)
    }

    // MARK: - Getter / Setter
    override func setupSubViews() {
        self.title = "我的消息"
        tableView = createTableView(delegate: self, style: .plain, needRefresh: true)
        view.addSubview(tableView!)

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "清空", titleColor: AppConstants.goldColor, font: UIFont.systemFont(ofSize: 16), target: self, selector: #selector(clearAllMessage))
    }

    fileprivate lazy var messageArray: [MessageModel] = {
        var messageArray = [MessageModel]()
        let msg1 = MessageModel()
        msg1.name = "系统消息"
        msg1.noticeContent = "在过一年内，比特币价格已经上涨近2000%，最近它又急剧下挫，这一切都促使监管部门发出了特别警告。"
        msg1.createTime = "1514449546000"
        messageArray.append(msg1)

        let msg2 = MessageModel()
        msg2.name = "推送消息"
        msg2.noticeContent = "第四大谜团黑客会毁了比特币吗？比特币的最大的负面消息，就是黑客问题，自从比特币入市以来，不断地出现黑客的入侵事件。"
        msg2.createTime = "1514434546000"
        messageArray.append(msg2)

        let msg3 = MessageModel()
        msg3.name = "系统消息"
        msg3.noticeContent = "随着比特币价格飙升，大量投资者和投机人士涌向数字货币交易，虚拟货币市场的网络安全问题也急需重视。"
        msg3.createTime = "1514449900000"
        messageArray.append(msg3)

        return messageArray
    }()
}

extension MessageViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return messageArray.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MessageCell.cellWithTableView(tableView: tableView) as! MessageCell
        cell.setupModel(messageModel: messageArray[indexPath.section])
        
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
