//
//  ViewController.swift
//  WeexTest
//
//  Created by ittmomWang on 17/2/27.
//  Copyright © 2017年 ittmomWang. All rights reserved.
//

import UIKit
import WeexSDK
import RxSwift

class ViewController: UIViewController {
    
    var instance = WXSDKInstance()
    var weexView = UIView()
    var weexHeight: Double = 0.0
    var scanUrl: String = ""
    let bag = DisposeBag()
    
    override func viewWillAppear(_ animated: Bool) {
        render()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let button = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 60, height: 25))
        button.setTitle("扫一扫", for: .normal)
        button.setTitleColor(UIColor.green, for: .normal)
        button.addTarget(self, action: #selector(ViewController.scanQRCode), for: .touchUpInside)
        
        self.navigationItem.setRightBarButton(UIBarButtonItem.init(customView: button), animated: false)
        
        render()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func scanQRCode() {
        let vc = ScanQRCodeController()
        Observable
            .of(vc.number)
            .merge()
            .subscribe (onNext: {[unowned self] url in
                print(url)
                self.scanUrl = url
            })
            .addDisposableTo(bag)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func render() {
        instance.viewController = self
        instance.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        instance.onCreate = {[unowned self] view in
            self.weexView.removeFromSuperview()
            self.weexView = view!
            self.view.addSubview(self.weexView)
            UIAccessibilityPostNotification(UIAccessibilityScreenChangedNotification, self.weexView)
        }
        instance.onFailed = { error in
            print("\(error?.localizedDescription)")
        }
        instance.renderFinish = { view in
            print("渲染完成")
        }
        let url = URL.init(string: self.scanUrl)
        instance.render(with: url)
    }
    
    deinit {
        instance.destroy()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

