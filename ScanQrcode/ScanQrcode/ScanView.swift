//
//  ScanView.swift
//  ScanQrcode
//
//  Created by DamonLi on 2017/2/6.
//  Copyright © 2017年 Pioneer. All rights reserved.
//

import UIKit

class ScanView: UIView {
    
    //定义扫描区域高亮显示
    let scanScope = ScanScope(frame: CGRect(x: UIScreen.main.bounds.size.width * 0.2, y: UIScreen.main.bounds.size.height * 0.35, width: UIScreen.main.bounds.size.width * 0.6, height: UIScreen.main.bounds.size.width * 0.6))
    //模拟扫描线上下滚动
    let scanLine = UIView()
    
    var timer = Timer()
    //override init方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(scanScope)
        
        //扫描线样式
        scanLine.frame = CGRect(x: 0, y: 0, width: scanScope.frame.size.width, height: 2)
        scanLine.backgroundColor = .green
        scanScope.addSubview(scanLine)
        
        //填充虚拟化背景
        cretaeBackground()
        moveScannerLayer()
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(moveScannerLayer), userInfo: nil, repeats: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //创建背景
    fileprivate func cretaeBackground(){
        let topView = UIView(frame: CGRect(x: 0, y: 0,  width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height * 0.35))
        let bottomView = UIView(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.width * 0.6 + UIScreen.main.bounds.size.height * 0.35, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height * 0.65 - UIScreen.main.bounds.size.width * 0.6))
        
        let leftView = UIView(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height * 0.35, width: UIScreen.main.bounds.size.width * 0.2, height: UIScreen.main.bounds.size.width * 0.6))
        let rightView = UIView(frame: CGRect(x: UIScreen.main.bounds.size.width * 0.8, y: UIScreen.main.bounds.size.height * 0.35, width: UIScreen.main.bounds.size.width * 0.2, height: UIScreen.main.bounds.size.width * 0.6))
        
        topView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        bottomView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        leftView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        rightView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        
        let label = UILabel(frame: CGRect(x: 0, y: 10, width: UIScreen.main.bounds.size.width, height: 21))
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.white
        label.text = "将二维码/条形码放入扫描框内，开始扫描"
        
        bottomView.addSubview(label)
        
        self.addSubview(topView)
        self.addSubview(bottomView)
        self.addSubview(leftView)
        self.addSubview(rightView)
    }
    
    func moveScannerLayer(){
        self.scanLine.frame.origin.y = 0
        UIView.animate(withDuration: 2) {
            self.scanLine.frame.origin.y += self.scanLine.frame.origin.y + self.scanScope.frame.size.height - 2
        }
    }
    
    //override draw方法增加矩形的四个角
    override func draw(_ rect: CGRect) {
        
    }

}
