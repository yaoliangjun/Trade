//
//  LoginViewController.swift
//  SwiftTrade
//
//  Created by yaoliangjun on 2017/10/12.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//  登录页面

import UIKit

class LoginViewController: BaseViewController {

    var accountTextField: UITextField? = nil
    var pwdTextField: UITextField? = nil
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    // MARK: - Private Method
    // 登录
    func loginBtnClick() {
        let account = accountTextField?.text
        if (account?.isEmpty)! {
            MBProgressHUD.show(withStatus: "请输入账号")
            return
        }

        let password = pwdTextField?.text
        if (password?.isEmpty)! {
            MBProgressHUD.show(withStatus: "请输入密码")
            return
        }

        let params = ["phone": account!, "password": password!.md5()]

        LoginServices.login(params: params, showHUD: true, success: { (response) in
            let token = (response?.content as! NSDictionary)["token"]
            UserDefaults.standard.setValue(token, forKey: AppConstants.token)
            UserDefaults.standard.setValue(account, forKey: AppConstants.account)

            ((UIApplication.shared.delegate) as! AppDelegate).showMainPage()
            
        }) { (error) in
            
        }
    }
    
    // 找回密码
    func findPwdBtnClick() {
        navigationController?.pushViewController(ForgetPasswordViewController(), animated: true)
    }
    
    // 注册
    func registerBtnClick() {
        navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
    
    // MARK: - Getter / Setter
    // 设置子View
    override func setupSubViews() {
        //
        let backgroundView = UIImageView()
        backgroundView.image = UIImage(named: "background")
        view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
        //
        let titleLabel = UILabel(text: "登录", textAlignment: .center, textColor: AppConstants.goldColor, font: UIFont.systemFont(ofSize: 20))
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.height.equalTo(30)
            make.top.equalTo(view).offset(64)
        }
        
        // 账号
        let accountImageView = UIImageView(frame: CGRect(x: 10, y: 15, width: 17, height: 20))
        accountImageView.image = UIImage(named: "login_account")
        let accountLeftView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 50))
        accountLeftView.addSubview(accountImageView)
        
        accountTextField = UITextField(text: nil, textAlignment: .center, textColor: UIColor.white, placeholder: "请输入账号", placeholderColor: UIColor.white, font: UIFont.systemFont(ofSize: 16), leftView: accountLeftView, leftViewMode: .always)
        view.addSubview(accountTextField!)
        accountTextField!.snp.makeConstraints { (make) in
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.height.equalTo(50)
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
        }
        
        let accountSeparateLine = UILabel()
        accountSeparateLine.backgroundColor = UIColor.white
        view.addSubview(accountSeparateLine)
        accountSeparateLine.snp.makeConstraints { (make) in
            make.left.right.equalTo(accountTextField!)
            make.top.equalTo(accountTextField!.snp.bottom)
            make.height.equalTo(0.5)
        }
        
        // 密码
        let pwdImageView = UIImageView(frame: CGRect(x: 10, y: 15, width: 17, height: 20))
        pwdImageView.image = UIImage(named: "login_password")
        let pwdLeftView = UIView(frame: CGRect(x: 0, y: 15, width: 40, height: 50))
        pwdLeftView.addSubview(pwdImageView)
        
        pwdTextField = UITextField(text: nil, textAlignment: .center, textColor: UIColor.white, placeholder: "请输入密码", placeholderColor: UIColor.white, font: UIFont.systemFont(ofSize: 16), leftView: pwdLeftView, leftViewMode: .always)
        pwdTextField?.isSecureTextEntry = true
        view.addSubview(pwdTextField!)
        pwdTextField!.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(accountTextField!)
            make.top.equalTo(accountTextField!.snp.bottom).offset(30)
        }
        
        let pwdSeparateLine = UILabel(frame: CGRect(x: (pwdTextField?.left)!, y: (pwdTextField?.bottom)!, width: (accountTextField?.width)!, height: 0.5))
        pwdSeparateLine.backgroundColor = UIColor.white
        view.addSubview(pwdSeparateLine)
        pwdSeparateLine.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(accountSeparateLine)
            make.top.equalTo(pwdTextField!.snp.bottom)
        }
        
        // 找回密码
        let findPwdBtn = UIButton(title: "找回密码", titleColor: UIColor.white, highlightedTitleColor: AppConstants.greyTextColor, font: UIFont.systemFont(ofSize: 12), target: self, selector: #selector(findPwdBtnClick))
        view.addSubview(findPwdBtn)
        findPwdBtn.snp.makeConstraints { (make) in
            make.width.equalTo(60)
            make.height.equalTo(20)
            make.right.equalTo(pwdTextField!)
            make.top.equalTo(pwdSeparateLine.snp.bottom).offset(10)
        }
        
        // 登录
        let loginBtn = UIButton(title: "登录", titleColor: AppConstants.greyTextColor, highlightedTitleColor: AppConstants.greyTextColor, font: UIFont.systemFont(ofSize: 18), backgroundImage: UIImage.createImage(color: AppConstants.goldColor), highlightedBackgroundImage: UIImage.createImage(color: UIColor.brown), borderWidth: 0, borderColor: nil, cornerRadius: 5, target: self, selector: #selector(loginBtnClick))
        view.addSubview(loginBtn)
        loginBtn.snp.makeConstraints { (make) in
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.top.equalTo(findPwdBtn.snp.bottom).offset(40)
            make.height.equalTo(44)
        }

        // 注册
        let registerBtn = UIButton(title: "立即注册", titleColor: UIColor.white, highlightedTitleColor: AppConstants.greyTextColor, font: UIFont.systemFont(ofSize: 12), target: self, selector: #selector(registerBtnClick))
        view.addSubview(registerBtn)
        registerBtn.snp.makeConstraints { (make) in
            make.width.equalTo(120)
            make.height.equalTo(30)
            make.centerX.equalTo(loginBtn)
            make.top.equalTo(loginBtn.snp.bottom).offset(40)
        }
        
        // DEMO ACCOUNT
        accountTextField?.text = "13528768996"
        pwdTextField?.text = "ylj123456"
    }
}
