//
//  RegisterViewController.swift
//  SwiftTrade
//
//  Created by yaoliangjun on 2017/10/13.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//

import UIKit

class RegisterViewController: BaseViewController {

    var accountTextField: UITextField? = nil
    var codeTextField: UITextField? = nil
    var pwdTextField: UITextField? = nil
    var rePwdTextField: UITextField? = nil
    
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
    
    // MARK: - Private Method
    func registerBtnClick() {
        let account = accountTextField?.text
        let verifyCode = codeTextField?.text
        let pwd = pwdTextField?.text
        let rePwd = rePwdTextField?.text
        
        if (account?.characters.count)! <= 0 {
            MBProgressHUD.show(withStatus: "手机号不能为空")
            return
        }
        
        if (verifyCode?.characters.count)! <= 0 {
            MBProgressHUD.show(withStatus: "验证码不能为空")
            return
        }
        
        if (pwd?.characters.count)! <= 0 {
            MBProgressHUD.show(withStatus: "登录密码不能为空")
            return
        }
        
        if (rePwd?.characters.count)! <= 0 {
            MBProgressHUD.show(withStatus: "请重复输入登录密码")
            return
        }

        if pwd != rePwd {
            MBProgressHUD.show(withStatus: "两次输入的密码不一致")
            return
        }
        
        // TODO: 注册逻辑
        navigationController?.popViewController(animated: true)
    }
    
    // 获取验证码
    func verifyCodeBtnClick() {
        let account = accountTextField?.text
        if (account?.characters.count)! <= 0 {
            MBProgressHUD.show(withStatus: "手机号不能为空")
            return
        }
    }
    
    // MARK: - Getter / Setter
    // 设置子View
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
        
        accountTextField = UITextField(frame: CGRect(x: 20, y: titleLabel.bottom + 30, width: GlobalConstants.screenWidth - 40, height: 50), text: "", textAlignment: .left, textColor: UIColor.white, placeholder: "请输入注册手机号", placeholderColor: UIColor.white, font: UIFont.systemFont(ofSize: 14), leftView: accountLeftView)
        view.addSubview(accountTextField!)
        
        let accountSeparateLine = UILabel(frame: CGRect(x: (accountTextField?.left)!, y: (accountTextField?.bottom)!, width: (accountTextField?.width)!, height: 0.5))
        accountSeparateLine.backgroundColor = UIColor.white
        view.addSubview(accountSeparateLine)
        
        // 验证码
        let codeImageView = UIImageView(frame: CGRect(x: 10, y: 15, width: 15, height: 20))
        codeImageView.image = UIImage(named: "login_verification_code")
        let codeLeftView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 50))
        codeLeftView.addSubview(codeImageView)
        
        codeTextField = UITextField(frame: CGRect(x: accountSeparateLine.left, y: accountSeparateLine.bottom + 10, width: accountSeparateLine.width - 90, height: 50), text: "", textAlignment: .left, textColor: UIColor.white, placeholder: "请输入验证码", placeholderColor: UIColor.white, font: UIFont.systemFont(ofSize: 14), leftView: codeLeftView)
        view.addSubview(codeTextField!)
        
        let codeSeparateLine = UILabel(frame: CGRect(x: (codeTextField?.left)!, y: (codeTextField?.bottom)!, width: (codeTextField?.width)!, height: 0.5))
        codeSeparateLine.backgroundColor = UIColor.white
        view.addSubview(codeSeparateLine)
        
        // 获取验证码
        let verifyCodeBtn = UIButton(frame: CGRect(x: (codeTextField?.right)! + 10, y: (codeTextField?.top)! + 5, width: 80, height: 40), title: "获取验证码", titleColor: AppConstants.greyTextColor, font: UIFont.systemFont(ofSize: 14), backgroundImage: UIImage.createImage(color: AppConstants.goldColor)!, highlightedBackgroundImage: UIImage.createImage(color: UIColor.brown)!, cornerRadius: 5, target: self, selector: #selector(verifyCodeBtnClick))
        view.addSubview(verifyCodeBtn)
        
        // 登录密码
        let pwdImageView = UIImageView(frame: CGRect(x: 10, y: 15, width: 15, height: 20))
        pwdImageView.image = UIImage(named: "login_password")
        let pwdLeftView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 50))
        pwdLeftView.addSubview(pwdImageView)
        
        pwdTextField = UITextField(frame: CGRect(x: accountSeparateLine.left, y: codeSeparateLine.bottom + 10, width: (accountTextField?.width)!, height: 50), text: "", textAlignment: .left, textColor: UIColor.white, placeholder: "请输入6-8数字和字符的登录密码", placeholderColor: UIColor.white, font: UIFont.systemFont(ofSize: 14), leftView: pwdLeftView)
        view.addSubview(pwdTextField!)
        
        let pwdSeparateLine = UILabel(frame: CGRect(x: (codeTextField?.left)!, y: (pwdTextField?.bottom)!, width: (pwdTextField?.width)!, height: 0.5))
        pwdSeparateLine.backgroundColor = UIColor.white
        view.addSubview(pwdSeparateLine)
        
        // 重复登录密码
        let rePwdImageView = UIImageView(frame: CGRect(x: 10, y: 15, width: 15, height: 20))
        rePwdImageView.image = UIImage(named: "login_password")
        let rePwdLeftView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 50))
        rePwdLeftView.addSubview(rePwdImageView)
        
        rePwdTextField = UITextField(frame: CGRect(x: pwdSeparateLine.left, y: pwdSeparateLine.bottom + 10, width: (accountTextField?.width)!, height: 50), text: "", textAlignment: .left, textColor: UIColor.white, placeholder: "请重复输入登录密码", placeholderColor: UIColor.white, font: UIFont.systemFont(ofSize: 14), leftView: rePwdLeftView)
        view.addSubview(rePwdTextField!)
        
        let rePwdSeparateLine = UILabel(frame: CGRect(x: (codeTextField?.left)!, y: (rePwdTextField?.bottom)!, width: (accountTextField?.width)!, height: 0.5))
        rePwdSeparateLine.backgroundColor = UIColor.white
        view.addSubview(rePwdSeparateLine)
        
        // 注册
        let registerBtn = UIButton(frame: CGRect(x: rePwdSeparateLine.left, y: rePwdSeparateLine.bottom + 60, width: rePwdSeparateLine.width, height: 44), title: "注册", titleColor: AppConstants.greyTextColor, font: UIFont.systemFont(ofSize: 18), backgroundImage: UIImage.createImage(color: AppConstants.goldColor)!, highlightedBackgroundImage: UIImage.createImage(color: UIColor.brown)!, cornerRadius: 5, target: self, selector: #selector(registerBtnClick))
        view.addSubview(registerBtn)
    }
}
