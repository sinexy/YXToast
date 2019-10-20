//
//  XATools.swift
//  XADJ
//
//  Created by yunxin bai on 2019/9/11.
//  Copyright © 2019 yunxin bai. All rights reserved.
//

import UIKit

class XATools {
    static let shared = XATools()
    private init(){}
    
    ///获取当前显示的控制器 UIWindow (Visible)
    class func getCurrentVC() -> UIViewController {
        let keywindow = (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController//UIApplication.shared.keyWindow
        let rootVC = keywindow!//UIApplication.shared.keyWindow!.rootViewController!
        return getVisibleViewControllerFrom(vc: rootVC)
    }
     
    //方法1
    class func getVisibleViewControllerFrom(vc: UIViewController) -> UIViewController {
        
        if vc.isKind(of: UINavigationController.self) {
            return getVisibleViewControllerFrom(vc: (vc as! UINavigationController).visibleViewController!)
        } else if vc.isKind(of: UITabBarController.self) {
            return getVisibleViewControllerFrom(vc: (vc as! UITabBarController).selectedViewController!)
        } else {
            if (vc.presentedViewController != nil) {
                return getVisibleViewControllerFrom(vc: vc.presentedViewController!)
            } else {
                return vc
            }
        }
        
    }
     
    //方法2
    class func topViewControllerWithRootViewController(rootVC: UIViewController) -> UIViewController {
        
        if rootVC.isKind(of: UITabBarController.self) {
            let tabVC = rootVC as! UITabBarController
            return topViewControllerWithRootViewController(rootVC: tabVC.selectedViewController!)
        } else if rootVC.isKind(of: UINavigationController.self) {
            let navc = rootVC as! UINavigationController
            return topViewControllerWithRootViewController(rootVC: navc.visibleViewController!)
        } else if (rootVC.presentedViewController != nil) {
            return topViewControllerWithRootViewController(rootVC: rootVC.presentedViewController!)
        } else {
            return rootVC
        }
        
    }
     
    ///验证
    class func vcResult2(classType: UIViewController.Type) -> Bool {
        return getCurrentVC().isKind(of: classType)
    }
    
}
