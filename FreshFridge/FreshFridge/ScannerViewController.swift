//
//  ScannerViewController.swift
//  FreshFridge
//
//  Created by changae choi on 2021/01/26.
//

import UIKit
import Foundation
import AVFoundation

protocol BarcodeDataDelegate
{
    func sendBarcode(_ code: String)
}

class ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate
{
    var delegate: BarcodeDataDelegate?
    
    var code: String = ""
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    var lineView: UIImageView! = nil
    var imageView: UIImageView! = nil
    var opaqueView: UIView! = nil
    var labelView: UILabel! = nil
    var resultLabel: UILabel! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black
        captureSession = AVCaptureSession()

        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput

        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }

        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }

        let metadataOutput = AVCaptureMetadataOutput()

        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)

            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.ean8, .ean13, .pdf417]
        } else {
            failed()
            return
        }

        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        
        
        // adding box
        let boxWidth = 300
        let boxHeight = 180
        let centerX = view.bounds.width * 0.5
        let centerY = view.bounds.height * 0.4
        
        let cgRect = CGRect(x: Int(centerX) - Int( Double(boxWidth) * 0.5), y: Int(centerY) - Int(Double(boxHeight) * 0.5), width: boxWidth, height: boxHeight)
        
        lineView = UIImageView()
        lineView.frame = cgRect
        lineView.backgroundColor = UIColor.clear
        lineView.isOpaque = false
        lineView.layer.cornerRadius = 3
        lineView.layer.borderColor =  UIColor.white.cgColor
        lineView.layer.borderWidth = 3
        lineView.layer.masksToBounds = true
        view.addSubview(lineView)
        
        opaqueView = UIView()
        opaqueView.frame = view.bounds
        opaqueView.layer.backgroundColor = CGColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.2)
        mask(viewToMask: opaqueView, maskRect: cgRect, invert: true)
        previewLayer.addSublayer(opaqueView.layer)
        
        imageView = UIImageView()
        imageView.frame = CGRect(x: Int(centerX) - Int( Double(boxWidth) * 0.5), y: Int(centerY) + Int(Double(boxHeight) * 0.5), width: 44, height: 44)
        imageView.image = UIImage(systemName: "barcode")
        imageView.tintColor = UIColor.white
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        
        labelView = UILabel()
        labelView.frame = CGRect(x: Int(centerX) - Int( Double(boxWidth) * 0.5) + 44, y: Int(centerY) + Int(Double(boxHeight) * 0.5), width: boxWidth, height: 44)
        labelView.text = "프레임 안에 바코드를 위치시키세요"
        labelView.textColor = UIColor.white
        labelView.textAlignment = .left
        view.addSubview(labelView)
        
        resultLabel = UILabel()
        resultLabel.frame = CGRect(x: Int(centerX) - Int( Double(boxWidth) * 0.5), y: Int(centerY) - Int(Double(boxHeight) * 0.5) - 44, width: boxWidth, height: 44)
        resultLabel.text = ""
        resultLabel.textColor = UIColor.white
        resultLabel.textAlignment = .center
        view.addSubview(resultLabel)
        
        captureSession.startRunning()

        NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: UIDevice.orientationDidChangeNotification, object: nil)
    }

    deinit {
       NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
    }

    @objc func rotated()
    {
        if UIDevice.current.orientation.isLandscape
        {
            print("Landscape")
        }
        else
        {
            print("Portrait")
        }
        
        previewLayer.frame = view.layer.bounds
    
        // adding box
        let boxWidth = 300
        let boxHeight = 180
        let centerX = view.bounds.width * 0.5
        let centerY = view.bounds.height * 0.4
        
        let cgRect = CGRect(x: Int(centerX) - Int( Double(boxWidth) * 0.5), y: Int(centerY) - Int(Double(boxHeight) * 0.5), width: boxWidth, height: boxHeight)
        lineView.frame = cgRect
        opaqueView.frame = view.bounds
        mask(viewToMask: opaqueView, maskRect: cgRect, invert: true)
        imageView.frame = CGRect(x: Int(centerX) - Int( Double(boxWidth) * 0.5), y: Int(centerY) + Int(Double(boxHeight) * 0.5), width: 44, height: 44)
        labelView.frame = CGRect(x: Int(centerX) - Int( Double(boxWidth) * 0.5) + 44, y: Int(centerY) + Int(Double(boxHeight) * 0.5), width: boxWidth, height: 44)
        resultLabel.frame = CGRect(x: Int(centerX) - Int( Double(boxWidth) * 0.5), y: Int(centerY) - Int(Double(boxHeight) * 0.5) - 44, width: boxWidth, height: 44)
    }
    
    func mask(viewToMask: UIView, maskRect: CGRect, invert: Bool = false) {
        let maskLayer = CAShapeLayer()
        let path = CGMutablePath()
        if (invert) {
            path.addRect(viewToMask.bounds)
        }
        path.addRect(maskRect)

        maskLayer.path = path
        if (invert) {
            maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
        }

        // Set the mask of the view.
        viewToMask.layer.mask = maskLayer;
    }
    
    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }

    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection)
    {
        //captureSession.stopRunning()

        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
            
            if(stringValue.isEmpty == true)
            {
                resultLabel.text = "바코드를 인식하지 못했습니다."
                return
            }
            else
            {
                captureSession.stopRunning()
                dismiss(animated: true)
            }
        }
    }

    func found(code: String) {
        print(code)
        if let delegate = delegate
        {
            delegate.sendBarcode(code)
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}