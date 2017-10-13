//
//  RegisterViewController.swift
//  SwiftTrade
//
//  Created by yaoliangjun on 2017/10/13.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//

import UIKit

class RegisterViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSubViews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 设置导航栏透明和去掉导航栏底部的黑线
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func setupSubViews() {
        //
        let backgroundView = UIImageView(frame: CGRect(x: 0, y: 0, width: GlobalConstants.screenWidth, height: GlobalConstants.screenHeight))
        backgroundView.image = UIImage(named: "login_background")
        view.addSubview(backgroundView)
        
        //
        let titleLabel = UILabel(frame: CGRect(x: 0, y: GlobalConstants.navigationBarHeight, width: GlobalConstants.screenWidth, height: 30), text: "注册", textAlignment: .center, textColor: AppConstants.goldColor, font: UIFont.systemFont(ofSize: 20))
        view.addSubview(titleLabel)
        
        // 账号
        let accountImageView = UIImageView(frame: CGRect(x: 10, y: 15, width: 15, height: 20))
        accountImageView.image = UIImage(named: "login_register_phone")
        let accountLeftView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 50))
        accountLeftView.addSubview(accountImageView)
        
        let accountTextField = UITextField(frame: CGRect(x: 30, y: titleLabel.bottom + 30, width: GlobalConstants.screenWidth - 60, height: 50), text: "", textAlignment: .left, textColor: UIColor.white, placeholder: "请输入注册手机号", placeholderColor: UIColor.white, font: UIFont.systemFont(ofSize: 16), leftView: accountLeftView)
        view.addSubview(accountTextField)
        
        // 分割线
        let accountSeparateLine = UILabel(frame: CGRect(x: accountTextField.left, y: accountTextField.bottom, width: accountTextField.width, height: 0.5))
        accountSeparateLine.backgroundColor = UIColor.white
        view.addSubview(accountSeparateLine)
        
        // 验证码
        let codeImageView = UIImageView(frame: CGRect(x: 10, y: 15, width: 15, height: 20))
        codeImageView.image = UIImage(named: "login_verification_code")
        let codeLeftView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 50))
        codeLeftView.addSubview(codeImageView)
        
        let codeTextField = UITextField(frame: CGRect(x: accountSeparateLine.left, y: accountSeparateLine.bottom + 10, width: accountSeparateLine.width, height: 50), text: "", textAlignment: .left, textColor: UIColor.white, placeholder: "请输入验证码", placeholderColor: UIColor.white, font: UIFont.systemFont(ofSize: 16), leftView: codeLeftView)
        view.addSubview(codeTextField)
        
        // 分割线
        let codeSeparateLine = UILabel(frame: CGRect(x: codeTextField.left, y: codeTextField.bottom, width: codeTextField.width, height: 0.5))
        codeSeparateLine.backgroundColor = UIColor.white
        view.addSubview(codeSeparateLine)
    }
}
