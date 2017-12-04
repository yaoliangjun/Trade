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
        let backgroundView = UIImageView(frame: CGRect(x: 0, y: 0, width: GlobalConstants.screenWidth, height: GlobalConstants.screenHeight))
        backgroundView.image = UIImage(named: "background")
        view.addSubview(backgroundView)
        
        //
        let titleLabel = UILabel(frame: CGRect(x: 0, y: GlobalConstants.navigationBarHeight, width: GlobalConstants.screenWidth, height: 30), text: "登录", textAlignment: .center, textColor: AppConstants.goldColor, font: UIFont.systemFont(ofSize: 20))
        view.addSubview(titleLabel)
        
        // 账号
        let accountImageView = UIImageView(frame: CGRect(x: 10, y: 15, width: 17, height: 20))
        accountImageView.image = UIImage(named: "login_account")
        let accountLeftView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 50))
        accountLeftView.addSubview(accountImageView)
        
        accountTextField = UITextField(frame: CGRect(x: 30, y: titleLabel.bottom + 30, width: GlobalConstants.screenWidth - 60, height: 50), text: "", textAlignment: .center, textColor: UIColor.white, placeholder: "请输入账号", placeholderColor: UIColor.white, font: UIFont.systemFont(ofSize: 16), leftView: accountLeftView)
        view.addSubview(accountTextField!)
        
        let accountSeparateLine = UILabel(frame: CGRect(x: (accountTextField?.left)!, y: (accountTextField?.bottom)!, width: (accountTextField?.width)!, height: 0.5))
        accountSeparateLine.backgroundColor = UIColor.white
        view.addSubview(accountSeparateLine)
        
        // 密码
        let pwdImageView = UIImageView(frame: CGRect(x: 10, y: 15, width: 17, height: 20))
        pwdImageView.image = UIImage(named: "login_password")
        let pwdLeftView = UIView(frame: CGRect(x: 0, y: 15, width: 40, height: 50))
        pwdLeftView.addSubview(pwdImageView)
        
        pwdTextField = UITextField(frame: CGRect(x: (accountTextField?.left)!, y: accountSeparateLine.bottom + 30, width: (accountTextField?.width)!, height: (accountTextField?.height)!), text: "", textAlignment: .center, textColor: UIColor.white, placeholder: "请输入密码", placeholderColor: UIColor.white, font: UIFont.systemFont(ofSize: 16), leftView: pwdLeftView)
        pwdTextField?.isSecureTextEntry = true
        view.addSubview(pwdTextField!)
        
        let pwdSeparateLine = UILabel(frame: CGRect(x: (pwdTextField?.left)!, y: (pwdTextField?.bottom)!, width: (accountTextField?.width)!, height: 0.5))
        pwdSeparateLine.backgroundColor = UIColor.white
        view.addSubview(pwdSeparateLine)
        
        // 找回密码
        let findPwdBtn = UIButton(frame: CGRect(x: (pwdTextField?.right)! - 60, y: pwdSeparateLine.bottom + 10, width: 60, height: 20), title: "找回密码", titleColor: UIColor.white, font: UIFont.systemFont(ofSize: 12), target: self, selector:#selector(findPwdBtnClick))
        view.addSubview(findPwdBtn)
        
        // 登录
        let loginBtn = UIButton(frame: CGRect(x: 30, y: findPwdBtn.bottom + 40, width: GlobalConstants.screenWidth - 60, height: 44), title: "登录", titleColor: AppConstants.greyTextColor, font: UIFont.systemFont(ofSize: 18), backgroundImage: UIImage.createImage(color: AppConstants.goldColor)!, highlightedBackgroundImage: UIImage.createImage(color: UIColor.brown)!, cornerRadius: 5, target: self, selector: #selector(loginBtnClick))
        view.addSubview(loginBtn)
        
        // 注册
        let registerBtn = UIButton(frame: CGRect(x: (GlobalConstants.screenWidth - 120) / 2, y: loginBtn.bottom + 40, width: 120, height: 30), title: "没有账号立即注册", titleColor: UIColor.white, font: UIFont.systemFont(ofSize: 14), target: self, selector: #selector(registerBtnClick))
        view.addSubview(registerBtn)
        
        // DEMO ACCOUNT
        accountTextField?.text = "13528768996"
        pwdTextField?.text = "ylj123456"
    }
}
