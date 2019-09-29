//
//  YXIndicateView.swift
//  XADJ
//
//  Created by yunxin bai on 2019/9/12.
//  Copyright © 2019 yunxin bai. All rights reserved.
//

import UIKit

class YXIndicateView: UIView {
    
    override func draw(_ rect: CGRect) {

        let ctx = UIGraphicsGetCurrentContext()
        
        let x = rect.width * 0.5
        let y = x
        let length: CGFloat = rect.width * 0.4
        for i in 0..<360 {
            if i % 30 == 0 {
                
                let c = CGFloat(Double(i)/360.0)+0.5
                let color = UIColor.init(red: c, green: c, blue: c, alpha: 1)
                let degrees = Double.pi * Double(i) / 180.0
                let x1 = x + length * cos(CGFloat(degrees))
                let y1 = y - length * sin(CGFloat(degrees))
                let x2 = x + rect.width*0.2 * cos(CGFloat(degrees))
                let y2 = y - rect.width*0.2 * sin(CGFloat(degrees))
                ctx?.setStrokeColor(color.cgColor)
                ctx?.setLineWidth(2.0)
                ctx?.move(to: CGPoint(x: x2, y: y2))
                ctx?.addLine(to: CGPoint(x: x1, y: y1))
                ctx?.strokePath()
            }
        }

    }
}


extension YXIndicateView {
    func start() {
        let rotaionAniamtion = CABasicAnimation.init(keyPath: "transform.rotation.z")
        rotaionAniamtion.toValue = Double.pi * 0.4
        rotaionAniamtion.fromValue = 0
        rotaionAniamtion.isCumulative = true
        rotaionAniamtion.repeatCount = Float(Int.max)
        self.layer.add(rotaionAniamtion, forKey: "rotationAnimation")
        
        self.backgroundColor = UIColor.clear
    }
    
    func end() {
        self.layer.removeAllAnimations()
    }
}
