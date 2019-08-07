//
//  UIImageExt.swift
//  MKQRScanner
//
//  Created by Md. Kamrul Hasan on 8/7/19.
//

import UIKit

extension UIImage {
    public static var crossImage: UIImage? {
        let bundle = Bundle(for: self)
        return UIImage(named: "cross", in: bundle, compatibleWith: nil)
    }
}
