//
//  QRScannerVC+AVCaptureDelegate.swift
//  MKQRScanner
//
//  Created by Md. Kamrul Hasan on 8/6/19.
//  Copyright © 2019 MKHG Lab. All rights reserved.
//

import UIKit
import AudioToolbox
import AVFoundation

extension QRScannerVC: AVCaptureMetadataOutputObjectsDelegate {
    // the metadataOutput function informs our delegate (the ScannerViewController) that the captureOutput emitted a new metaData Object
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects.count == 0 {
            print("no objects returned")
            return
        }
        
        let metaDataObject = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        guard let StringCodeValue = metaDataObject.stringValue else {
            return
        }
        
        view.addSubview(codeFrame)
        
        //
        //Below portion to draw the boundary of detected QR image
        //Ignoring for now
        //
        /*
        //transformedMetaDataObject returns layer coordinates/height/width from visual properties
        guard let metaDataCoordinates = videoPreviewLayer?.transformedMetadataObject(for: metaDataObject) else {
            return
        }
        
        Those coordinates are assigned to our codeFrame
        codeFrame.frame = metaDataCoordinates.bounds
        */
        AudioServicesPlayAlertSound(systemSoundId)
        
        captureSession?.stopRunning()
        
        delegate?.scanSuccessful(result: StringCodeValue)
        delegate = nil //ignoring multiple scan results
        dismissVC()
    }
}
