//
//  GuideViewController.swift
//  SwiftTrade
//
//  Created by yaoliangjun on 2017/11/29.
//  Copyright © 2017年 Jerry Yao. All rights reserved.
//  引导页

import UIKit

class GuideViewController: BaseViewController, UIScrollViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - 立即体验
    func experienceBtnClick() {

        UserDefaults.standard.set(false, forKey: AppConstants.isFirstLaunching)
        
        let loginVC = LoginViewController()
        UIView.transition(from: view, to: loginVC.view, duration: 0.8, options: .transitionFlipFromRight) { (finished) in
            (UIApplication.shared.delegate as! AppDelegate).showLoginPage()
        }
    }

    // MARK: - Getter / Setter
    override func setupSubViews() {

        view.addSubview(scrollView)
        view.addSubview(pageControl)

        let guideImageArray: [UIImage] = [UIImage(named: "guide_page_1")!, UIImage(named: "guide_page_2")!, UIImage(named: "guide_page_3")!]

        let imageCount = guideImageArray.count

        for index in 0..<imageCount {
            let imageView = UIImageView(frame: CGRect(x: GlobalConstants.screenWidth * CGFloat(index), y: 0, width: GlobalConstants.screenWidth, height: GlobalConstants.screenHeight))
            imageView.image = guideImageArray[index]

            if index == 0 {

            } else if index == 1 {

            } else if index == 2 {
                imageView.isUserInteractionEnabled = true
                let experienceBtn = UIButton(title: "立即体验", titleColor: AppConstants.goldColor, highlightedTitleColor: AppConstants.goldColor, font: UIFont.systemFont(ofSize: 14), backgroundColor: UIColor.clear, cornerRadius: 4, borderWidth: 0.5,borderColor: AppConstants.goldColor, target: self, selector: #selector(experienceBtnClick))
                imageView.addSubview(experienceBtn)
                experienceBtn.snp.makeConstraints({ (make) in
                    make.width.equalTo(120)
                    make.height.equalTo(35)
                    make.centerX.equalTo(imageView)
                    make.bottom.equalTo(imageView.snp.bottom).offset(-5)
                })
            }

            scrollView.addSubview(imageView)
        }
    }

    lazy var scrollView: UIScrollView = {
        var scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: GlobalConstants.screenWidth, height: GlobalConstants.screenHeight))
        scrollView.bounces = false
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentSize = CGSize(width: GlobalConstants.screenWidth * 3, height: GlobalConstants.screenHeight)
        scrollView.delegate = self

        return scrollView
    }()

    lazy var pageControl: UIPageControl = {
        var pageControl = UIPageControl(frame: CGRect(x: (GlobalConstants.screenWidth - 100) / 2, y: GlobalConstants.screenHeight - 40, width: 100, height: 35))
        pageControl.numberOfPages = 3
        pageControl.setValue(UIImage(named: "guide_boot-bar_normal"), forKeyPath: "pageImage")
        pageControl.setValue(UIImage(named: "guide_boot-bar_press"), forKeyPath: "currentPageImage")

        return pageControl
    }()
}

extension GuideViewController {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        var page = 0
        if offsetX > GlobalConstants.screenWidth * 0.5 {
            page = 1
        } else if offsetX > GlobalConstants.screenWidth * 0.5 {
            page = 2
        }
        pageControl.currentPage = page
        pageControl.isHidden = offsetX >= GlobalConstants.screenWidth * 1.5
    }
}
