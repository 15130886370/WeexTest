//
//  ScanQRCodeController.swift
//  SetUpProductList
//
//  Created by ittmomWang on 17/3/22.
//  Copyright © 2017年 ittmomProject. All rights reserved.
//

import UIKit
import AVFoundation
import SnapKit
import RxSwift

class ScanQRCodeController: UIViewController {

    // MARK: Properties
    var session: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var captureView: UIView!
    var qrCodeView: ScanView!
    var timer: Timer?
    var number = PublishSubject<String>()
    
    // MARK: Life - Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "扫一扫"
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: .scrollScanAnimator, userInfo: nil, repeats: true)
        initCapture()
        setUpCaptureView()
        
        if let session = self.session {
            //session启动
            session.startRunning()
        }
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if let timer = self.timer {
            timer.invalidate()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // MARK: Set View
    private func setUpCaptureView() {
        //创建系统自动捕获框
        self.captureView = UIView().then {
            $0.layer.borderColor = UIColor.green.cgColor
            $0.layer.borderWidth = 2
            self.view.addSubview($0)
            self.view.bringSubview(toFront: $0)
        }
        //扫一扫图片儿
        self.qrCodeView = ScanView.init(frame: CGRect.zero).then {
            self.view.insertSubview($0, belowSubview: self.captureView)
            $0.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
    }
    
    private func initCapture() {
        let captureDervice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        do
        {
            let captureInput = try AVCaptureDeviceInput(device: captureDervice)
            //session 是input和output的桥梁,它协调者input到output的数据传输
            session = AVCaptureSession()
            session!.addInput(captureInput)
            //输出流
            let captureOutput = AVCaptureMetadataOutput()
            //限制扫描区域
            captureOutput.rectOfInterest = getScanArea()
            
            session!.addOutput(captureOutput)
            //设置代理,必须是主线程完成
            captureOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            //设置扫码支持的编码格式
            captureOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code]
            //用这个预览图层和图像信息捕获会话(session)来显示视频
            let videoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.session)
            videoPreviewLayer!.videoGravity = AVLayerVideoGravityResizeAspectFill
            videoPreviewLayer!.frame = self.view.layer.bounds
            self.view.layer.addSublayer(videoPreviewLayer!)
        }
        catch
        {
            let errorAlert = UIAlertController(title: "提醒", message: "请在iPhone的\"设置-隐私-相机\"选项中,允许XXX访问您的相机", preferredStyle: .alert)
            errorAlert.addAction(UIAlertAction.init(title: "确定", style: .default, handler: nil))
            self.present(errorAlert, animated: true, completion: nil)
        }
    }
    
    func getScanArea()-> CGRect {
        let y = (Rect.SCREENW - 280) / 2 / Rect.SCREENW
        let x = 128 / Rect.SCREENH
        let height = 280 / Rect.SCREENW
        let width = 280 / Rect.SCREENH
        return CGRect.init(x: x, y: y, width: width, height: height)
    }
    
    func scrollScanAnimator() {
        qrCodeView.scanLine.isHidden = false
        qrCodeView.scanLine.snp.updateConstraints { make in
            make.top.equalTo(qrCodeView.codeView.snp.top).offset(270)
        }
        
        UIView.animate(withDuration: 1.9, animations: { 
            self.view.layoutIfNeeded()
        }) { (_) in
            self.qrCodeView.scanLine.snp.updateConstraints { make in
                make.top.equalTo(self.qrCodeView.codeView.snp.top).offset(5)
            }
        }
    }

}

// MARK: AVCaptureMetadataOutputObjectsDelegate
extension ScanQRCodeController: AVCaptureMetadataOutputObjectsDelegate {
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        self.session?.stopRunning()
        if let timer = self.timer {
            timer.invalidate()
        }
        self.timer = nil

        if metadataObjects == nil && metadataObjects.count == 0 {
            self.captureView.frame = CGRect.zero
            return
        }
        //录入的数据
        let string = metadataObjects.last as! AVMetadataMachineReadableCodeObject
        number.onNext(string.stringValue)
        print(string.stringValue)
        _ = self.navigationController?.popViewController(animated: true)
    }
}


extension Selector {
    static let scrollScanAnimator = #selector(ScanQRCodeController.scrollScanAnimator)
}
