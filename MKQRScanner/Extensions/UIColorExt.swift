//
//  UIColorExt.swift
//  MKQRScanner
//
//  Created by Md. Kamrul Hasan on 8/21/19.
//  Copyright © 2019 MKHG Lab. All rights reserved.
//

import UIKit

extension UIColor {
    
    static let darkYellow = UIColor(hex: "#CCCC00")
    
    convenience init (hex:String) {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            let index = cString.index(cString.startIndex, offsetBy: 1)
            cString = String(cString[index...])
        }
        
        if ((cString.count) != 6) {
            fatalError("invalid hex color")
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: CGFloat(1.0)
        )
        
        
    }
}
