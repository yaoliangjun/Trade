//
//  LoginViewController.swift
//  SwiftTrade
//
//  Created by yaoliangjun on 2017/10/12.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//  登录页面

import UIKit

class LoginViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupSubViews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    // 设置子View
    func setupSubViews() {
        title = "登录"
        
        //
        let backgroundView = UIImageView(frame: CGRect(x: 0, y: 0, width: GlobalConstants.screenWidth, height: GlobalConstants.screenHeight))
        backgroundView.image = UIImage(named: "login_background")
        view.addSubview(backgroundView)
        
        //
        let titleLabel = UILabel(frame: CGRect(x: 0, y: GlobalConstants.navigationBarHeight, width: GlobalConstants.screenWidth, height: 30))
        titleLabel.textAlignment = .center
        titleLabel.text = "登录"
        titleLabel.textColor = AppConstants.goldColor
        
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        view.addSubview(titleLabel)
        
        // 账号
        let accountImageView = UIImageView(frame: CGRect(x: 10, y: 15, width: 17, height: 20))
        accountImageView.image = UIImage(named: "login_account")
        let accountLeftView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 50))
        accountLeftView.addSubview(accountImageView)
        
        let accountTextField = UITextField(frame: CGRect(x: 30, y: titleLabel.bottom + 30, width: GlobalConstants.screenWidth - 60, height: 50))
//        accountTextField.layer.borderColor = UIColor.gray.cgColor
//        accountTextField.layer.borderWidth = 0.5
        accountTextField.leftView = accountLeftView
        accountTextField.leftViewMode = .always
        view.addSubview(accountTextField)
        
        // 分割线
        let accountSeparateLine = UILabel(frame: CGRect(x: accountTextField.left, y: accountTextField.bottom, width: accountTextField.width, height: 0.5))
        accountSeparateLine.backgroundColor = UIColor.white
        view.addSubview(accountSeparateLine)
        
        // 密码
        let pwdImageView = UIImageView(frame: CGRect(x: 10, y: 0, width: 17, height: 20))
        pwdImageView.image = UIImage(named: "login_password")
        let pwdLeftView = UIView(frame: CGRect(x: 0, y: 15, width: 40, height: 50))
        pwdLeftView.addSubview(pwdImageView)
        
        let pwdTextField = UITextField(frame: CGRect(x: accountTextField.left, y: accountSeparateLine.bottom + 30, width: accountTextField.width, height: accountTextField.height))
        pwdTextField.leftView = pwdLeftView
        pwdTextField.leftViewMode = .always
        view.addSubview(pwdTextField)
        
        // 分割线
        let pwdSeparateLine = UILabel(frame: CGRect(x: pwdTextField.left, y: pwdTextField.bottom, width: accountTextField.width, height: 0.5))
        pwdSeparateLine.backgroundColor = UIColor.white
        view.addSubview(pwdSeparateLine)
    }
}
