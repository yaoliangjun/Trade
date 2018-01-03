//
//  StepperView.swift
//  SwiftTrade
//
//  Created by yaoliangjun on 2017/12/25.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//

import UIKit

@objc protocol StepperViewDelegate {

    func stepperView(stepperView: StepperView, btnTag: Int, value: String?)
    func stepperView(stepperView: StepperView, textFieldValue: String?)
}

class StepperView: UIView, UITextFieldDelegate {

    var minusBtn: UIButton?
    var plusBtn: UIButton?
    var stepperTextField: UITextField?
    var placeHolder: String?
    weak var delegate: StepperViewDelegate?
    
    convenience init(delegate: StepperViewDelegate?, placeHolder: String?) {
        self.init()
        self.delegate = delegate
        self.placeHolder = placeHolder
        setupSubViews()
    }

    init() {
        super.init(frame: CGRect.zero)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - UITextFieldDelegate
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        delegate?.stepperView(stepperView: self, textFieldValue: textField.text)

        return true
    }

    // MARK: - Private Method
    func stepperBtnClick(btn: UIButton) {
        var mValue = 0.00
        var value = stepperTextField?.text
        if btn.tag == 10 {
            // 减
            if (value?.isEmpty)! || Double(value!)! <= 1  {
                stepperTextField?.text = nil

            } else {
                mValue = Double(value!)! - 1
                stepperTextField?.text = String(format: "%.2f", mValue)
            }

        } else {
            // 加
            if (value?.isEmpty)! || Double(value!)! <= 0  {
                value = "0.00"
            }
            mValue = Double(value!)! + 1
            stepperTextField?.text = String(format: "%.2f", mValue)
        }

        delegate?.stepperView(stepperView: self, btnTag: btn.tag, value: String(mValue))
    }

    func stepperValue() -> Double {
        let value = stepperTextField?.text
        if !(value?.isEmpty)! {
            return Double(value!)!
        }
        
        return 0
    }

    func setStepperValue(value: String?) {
        stepperTextField?.text = value
    }
    
    // 设置子View
    func setupSubViews() {

        self.layer.borderColor = AppConstants.greyTextColor.cgColor;
        self.layer.borderWidth = 0.3;

        minusBtn = UIButton(image: UIImage(named: "trading_the-sale_normal"), highlightedImage: UIImage(named: "trading_the-sale_press"), backgroundColor: nil, target: self, selector: #selector(stepperBtnClick))
        minusBtn?.tag = 10
        self.addSubview(minusBtn!)
        minusBtn?.snp.makeConstraints({ (make) in
            make.left.top.bottom.equalTo(self)
            make.width.equalTo(40)
        })

        stepperTextField = UITextField(text: nil, textAlignment: .center, textColor: AppConstants.greyTextColor, placeholder: placeHolder ?? "", placeholderColor: GlobalConstants.placeholderColor, font: UIFont.systemFont(ofSize: 13))
        stepperTextField?.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 5))
        stepperTextField?.leftViewMode = .always
        stepperTextField?.delegate = self
        stepperTextField?.keyboardType = .decimalPad
        self.addSubview(stepperTextField!)
        stepperTextField?.snp.makeConstraints({ (make) in
            make.left.equalTo(minusBtn!.snp.right)
            make.top.bottom.height.equalTo(self)
        })

        plusBtn = UIButton(image: UIImage(named: "trading_premium_normal"), highlightedImage: UIImage(named: "trading_premium_press"), backgroundColor: nil, target: self, selector: #selector(stepperBtnClick))
        plusBtn?.tag = 20
        self.addSubview(plusBtn!)
        plusBtn?.snp.makeConstraints({ (make) in
            make.left.equalTo(stepperTextField!.snp.right);
            make.top.bottom.right.equalTo(self);
            make.width.equalTo(minusBtn!);
        })
    }
}
