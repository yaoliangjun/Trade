//
//  ForgetPasswordViewController.swift
//  SwiftTrade
//
//  Created by yaoliangjun on 2017/12/4.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//  忘记密码页面

import UIKit

class ForgetPasswordViewController: BaseViewController {

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
    func confirmBtnClick() {
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

        let params = ["phone": account!, "verificationCode" : verifyCode!, "password" : pwd!.md5()]
        LoginServices.findPassword(params: params, showHUD: true, success: { (response) in
            MBProgressHUD.show(withStatus: "密码找回成功", completionHandle: {
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
        let backgroundView = UIImageView(frame: CGRect(x: 0, y: 0, width: GlobalConstants.screenWidth, height: GlobalConstants.screenHeight))
        backgroundView.image = UIImage(named: "background")
        view.addSubview(backgroundView)

        //
        let titleLabel = UILabel(frame: CGRect(x: 0, y: GlobalConstants.navigationBarHeight, width: GlobalConstants.screenWidth, height: 30), text: "找回密码", textAlignment: .center, textColor: AppConstants.goldColor, font: UIFont.systemFont(ofSize: 20))
        view.addSubview(titleLabel)

        // 账号
        let accountImageView = UIImageView(frame: CGRect(x: 10, y: 15, width: 15, height: 20))
        accountImageView.image = UIImage(named: "login_register_phone")
        let accountLeftView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 50))
        accountLeftView.addSubview(accountImageView)

        accountTextField = UITextField(frame: CGRect(x: 20, y: titleLabel.bottom + 30, width: GlobalConstants.screenWidth - 40 - 90, height: 50), text: "", textAlignment: .left, textColor: UIColor.white, placeholder: "请输入注册手机号", placeholderColor: UIColor.white, font: UIFont.systemFont(ofSize: 14), leftView: accountLeftView)
        view.addSubview(accountTextField!)

        let defaultTitle = "+\(currentDistrictCode)"
        imageBtn = ImageButton(title: defaultTitle, titleColor: UIColor.white, textAlignment: .right, font: UIFont.systemFont(ofSize: 14), image: UIImage(named: "arrow_right_white"), target: self, selector: #selector(districtNumBtnClick))
        imageBtn?.frame = CGRect(x: (accountTextField?.right)!, y: (accountTextField?.top)! + 10, width: 90, height: 30)
        imageBtn?.titleLabel?.textAlignment = .right
        view.addSubview(imageBtn!)
        
        let accountSeparateLine = UILabel(frame: CGRect(x: (accountTextField?.left)!, y: (accountTextField?.bottom)!, width: GlobalConstants.screenWidth - 40, height: 0.5))
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
        verifyCodeBtn = UIButton(frame: CGRect(x: (codeTextField?.right)! + 10, y: (codeTextField?.top)! + 5, width: 80, height: 40), title: "获取验证码", titleColor: AppConstants.greyTextColor, font: UIFont.systemFont(ofSize: 14), backgroundImage: UIImage.createImage(color: AppConstants.goldColor)!, highlightedBackgroundImage: UIImage.createImage(color: UIColor.brown)!, cornerRadius: 5, target: self, selector: #selector(verifyCodeBtnClick))
        view.addSubview(verifyCodeBtn!)

        // 登录密码
        let pwdImageView = UIImageView(frame: CGRect(x: 10, y: 15, width: 15, height: 20))
        pwdImageView.image = UIImage(named: "login_password")
        let pwdLeftView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 50))
        pwdLeftView.addSubview(pwdImageView)

        pwdTextField = UITextField(frame: CGRect(x: accountSeparateLine.left, y: codeSeparateLine.bottom + 10, width: accountSeparateLine.width, height: 50), text: "", textAlignment: .left, textColor: UIColor.white, placeholder: "请输入6-16位数字和字符的登录密码", placeholderColor: UIColor.white, font: UIFont.systemFont(ofSize: 14), leftView: pwdLeftView)
        view.addSubview(pwdTextField!)

        let pwdSeparateLine = UILabel(frame: CGRect(x: (codeTextField?.left)!, y: (pwdTextField?.bottom)!, width: (pwdTextField?.width)!, height: 0.5))
        pwdSeparateLine.backgroundColor = UIColor.white
        view.addSubview(pwdSeparateLine)

        // 重复登录密码
        let rePwdImageView = UIImageView(frame: CGRect(x: 10, y: 15, width: 15, height: 20))
        rePwdImageView.image = UIImage(named: "login_password")
        let rePwdLeftView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 50))
        rePwdLeftView.addSubview(rePwdImageView)

        rePwdTextField = UITextField(frame: CGRect(x: pwdSeparateLine.left, y: pwdSeparateLine.bottom + 10, width: accountSeparateLine.width, height: 50), text: "", textAlignment: .left, textColor: UIColor.white, placeholder: "请重复输入登录密码", placeholderColor: UIColor.white, font: UIFont.systemFont(ofSize: 14), leftView: rePwdLeftView)
        view.addSubview(rePwdTextField!)

        let rePwdSeparateLine = UILabel(frame: CGRect(x: (codeTextField?.left)!, y: (rePwdTextField?.bottom)!, width: (rePwdTextField?.width)!, height: 0.5))
        rePwdSeparateLine.backgroundColor = UIColor.white
        view.addSubview(rePwdSeparateLine)

        // 确定
        let confirmBtn = UIButton(frame: CGRect(x: rePwdSeparateLine.left, y: rePwdSeparateLine.bottom + 60, width: rePwdSeparateLine.width, height: 44), title: "确定", titleColor: AppConstants.greyTextColor, font: UIFont.systemFont(ofSize: 18), backgroundImage: UIImage.createImage(color: AppConstants.goldColor)!, highlightedBackgroundImage: UIImage.createImage(color: UIColor.brown)!, cornerRadius: 5, target: self, selector: #selector(confirmBtnClick))
        view.addSubview(confirmBtn)
    }
}
