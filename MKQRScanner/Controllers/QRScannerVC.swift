//
//  QRScannerVC.swift
//  MKQRScanner
//
//  Created by Md. Kamrul Hasan on 8/5/19.
//  Copyright © 2019 MKHG Lab. All rights reserved.
//

import UIKit
import AVFoundation

protocol QRScannerVCDelegate: class {
    func scanSuccessful(result: String)
    func errorOccured(error: Error)
    func scanCanceled()
}

class QRScannerVC: UIViewController {
    
    private func getBundle() -> Bundle? {
        let podBundle = Bundle(for: QRScannerVC.self)
        if let url = podBundle.url(forResource: "MKQRScanner", withExtension: "bundle") {
            let bundle = Bundle(url: url)
            return bundle
        }
        return nil
    }
    
    private func getImageFromBundle(name: String) -> UIImage? {
        return UIImage(named: name, in: getBundle(), compatibleWith: nil)
    }
    
    var cancelButton: UIButton!
    var focusIV: UIImageView!
    var infoLabel: UILabel!
    let systemSoundId : SystemSoundID = 1016
    
    //captureSession manages capture activity and coordinates between input device and captures outputs
    var captureSession:AVCaptureSession?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    
    //Empty Rectangle with green border to outline detected QR or BarCode
    let codeFrame:UIView = {
        let codeFrame = UIView()
        codeFrame.layer.borderColor = UIColor.red.cgColor
        codeFrame.layer.borderWidth = 1.5
        codeFrame.frame = CGRect.zero
        codeFrame.translatesAutoresizingMaskIntoConstraints = false
        return codeFrame
    }()
    
    weak var delegate: QRScannerVCDelegate?
    
    override public func viewDidDisappear(_ animated: Bool) {
        captureSession?.stopRunning()
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        captureSession?.startRunning()
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        cancelButton = UIButton(frame: CGRect(x: 16, y: 36, width: 48, height: 48))
        cancelButton.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        cancelButton.layer.cornerRadius = 24
        cancelButton.setTitle("✕", for: .normal)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        cancelButton.titleLabel?.textColor = .white
        cancelButton.addTarget(self, action: #selector(cancelTapped(_:)), for: .touchUpInside)
        self.view.addSubview(cancelButton)
        
        let width = self.view.bounds.width * 0.6
        let center = self.view.center
        let focus = getImageFromBundle(name: "focus")?.tint(with: UIColor.darkYellow)
        focusIV = UIImageView(image: focus)
        focusIV.frame = CGRect(x: center.x - width/2, y: center.y - width/2, width: width, height: width)
        focusIV.tintColor = .yellow
        self.view.addSubview(focusIV)
        
        infoLabel = UILabel(frame: CGRect(x: 0, y: self.view.bounds.height-60, width: self.view.bounds.width, height: 20))
        infoLabel.text = "Put the QR in the frame"
        infoLabel.textColor = UIColor.darkYellow
        infoLabel.textAlignment = .center
        self.view.addSubview(infoLabel)
        
        self.view.backgroundColor = UIColor.white
        startCapturing()
        
    }
    
    func dismissVC() {
        dismiss(animated: true, completion: nil)
    }
    
    func startCapturing() {
        //AVCaptureDevice allows us to reference a physical capture device (video in our case)
        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        
        if let captureDevice = captureDevice {
            
            do {
                
                captureSession = AVCaptureSession()
                
                // CaptureSession needs an input to capture Data from
                let input = try AVCaptureDeviceInput(device: captureDevice)
                captureSession?.addInput(input)
                
                // CaptureSession needs and output to transfer Data to
                let captureMetadataOutput = AVCaptureMetadataOutput()
                captureSession?.addOutput(captureMetadataOutput)
                
                //We tell our Output the expected Meta-data type
                captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
                captureMetadataOutput.metadataObjectTypes = [.code128, .qr,.ean13, .ean8, .code39, .upce, .aztec, .pdf417] //AVMetadataObject.ObjectType
                
                captureSession?.startRunning()
                
                //The videoPreviewLayer displays video in conjunction with the captureSession
                videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
                videoPreviewLayer?.videoGravity = .resizeAspectFill
                videoPreviewLayer?.frame = view.layer.bounds
                view.layer.addSublayer(videoPreviewLayer!)
                
                
                view.bringSubviewToFront(cancelButton)
                view.bringSubviewToFront(focusIV)
                view.bringSubviewToFront(infoLabel)
            }
            catch (let error) {
                delegate?.errorOccured(error: error)
                dismissVC()
            }
        }
    }
}


