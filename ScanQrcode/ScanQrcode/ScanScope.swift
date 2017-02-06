//
//  ScanScope.swift
//  ScanQrcode
//
//  Created by DamonLi on 2017/2/6.
//  Copyright © 2017年 Pioneer. All rights reserved.
//

import UIKit

class ScanScope: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.white.cgColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let path = UIBezierPath()
        UIColor.green.setStroke()
        path.lineWidth = 6.0
        //左上
        path.move(to: CGPoint(x: 0, y: 16))
        path.addLine(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 16, y: 0))
        path.stroke()
        //右上
        path.move(to: CGPoint(x: rect.size.width - 16 , y: 0))
        path.addLine(to: CGPoint(x: rect.size.width, y: 0))
        path.addLine(to: CGPoint(x: rect.size.width, y: 16))
        path.stroke()
        //左下
        path.move(to: CGPoint(x: 0, y: rect.size.height - 16))
        path.addLine(to: CGPoint(x: 0, y: rect.size.height))
        path.addLine(to: CGPoint(x: 16, y: rect.size.height))
        path.stroke()
        //右下
        path.move(to: CGPoint(x: rect.size.width, y: rect.size.height - 16))
        path.addLine(to: CGPoint(x: rect.size.width, y: rect.size.height))
        path.addLine(to: CGPoint(x: rect.size.width - 16, y: rect.size.height))
        path.stroke()
    }

}
