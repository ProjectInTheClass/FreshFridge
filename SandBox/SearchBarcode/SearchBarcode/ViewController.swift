//
//  ViewController.swift
//
//  Created by changae choi on 2020/12/31.
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

        captureSession.startRunning()

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
        }
        
        captureSession.stopRunning()

        dismiss(animated: true)
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

class ViewController: UIViewController, BarcodeDataDelegate
{
    @IBOutlet var barcodeTextField: UITextField!
    @IBOutlet var resultTextView: UITextView!
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL, view: UIImageView!) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                view!.image = UIImage(data: data)
            }
        }
    }
    
    func flushControls()
    {
        resultTextView.text = ""
        imageView.image = UIImage()
    }
    
    @IBAction func barcodeScanButtonTapped(_ sender: Any)
    {
        flushControls()
        
        let scannerViewController = ScannerViewController()
        scannerViewController.delegate = self
        present(scannerViewController, animated: true, completion: nil )
    }
    
    @IBAction func requestTapped()
    {
        flushControls()
        let barcodeString: String = barcodeTextField.text != nil ? barcodeTextField.text! : " "
        
        FetchDataFoodSafetyKorea.shared.requestBarcodeProductInfo(barcodeString: barcodeString){
            (resultString) in
            
            DispatchQueue.main.async {
                
                self.resultTextView.text = resultString
            }
        }
    }
    
    func sendBarcode(_ code: String)
    {
        DispatchQueue.main.async
        {
            self.barcodeTextField.text = code
        }
        
    }
    
    @IBAction func beepscanRequestTapped(_ sender: Any)
    {
        flushControls()
        let barcode = barcodeTextField.text != nil ? barcodeTextField.text! : " "
        
        let searchTerm = [("<meta content=", " name="), ("<img src="," ")]
        WebScrapper.shared.scrapingInfo(webAddress: String(format: "https://www.beepscan.com/barcode/%@", barcode), searchStartEnd: searchTerm)
        { [self] (resultString, isSuccess) in
            if(isSuccess)
            {
                if(resultString.count > 0)
                {
                    self.resultTextView.text = resultString[0]
                }
                
                if(resultString.count > 1)
                {
                    let link = resultString[1]
                    if let url = URL(string: link)
                    {
                        self.imageView.image = UIImage(named: "loadingImage")
                        self.downloadImage(from: url, view: imageView)
                    }
                }
            }
        } // end of closer
    }
    
    @IBAction func requestGoogleTapped(_ sender: Any)
    {
        flushControls()
        var barcodeString = barcodeTextField.text != nil ? barcodeTextField.text! : " "
        barcodeString += "+barcode"
        
        GoogleSearcher.shared.searchImageForTerm(term: barcodeString, page: 1)
        { [self] (isSuccess) in
            
            if(isSuccess)
            {
                if(GoogleSearcher.shared.resultLinks.count > 0 )
                {
                    let link = GoogleSearcher.shared.resultLinks[0]
                    if let url = URL(string: link)
                    {
                        self.imageView.image = UIImage(named: "loadingImage")
                        self.downloadImage(from: url, view: imageView)
                    }
                }
            }
        }
    }
    
    @IBAction func scrapingKoreanNetTapped(_ sender: Any)
    {
        flushControls()
        let barcode = barcodeTextField.text ?? ""
        let webAddress = String(format: "http://www.koreannet.or.kr/home/hpisSrchGtin.gs1?gtin=%@", barcode)
        let searchTerm = [("<div class=\"productTit\">","</div>"),
                          ("<div class=\"imgArea\">","</div>")]
        
        WebScrapper.shared.scrapingInfo(webAddress: webAddress, searchStartEnd: searchTerm)
        { [self] (resultString, isSuccess) in
            if(isSuccess)
            {
                if(resultString.count > 0)
                {
                    var trimmedString = resultString[0]
                    trimmedString = WebScrapper.shared.trimmingString(in: trimmedString, trim: "&nbsp;")
                    print(trimmedString)
                    
                    trimmedString = WebScrapper.shared.trimmingString(in: trimmedString, trim: barcode)
                    print(trimmedString)
                    
                    trimmedString = trimmedString.trimmingCharacters(in: .whitespacesAndNewlines)
                    print(trimmedString)
                    
                    self.resultTextView.text = trimmedString
                }
                
                if(resultString.count > 1)
                {
                    var trimmedString = resultString[1]
                    trimmedString = WebScrapper.shared.trimmingString(in: trimmedString, trim: "<img src=\"")
                    print(trimmedString)
                    
                    trimmedString = WebScrapper.shared.trimmingAfterString(in: trimmedString, trim: " width=\"392\" height=\"260\" id=\"detailImage\" />")
                    print(trimmedString)
                    
                    trimmedString = trimmedString.trimmingCharacters(in: .whitespacesAndNewlines)
                    print(trimmedString)
                    
                    let link = trimmedString
                    if let url = URL(string: link)
                    {
                        self.imageView.image = UIImage(named: "loadingImage")
                        self.downloadImage(from: url, view: imageView)
                    }
                }
            }
        } // end of closer
        
    }
}

