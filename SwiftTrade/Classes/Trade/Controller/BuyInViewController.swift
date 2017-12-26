//
//  BuyInViewController.swift
//  SwiftTrade
//
//  Created by yaoliangjun on 2017/12/7.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//  买入页面

import UIKit

class BuyInViewController: BaseViewController, StepperViewDelegate {

    private var priceType: AppConstants.PriceType?
    private var contentView: UIView?
    private var availableAssetLabel: UILabel?
    private var limitedPriceBtn: UIButton?
    private var marketPriceBtn: UIButton?
    private var stepperView: StepperView?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    // MARK: - StepperViewDelegate
    func stepperView(stepperView: StepperView, textFieldValue: String?) {
        // print("textFieldValue: \(textFieldValue)")
    }

    func stepperView(stepperView: StepperView, btnTag: Int, value: String?) {
        // print("btnTag: \(btnTag), value: \(value)")
    }

    // MARK: - Private Method
    func buyInBtnClick() {

    }

    func rechargeBtnClick() {

    }

    func singleChoiceBtnClick(btn: UIButton) {

        if btn.tag == 100 {
            print("限价")
            limitedPriceBtn?.backgroundColor = AppConstants.goldColor
            marketPriceBtn?.backgroundColor = UIColor.white
            priceType = .limited

        } else {
            print("市价")
            marketPriceBtn?.backgroundColor = AppConstants.goldColor
            limitedPriceBtn?.backgroundColor = UIColor.white
            priceType = .market
        }
    }

    func chooseCoinBtnClick() {
        print(#function)
    }

    func positionBtnClick(btn: UIButton) {

        let tag = btn.tag
        for subView in positionView.subviews {
            if !subView.isKind(of: UIButton.self) {
                continue
            }

            let btn = subView as! UIButton
            if btn.tag == tag {
                btn.setBackgroundImage(UIImage(named: "trading_all-warehouse_normal"), for: .normal)
                btn.setBackgroundImage(UIImage(named: "trading_all-warehouse_normal"), for: .highlighted)

            } else {
                btn.setBackgroundImage(UIImage(named: "trading_all-warehouse_press"), for: .normal)
                btn.setBackgroundImage(UIImage(named: "trading_all-warehouse_press"), for: .highlighted)
            }
        }
    }

    // MARK: - Getter / Setter
    override func setupSubViews() {
        priceType = .limited

        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(view).inset(UIEdgeInsetsMake(15, 0, 0, 0))
        }

        contentView = UIView()
        scrollView.addSubview(contentView!)
        contentView!.snp.makeConstraints { (make) in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }

        // 顶部View
        contentView!.addSubview(topView)
        topView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(contentView!)
            make.height.equalTo(140)
        }

        // 左边View
        contentView!.addSubview(leftView)
        leftView.snp.makeConstraints { (make) in
            make.left.equalTo(view)
            make.top.equalTo(topView.snp.bottom)
            make.bottom.equalTo(positionView.snp.bottom)
        }

