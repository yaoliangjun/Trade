//
//  RegisterViewController.swift
//  SwiftTrade
//
//  Created by yaoliangjun on 2017/10/13.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//  注册页面

import UIKit

class RegisterViewController: BaseViewController {

    var accountTextField: UITextField? = nil
    var codeTextField: UITextField? = nil
    var pwdTextField: UITextField? = nil
    var rePwdTextField: UITextField? = nil
    var timer: Timer?
    var verifyCodeBtn: UIButton?
    var districtArray: [DistrictModel]?
    var currentDistrict: String = Locale.current.regionCode! // 当前区域 CN
    var currentDistrictCode: String = "86" // 当前区号 86
    var imageBtn: ImageButton?

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDistrictNum()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 设置导航栏透明和去掉导航栏底部的黑线
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }


    // MARK: - HTTP
    // 获取区号
    func fetchDistrictNum() {
        LoginServices.districtNum(params: [:], showHUD: true, success: { (response) in
            guard let districtArray = response else {
                return
            }

            self.districtArray = districtArray
            for model in districtArray {
                if (model.abbre?.contains(self.currentDistrict))! {
                    self.currentDistrictCode = model.code!
                    print(self.currentDistrictCode)
                }
            }


        }) { (error) in

        }
    }

    // MARK: - Private Method
    func registerBtnClick() {
        let account = accountTextField?.text
        let verifyCode = codeTextField?.text
        let pwd = pwdTextField?.text
        let rePwd = rePwdTextField?.text
        
        if (account?.isEmpty)! {
            MBProgressHUD.show(withStatus: "请输入注册手机号")
            return
        }
        
        if (verifyCode?.isEmpty)! {
            MBProgressHUD.show(withStatus: "请输入验证码")
            return
        }
        
        if (pwd?.isEmpty)! {
            MBProgressHUD.show(withStatus: "请输入登录密码")
            return
        }

        if (!(pwd?.validPasswordFieldFormatter())!) {
            MBProgressHUD.show(withStatus: "请输入6-16位数字和字符的登录密码")
            return
        }

        if (rePwd?.isEmpty)! {
            MBProgressHUD.show(withStatus: "请重复输入登录密码")
            return
        }

        if (!(rePwd?.validPasswordFieldFormatter())!) {
            MBProgressHUD.show(withStatus: "请重复输入6-16位数字和字符的登录密码")
            return
        }

        if pwd != rePwd {
            MBProgressHUD.show(withStatus: "两次输入的密码不一致")
            return
        }
        
        view.endEditing(true)
        
        let params = ["phone": account!, "verificationCode": verifyCode!, "password": pwd!.md5(), "areacode": currentDistrictCode]
        LoginServices.register(params: params, showHUD: true, success: { (response) in
            MBProgressHUD.show(withStatus: "注册成功", completionHandle: { 
                self.navigationController?.popViewController(animated: true)
            })
            
        }) { (error) in
            
        }
    }
    
    // 获取验证码
    func verifyCodeBtnClick() {
        let account = accountTextField?.text
        if (account?.isEmpty)! {
            MBProgressHUD.show(withStatus: "请输入注册手机号")
            return
        }

        view.endEditing(true)
        
        // 保存点击时候的时间
        UserDefaults.standard.set(Date().timeIntervalSince1970, forKey: AppConstants.startGetVerifyCode)
        UserDefaults.standard.synchronize()
        
        verifyCodeCountdown()
        verifyCodeBtn?.isEnabled = false
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(verifyCodeCountdown), userInfo: nil, repeats: true)
        
        let params = ["phone": account ?? "", "type": "1"]
        LoginServices.verifyCode(params: params, showHUD: false, success: { (response) in
            MBProgressHUD.show(withStatus: "验证码已发送到您的手机")
        }) { (error) in
            
        }
    }
    
    // 获取验证码倒计时
    func verifyCodeCountdown() {
        let countdownSecond = 60.0
        let startTimeInterval = UserDefaults.standard.double(forKey: AppConstants.startGetVerifyCode)
        if startTimeInterval + countdownSecond > Date().timeIntervalSince1970 {
            let countdownInterval = Int(startTimeInterval + countdownSecond - Date().timeIntervalSince1970)
            verifyCodeBtn?.setTitle(String(countdownInterval), for: .normal)
            
        } else {
            verifyCodeBtn?.setTitle("获取验证码", for: .normal)
            verifyCodeBtn?.isEnabled = true
            timer?.invalidate()
            timer = nil
        }
    }

    // 选择区号
    func districtNumBtnClick() {
        let districtNumVC = DistrictNumViewController()
        districtNumVC.districtArray = districtArray
        districtNumVC.didSelectedDistrictNumBlock = { (districtModel) in
            guard let code = districtModel?.code else {
                self.currentDistrictCode = "86"
                return
            }
            self.currentDistrictCode = code
            self.imageBtn?.setTitle("+\(self.currentDistrictCode)", for: .normal)
        }

        navigationController?.pushViewController(districtNumVC, animated: true)
    }

    // MARK: - Getter / Setter
    // 设置子View
    override func setupSubViews() {
        //
        let backgroundView = UIImageView(image: UIImage(named: "background"))
        view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
        //
        let titleLabel = UILabel(text: "注册", textAlignment: .center, textColor: AppConstants.goldColor, font: UIFont.systemFont(ofSize: 20))
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.height.equalTo(30)
            make.top.equalTo(view).offset(64)
        }
        
        // 账号
        let accountImageView = UIImageView(frame: CGRect(x: 10, y: 15.5, width: 14, height: 19))
        accountImageView.image = UIImage(named: "login_register_phone")
        let accountLeftView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 50))
        accountLeftView.addSubview(accountImageView)

        accountTextField = UITextField(text: nil, textAlignment: .left, textColor: UIColor.white, placeholder: "请输入注册手机号", placeholderColor: UIColor.white, font: UIFont.systemFont(ofSize: 14), leftView: accountLeftView, leftViewMode: .always)
        view.addSubview(accountTextField!)
        accountTextField!.snp.makeConstraints { (make) in
            make.left.equalTo(30)
            make.height.equalTo(60)
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
        }

        let defaultTitle = "+\(currentDistrictCode)"
        imageBtn = ImageButton(title: defaultTitle, titleColor: UIColor.white, textAlignment: .right, font: UIFont.systemFont(ofSize: 14), image: UIImage(named: "arrow_right_white"), target: self, selector: #selector(districtNumBtnClick))
        imageBtn?.titleLabel?.textAlignment = .right
        view.addSubview(imageBtn!)
        imageBtn!.snp.makeConstraints { (make) in
            make.left.equalTo(accountTextField!.snp.right).offset(5);
            make.centerY.equalTo(accountTextField!);
            make.width.equalTo(90);
            make.height.equalTo(30);
            make.right.equalTo(view).offset(-30);
        }

        let accountSeparateLine = UILabel(backgroundColor: AppConstants.gapColor)
        view.addSubview(accountSeparateLine)
        accountSeparateLine.snp.makeConstraints { (make) in
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.top.equalTo(accountTextField!.snp.bottom)
            make.height.equalTo(0.5)
        }

        // 验证码
        let codeImageView = UIImageView(frame: CGRect(x: 9, y: 15, width: 18, height: 20))
        codeImageView.image = UIImage(named: "login_verification_code")
        let codeLeftView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 50))
        codeLeftView.addSubview(codeImageView)

        codeTextField = UITextField(text: nil, textAlignment: .left, textColor: UIColor.white, placeholder: "请输入验证码", placeholderColor: UIColor.white, font: UIFont.systemFont(ofSize: 14), leftView: codeLeftView, leftViewMode: .always)
        view.addSubview(codeTextField!)

        // 获取验证码
        verifyCodeBtn = CommonButton(title: "获取验证码", font: UIFont.systemFont(ofSize: 12), target: self, selector: #selector(verifyCodeBtnClick))
        view.addSubview(verifyCodeBtn!)

        codeTextField!.snp.makeConstraints { (make) in
            make.top.equalTo(accountSeparateLine.snp.bottom)
            make.left.height.equalTo(accountTextField!)
            make.right.equalTo(verifyCodeBtn!.snp.left).offset(-3);
        }

        verifyCodeBtn!.snp.makeConstraints { (make) in
            make.right.equalTo(accountSeparateLine)
            make.width.equalTo(80)
            make.height.equalTo(35)
            make.bottom.equalTo(codeTextField!)
            make.left.equalTo(codeTextField!.snp.right).offset(3)
        }

        let codeSeparateLine = UILabel(backgroundColor: AppConstants.gapColor)
        view.addSubview(codeSeparateLine)
        codeSeparateLine.snp.makeConstraints { (make) in
            make.left.height.equalTo(accountSeparateLine)
            make.top.equalTo(codeTextField!.snp.bottom)
            make.right.equalTo(codeTextField!)
        }

        // 登录密码
        let pwdImageView = UIImageView(frame: CGRect(x: 10, y: 15, width: 15, height: 20))
        pwdImageView.image = UIImage(named: "login_password")
        let pwdLeftView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 50))
        pwdLeftView.addSubview(pwdImageView)

        pwdTextField = UITextField(text: nil, textAlignment: .left, textColor: UIColor.white, placeholder: "请输入6-16位数字和字符的登录密码", placeholderColor: UIColor.white, font: UIFont.systemFont(ofSize: 14), leftView: pwdLeftView, leftViewMode: .always)
        view.addSubview(pwdTextField!)
        pwdTextField!.snp.makeConstraints { (make) in
            make.top.equalTo(codeSeparateLine.snp.bottom)
            make.left.right.equalTo(accountSeparateLine)
            make.height.equalTo(accountTextField!)
        }

        let pwdSeparateLine = UILabel(backgroundColor: AppConstants.gapColor)
        view.addSubview(pwdSeparateLine)
        pwdSeparateLine.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(accountSeparateLine)
            make.top.equalTo(pwdTextField!.snp.bottom)
        }

        // 重复登录密码
        let rePwdImageView = UIImageView(frame: CGRect(x: 10, y: 15, width: 15, height: 20))
        rePwdImageView.image = UIImage(named: "login_password")
        let rePwdLeftView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 50))
        rePwdLeftView.addSubview(rePwdImageView)

        rePwdTextField = UITextField(text: nil, textAlignment: .left, textColor: UIColor.white, placeholder: "请重复输入登录密码", placeholderColor: UIColor.white, font: UIFont.systemFont(ofSize: 14), leftView: rePwdLeftView, leftViewMode: .always)
        view.addSubview(rePwdTextField!)
        rePwdTextField!.snp.makeConstraints { (make) in
            make.top.equalTo(pwdSeparateLine.snp.bottom)
            make.left.right.equalTo(pwdTextField!)
            make.height.equalTo(pwdTextField!)
        }

        let rePwdSeparateLine = UILabel(backgroundColor: AppConstants.gapColor)
        view.addSubview(rePwdSeparateLine)
        rePwdSeparateLine.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(pwdSeparateLine)
            make.top.equalTo(rePwdTextField!.snp.bottom)
        }

        // 注册
        let registerBtn = CommonButton(title: "注册", font: UIFont.systemFont(ofSize: 18), target: self, selector: #selector(registerBtnClick))
        view.addSubview(registerBtn)
        registerBtn.snp.makeConstraints { (make) in
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.top.equalTo(rePwdSeparateLine.snp.bottom).offset(40)
            make.height.equalTo(44)
        }
    }
}
