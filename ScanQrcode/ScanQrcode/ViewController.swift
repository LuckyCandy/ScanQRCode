//
//  ViewController.swift
//  ScanQrcode
//
//  Created by DamonLi on 2017/2/6.
//  Copyright © 2017年 Pioneer. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController,AVCaptureMetadataOutputObjectsDelegate {
    
    var captureSession:AVCaptureSession!
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    lazy var cameraView:ScanView = ScanView(frame: UIScreen.main.bounds)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func startScan(_ sender: UIButton) {
        print("Scan")
        let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        do{
            let captureInput = try AVCaptureDeviceInput(device: captureDevice)
            captureSession = AVCaptureSession()
            captureSession.addInput(captureInput)
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession.addOutput(captureMetadataOutput)
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
            //设置扫描范围
            captureMetadataOutput.rectOfInterest = CGRect(x: 0.2, y: 0.2, width: 0.6, height: 0.6)
            
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
            videoPreviewLayer?.frame = cameraView.bounds
            cameraView.layer.insertSublayer(videoPreviewLayer!, at: 0)
            self.view.addSubview(cameraView)
            captureSession.startRunning()
            
        }catch{
            print("创建AVCaptureDeviceInput实例失败\(error)")
        }
    }
    
    //Mark Delegate --AVCaptureMetadataOutputObjects
    public func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!){
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects == nil || metadataObjects.count == 0 {
            print("没检测到二维码")
            return
        }
        
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if metadataObj.type == AVMetadataObjectTypeQRCode {
            // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
            if metadataObj.stringValue != nil {
                print(metadataObj.stringValue)
                if let openUrl = URL(string: metadataObj.stringValue){
                    if UIApplication.shared.canOpenURL(openUrl){
                        UIApplication.shared.openURL(openUrl)
                    }else{
                        let alertVC = UIAlertController(title: "⚠️", message: "无法打开:\(metadataObj.stringValue!)", preferredStyle: .alert)
                        alertVC.addAction(UIAlertAction(title: "知道了", style: .default, handler: nil))
                        self.present(alertVC, animated: true, completion: nil)
                    }
                    
                }else{
                    let alertVC = UIAlertController(title: "⚠️", message: "无法打开:\(metadataObj.stringValue!)", preferredStyle: .alert)
                    alertVC.addAction(UIAlertAction(title: "知道了", style: .default, handler: nil))
                    self.present(alertVC, animated: true, completion: nil)
                }
                
            }
        }
    }

}