        // 右边View
        contentView!.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.equalTo(leftView.snp.right)
            make.right.equalTo(view)
            make.top.width.equalTo(leftView)
            make.height.equalTo(30 * 8 + 40)
        }

        // 买入
        let buyInBtn = UIButton(title: "买入", titleColor: AppConstants.greyTextColor, highlightedTitleColor: AppConstants.greyTextColor, font: UIFont.systemFont(ofSize: 18), backgroundImage: UIImage.createImage(color: AppConstants.goldColor), highlightedBackgroundImage: UIImage.createImage(color: UIColor.brown), borderWidth: 0, borderColor: nil, cornerRadius: 5, target: self, selector: #selector(buyInBtnClick))
        contentView!.addSubview(buyInBtn)
        buyInBtn.snp.makeConstraints { (make) in
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.top.equalTo(tableView.snp.bottom).offset(30)
            make.height.equalTo(44)
        }

        contentView!.snp.makeConstraints { (make) in
            make.bottom.equalTo(buyInBtn.snp.bottom).offset(30)
        }
    }

    private lazy var scrollView: UIScrollView = {
        var scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false

        return scrollView
    }()

    private lazy var topView: UIView = {
        var topView = UIView()
        topView.backgroundColor = UIColor.white

        var availableAssetTextLabel = UILabel(text: "可用资产", textColor: AppConstants.greyTextColor, font: UIFont.systemFont(ofSize: 14))
        topView.addSubview(availableAssetTextLabel)
        availableAssetTextLabel.snp.makeConstraints({ (make) in
            make.left.equalTo(topView).offset(10)
            make.top.equalTo(topView).offset(25)
            make.width.lessThanOrEqualTo(120)
            make.height.equalTo(20)
        })
        availableAssetTextLabel.setContentHuggingPriority(1000, for: .horizontal)

        // 可用资产
        self.availableAssetLabel = UILabel(text: "0.00", textColor: UIColor.orange, font: UIFont.systemFont(ofSize: 16))
        topView.addSubview(self.availableAssetLabel!)

        let rechargeBtn = UIButton(title: "充值", titleColor: AppConstants.greyTextColor, highlightedTitleColor: AppConstants.greyTextColor, font: UIFont.systemFont(ofSize: 15), backgroundColor: AppConstants.goldColor, cornerRadius: 4, target: self, selector: #selector(rechargeBtnClick))
        topView.addSubview(rechargeBtn)

        self.availableAssetLabel!.snp.makeConstraints({ (make) in
            make.left.equalTo(availableAssetTextLabel.snp.right).offset(5)
            make.centerY.equalTo(availableAssetTextLabel)
            make.right.equalTo(rechargeBtn.snp.left).offset(-10)
            make.height.equalTo(20)
        })

        rechargeBtn.snp.makeConstraints({ (make) in
            make.centerY.equalTo(availableAssetTextLabel)
            make.right.equalTo(topView).offset(-10)
            make.width.equalTo(70)
            make.height.equalTo(35)
        })

        // 分割线
        var lineView = UIView()
        lineView.backgroundColor = AppConstants.separateLineColor
        topView.addSubview(lineView)
        lineView.snp.makeConstraints({ (make) in
            make.left.right.equalTo(topView)
            make.top.equalTo(availableAssetTextLabel.snp.bottom).offset(20)
            make.height.equalTo(0.25)
        })

        var btnContentView = UIView()
        btnContentView.layer.borderColor = AppConstants.separateLineColor.cgColor;
        btnContentView.layer.borderWidth = 0.3;
        topView.addSubview(btnContentView)
        btnContentView.snp.makeConstraints({ (make) in
            make.left.equalTo(topView).offset(10)
            make.right.equalTo(topView).offset(-10)
            make.top.equalTo(lineView.snp.bottom).offset(20)
            make.height.equalTo(35)
        })

        self.limitedPriceBtn = UIButton(title: "限价", titleColor: AppConstants.greyTextColor, highlightedTitleColor: AppConstants.greyTextColor, font: UIFont.systemFont(ofSize: 14), backgroundColor: AppConstants.goldColor, cornerRadius: 0, target: self, selector: #selector(singleChoiceBtnClick))
        self.limitedPriceBtn?.tag = 100
        btnContentView.addSubview(self.limitedPriceBtn!)

        self.marketPriceBtn = UIButton(title: "市价", titleColor: AppConstants.greyTextColor, highlightedTitleColor: AppConstants.greyTextColor, font: UIFont.systemFont(ofSize: 14), backgroundColor: UIColor.white, cornerRadius: 0, target: self, selector: #selector(singleChoiceBtnClick))
        self.marketPriceBtn?.tag = 200
        btnContentView.addSubview(self.marketPriceBtn!)

        self.limitedPriceBtn!.snp.makeConstraints({ (make) in
            make.left.top.height.equalTo(btnContentView)
        })

        self.marketPriceBtn!.snp.makeConstraints({ (make) in
            make.left.equalTo(self.limitedPriceBtn!.snp.right)
            make.top.right.equalTo(btnContentView)
            make.width.height.equalTo(self.limitedPriceBtn!)
        })

        return topView
    }()

    private lazy var leftView: UIView = {
        var leftView = UIView()
        leftView.backgroundColor = UIColor.white

        // 选择币种
        leftView.addSubview(self.chooseCoinTextField)
        self.chooseCoinTextField.snp.makeConstraints({ (make) in
            make.left.equalTo(leftView).offset(10);
            make.right.equalTo(leftView).offset(-5);
            make.top.equalTo(leftView);
            make.height.equalTo(40);
        })

        // 价格输入控件
        self.stepperView = StepperView(delegate: self, placeHolder: "买入价")
        leftView.addSubview(self.stepperView!)
        self.stepperView!.snp.makeConstraints({ (make) in
            make.left.width.height.equalTo(self.chooseCoinTextField)
            make.top.equalTo(self.chooseCoinTextField.snp.bottom).offset(30)
        })

        // 约可买
        leftView.addSubview(self.maxTextField)
        self.maxTextField.snp.makeConstraints({ (make) in
            make.left.width.height.equalTo(self.chooseCoinTextField);
            make.top.equalTo(self.stepperView!.snp.bottom).offset(30);
        })

        // 仓位
        leftView.addSubview(self.positionView)
        self.positionView.snp.makeConstraints({ (make) in
            make.left.right.equalTo(self.maxTextField)
            make.top.equalTo(self.maxTextField.snp.bottom).offset(30)
            make.height.equalTo(30)
        })

        return leftView
    }()

    private lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.rowHeight = 30
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.isScrollEnabled = false
        tableView.tableFooterView = UIView()

        return tableView
    }()

    private lazy var chooseCoinTextField: UITextField = {
        let arrowImageView = UIImageView(frame: CGRect(x: 0, y: 17, width: 11, height: 6), imageName: "arrow_down")
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 40))
        rightView.addSubview(arrowImageView)

        var chooseCoinTextField = UITextField(text: nil, textAlignment: nil, textColor: AppConstants.greyTextColor, placeholder: "请选择币种", placeholderColor: GlobalConstants.placeholderColor, font: UIFont.systemFont(ofSize: 13), borderWidth: 0.3, borderColor: AppConstants.greyTextColor, cornerRadius: 0, leftView: UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10)), leftViewMode: .always, rightView: rightView, rightViewMode: .always)

        let chooseCoinBtn = UIButton(frame: CGRect.zero, target: self, selector: #selector(chooseCoinBtnClick))
        chooseCoinTextField.addSubview(chooseCoinBtn)
        chooseCoinBtn.snp.makeConstraints({ (make) in
            make.edges.equalTo(chooseCoinTextField)
        })
        return chooseCoinTextField
    }()

    private lazy var maxTextField: UITextField = {
        let maxLabel = UILabel(frame: CGRect(x: 10, y: 0, width: 60, height: 40), text: "预计可买", textColor: AppConstants.greyTextColor, font: UIFont.systemFont(ofSize: 13))
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 70, height: 40))
        leftView.addSubview(maxLabel)

        var maxTextField = UITextField(text: nil, textAlignment: nil, textColor: AppConstants.goldColor, placeholder: "0.00", placeholderColor: AppConstants.goldColor, font: UIFont.systemFont(ofSize: 13), borderWidth: 0.3, borderColor: AppConstants.greyTextColor, cornerRadius: 0, leftView: leftView, leftViewMode: .always)
        maxTextField.keyboardType = .decimalPad

        return maxTextField
    }()

    private lazy var positionView: UIView = {
        var positionView = UIView()

        let fullPartBtn = UIButton(title: "全仓", titleColor: AppConstants.greyTextColor, highlightedTitleColor: AppConstants.greyTextColor, font: UIFont.systemFont(ofSize: 13), backgroundImage: UIImage(named: "trading_all-warehouse_normal"), highlightedBackgroundImage: UIImage(named: "trading_all-warehouse_press"), target: self, selector: #selector(positionBtnClick))
        fullPartBtn.tag = AppConstants.Postion.full.rawValue
        positionView.addSubview(fullPartBtn)
        fullPartBtn.snp.makeConstraints({ (make) in
            make.top.left.height.equalTo(positionView)
        })

        let halfPartBtn = UIButton(title: "1/2", titleColor: AppConstants.greyTextColor, highlightedTitleColor: AppConstants.greyTextColor, font: UIFont.systemFont(ofSize: 13), backgroundImage: UIImage(named: "trading_all-warehouse_press"), highlightedBackgroundImage: UIImage(named: "trading_all-warehouse_press"), target: self, selector: #selector(positionBtnClick))
        halfPartBtn.tag = AppConstants.Postion.oneHalf.rawValue
        positionView.addSubview(halfPartBtn)
        halfPartBtn.snp.makeConstraints({ (make) in
            make.left.equalTo(fullPartBtn.snp.right).offset(5)
            make.top.height.width.equalTo(fullPartBtn)
        })

        let thirdPartBtn = UIButton(title: "1/3", titleColor: AppConstants.greyTextColor, highlightedTitleColor: AppConstants.greyTextColor, font: UIFont.systemFont(ofSize: 13), backgroundImage: UIImage(named: "trading_all-warehouse_press"), highlightedBackgroundImage: UIImage(named: "trading_all-warehouse_press"), target: self, selector: #selector(positionBtnClick))
        thirdPartBtn.tag = AppConstants.Postion.oneThird.rawValue
        positionView.addSubview(thirdPartBtn)
        thirdPartBtn.snp.makeConstraints({ (make) in
            make.left.equalTo(halfPartBtn.snp.right).offset(5)
            make.top.height.width.equalTo(fullPartBtn)
        })

        let fourthPartBtn = UIButton(title: "1/4", titleColor: AppConstants.greyTextColor, highlightedTitleColor: AppConstants.greyTextColor, font: UIFont.systemFont(ofSize: 13), backgroundImage: UIImage(named: "trading_all-warehouse_press"), highlightedBackgroundImage: UIImage(named: "trading_all-warehouse_press"), target: self, selector: #selector(positionBtnClick))
        fourthPartBtn.tag = AppConstants.Postion.oneFourth.rawValue
        positionView.addSubview(fourthPartBtn)
        fourthPartBtn.snp.makeConstraints({ (make) in
            make.left.equalTo(thirdPartBtn.snp.right).offset(5)
            make.top.height.width.equalTo(fullPartBtn)
            make.right.equalTo(positionView)
        })

        return positionView
    }()
}

extension BuyInViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MarketPriceCell.cellWithTableView(tableView: tableView)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return nil
        }

        let sectionHeader: UIView = UIView(frame: CGRect(x: 0, y: 0, width: GlobalConstants.screenWidth, height: 15))
        sectionHeader.backgroundColor = UIColor.white

        let currentPriceBtn = ImageButton(title: "520000.00", titleColor: AppConstants.blueTextColor, textAlignment: nil, font: UIFont.systemFont(ofSize: 14), image: UIImage(named: "trading_down-arrow"), target: nil, selector: nil)
        sectionHeader.addSubview(currentPriceBtn)
        currentPriceBtn.snp.makeConstraints { (make) in
            make.edges.equalTo(sectionHeader)
        }

        return sectionHeader
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }

        return 40
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.layoutMargins = UIEdgeInsets.zero
    }
}

