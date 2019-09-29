//
//  YXToast.swift
//  XADJ
//
//  Created by yunxin bai on 2019/9/11.
//  Copyright © 2019 yunxin bai. All rights reserved.
//

import UIKit

class YXToast {
    
    var showView: UIView?
    var indicate: YXIndicateView?
    static let shared = YXToast()
    private init(){}
    
    let showWidth: CGFloat = 220
    let padding: CGFloat = 20
}

// MARK: - Open Class Method
extension YXToast {
    class func showToast(_ message: String) {
        showToast(message, duration: self.shared.getTimer(message))
    }
    
    class func showToast(_ message: String, duration: TimeInterval) {
        self.shared.showToast(message, duration: duration)
    }
    
    class func showIndicate() {
        showIndicate(nil)
    }
    
    class func showIndicate(_ message: String?) {
        self.shared.showIndicate(message)
    }
    
    class func hideToast() {
        self.shared.hideToast()
    }
}

// MARK: - Open Instance Method
extension YXToast {
    
    /// 一定时间后自动消失
    func showToast(_ message: String) {
        let timer = getTimer(message)
        showToast(message, duration: timer)
    }
    /// duration 后消失
    func showToast(_ message: String, duration: TimeInterval) {
        let background = getBackGroundView()
        let label = getLabel(message)
        let (backFrame,labelFrame) = getRect(message)
        label.frame = labelFrame
        background.frame = backFrame
        background.addSubview(label)
        showWithAnimation(background)

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) {
            self.hideWithAnimation(background)
        }
    }
    
    /// 展示指示器
    func showIndicate() {
        showIndicate(nil)
    }
    
    /// 展示带有文本的指示器
    func showIndicate(_ message: String?) {
        
        if showView == nil {
            showView = getBackGroundView()
            showView?.frame = getRect()
        }
        if indicate == nil {
            indicate = YXIndicateView()
        }else {
            indicate?.end()
            indicate?.removeFromSuperview()
        }
        if let msg = message {
            let label = getLabel(msg)
            let (backFrame,labelFrame) = getRect(msg)
            
            showView?.addSubview(label)
            showView?.frame = CGRect(x: backFrame.origin.x, y: backFrame.origin.y, width: backFrame.width, height: backFrame.height + getRect().height + 10)
            indicate?.frame = CGRect(x: (showView!.frame.width-getRect().width)*0.5, y: 10, width: getRect().width, height: getRect().height)
            label.frame = CGRect(x: labelFrame.origin.x, y: getRect().height+15, width: labelFrame.width, height: labelFrame.height)
        }else {
            indicate?.frame = showView!.bounds
        }
        showView?.addSubview(indicate!)
        indicate?.start()
        showWithAnimation(showView!)
    }
    
    func hideToast() {
        if indicate == nil {
            return
        }
        indicate?.end()
        if showView == nil {
            return
        }
        hideWithAnimation(showView!)
    }
    
}

// MARK: - Private Method
extension YXToast {
    fileprivate func showWithAnimation(_ view: UIView) {
        DispatchQueue.main.async {
            view.alpha = 0.1
            let currenVC = XATools.getCurrentVC()
            currenVC.view.addSubview(view)
            UIView.animate(withDuration: 0.20) {
                view.alpha = 1.0
            }
        }
    }
    
    fileprivate func hideWithAnimation(_ view: UIView) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.20, animations: {
                view.alpha = 0.1
            }) { (bool) in
                view.removeFromSuperview()
            }
        }
    }
}

//MARK: - SetupUI
extension YXToast {
    
    fileprivate func getBackGroundView() -> UIView{
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        view.layer.cornerRadius = 5
        return view
    }
    
    fileprivate func getLabel(_ message: String) -> UILabel {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = FONT16
        label.text = message
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }
    
    fileprivate func getRect(_ message: String)->(CGRect, CGRect) {
        let label = getLabel(message)
        let size = label.frame.size
        var x,y,w,h,x1,y1,w1,h1: CGFloat

        if size.width > showWidth {
            let msgSize = message.yx_getSize(FONT16, width: showWidth)
            w = showWidth + padding
            h = msgSize.height + padding
                        w1 = showWidth
            h1 = msgSize.height
        }else {
            w = size.width+padding
            h = size.height+padding
            w1 = size.width
            h1 = size.height
        }
        x = (YX_SCREEN_WIDTH - w)*0.5
        y = (YX_SCREEN_HEIGHT - h)*0.5
        x1 = padding * 0.5
        y1 = padding * 0.5
        return (CGRect(x: x, y: y, width: w, height: h), CGRect(x: x1, y: y1, width: w1, height: h1))
    }
    
    fileprivate func getRect()->(CGRect) {
        let width: CGFloat = 50
        let height: CGFloat = 50
        let x = (YX_SCREEN_WIDTH - width) * 0.5
        let y = (YX_SCREEN_HEIGHT - height) * 0.5
        return (CGRect(x: x, y: y, width: width, height: height))
    }
    
    fileprivate func getTimer(_ message: String) -> TimeInterval{
        var timer = 2.0
        if message.count > 100 {
            timer = 10.0
        }else if message.count > 80 {
            timer = 8.0
        }else if message.count > 60 {
            timer = 6.0
        }else if message.count > 40 {
            timer = 4.0
        }else if message.count > 20 {
            timer = 3.0
        }
        return timer
    }
}
