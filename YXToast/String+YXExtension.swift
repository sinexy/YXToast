//
//  String+YXExtension.swift
//  XADJ
//
//  Created by yunxin bai on 2019/9/11.
//  Copyright © 2019 yunxin bai. All rights reserved.
//

import UIKit
import SwiftyJSON

extension String {
    func yx_base64Encoding() -> String {
        let data = self.data(using: .utf8)
        let base64String = data?.base64EncodedString(options: .init(rawValue: 0))
        return base64String ?? ""
    }
    
    func yx_base64Decode() -> String {
        if let _ = self.range(of: ":")?.lowerBound {
            return self
        }
        let base64String = self.replacingOccurrences(of: "-", with: "+").replacingOccurrences(of: "_", with: "/")
        let padding = base64String.count + (base64String.count % 4 != 0 ? (4 - base64String.count % 4) : 0)
        if let decodedData = Data(base64Encoded: base64String.padding(toLength: padding, withPad: "=", startingAt: 0), options: NSData.Base64DecodingOptions(rawValue: 0)), let decodedString = NSString(data: decodedData, encoding: String.Encoding.utf8.rawValue) {
            return decodedString as String
        }
        return ""
    }
    
    
    func yx_getSize(_ font: UIFont, width: CGFloat) -> CGSize {
        return NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(Int.max)), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : font], context: nil).size
    }
    
    func yx_isNotEmpty() -> Bool {
        return true
    }
    
    func yx_isPhoneNumber() -> Bool {
        if let _ = self.range(of: "^1[0-9]{10}$",options: .regularExpression) {
            return true
        }
        return false
    }
}
