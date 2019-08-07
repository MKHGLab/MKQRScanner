//
//  MKQRScanner.swift
//  MKQRScanner
//
//  Created by Md. Kamrul Hasan on 8/6/19.
//  Copyright © 2019 MKHG Lab. All rights reserved.
//

import UIKit

public protocol MKQRScannerDelegate: class {
    func scanSuccessful(result: String)
    func scanFailed(error: Error)
    func scanCanceled()
}

public class MKQRScanner {
    var viewController: QRScannerVC?
    var oldRootVC: UINavigationController?
    var navigationController: UINavigationController?
    
    weak var delegate: MKQRScannerDelegate?
    
    public init(navigationController: UINavigationController?, delegate: MKQRScannerDelegate?) {
        self.navigationController = navigationController
        self.delegate = delegate
    }
    
    public func start() {
        viewController = QRScannerVC()
        viewController?.delegate = self
        navigationController?.present(viewController!, animated: true, completion: nil)
    }
}

extension MKQRScanner: QRScannerVCDelegate {
    public func scanSuccessful(result: String) {
        delegate?.scanSuccessful(result: result)
    }
    public func scanCanceled() {
        delegate?.scanCanceled()
    }
    public func errorOccured(error: Error) {
        delegate?.scanFailed(error: error)
    }
}
