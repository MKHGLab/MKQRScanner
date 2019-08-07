//
//  QRScannerVC+ButtonAction.swift
//  MKQRScanner
//
//  Created by Md. Kamrul Hasan on 8/6/19.
//  Copyright © 2019 MKHG Lab. All rights reserved.
//

import UIKit

extension QRScannerVC {
    @objc func cancelTapped(_ sender: Any) {
        delegate?.scanCanceled()
        dismissVC()
    }
}
