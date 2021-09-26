//
//  ViewController.swift
//  a815HelloQR
//
//  Created by 申潤五 on 2021/9/26.
//

import UIKit
import AVFoundation


class ViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {

    @IBOutlet weak var outputVideoView: UIView!
    @IBOutlet weak var scanTextLabel: UILabel!
    
    
    let avCaptureSession = AVCaptureSession()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
       
        guard let avCaptureDevice = AVCaptureDevice.default(for: AVMediaType.video) else {return}
        guard let avCaptureInput =
        try? AVCaptureDeviceInput(device: avCaptureDevice) else { return }
        avCaptureSession.addInput(avCaptureInput) //session 加上輸入
   
        
        //建立一個輸出物件，並設定 ViewController 為接受代理人
        let avCaptureMetadataOutput = AVCaptureMetadataOutput()
        avCaptureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main) //輸出時，使用主線程
        avCaptureSession.addOutput(avCaptureMetadataOutput)  //session 加上輸出
        
        //加上支援的類別，這必需要加入 session 之後再做，不然會閃退
        avCaptureMetadataOutput.metadataObjectTypes =  [AVMetadataObject.ObjectType.qr, AVMetadataObject.ObjectType.code128, AVMetadataObject.ObjectType.code39, AVMetadataObject.ObjectType.code93, AVMetadataObject.ObjectType.upce, AVMetadataObject.ObjectType.pdf417, AVMetadataObject.ObjectType.ean13, AVMetadataObject.ObjectType.aztec]
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
 
        //把輸入的圖層加到畫面中的圖層中，讓使用者可以看到
        let avCaptureVidoePreviewLayer = AVCaptureVideoPreviewLayer(session: avCaptureSession)
        avCaptureVidoePreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        avCaptureVidoePreviewLayer.frame = outputVideoView.bounds
        self.outputVideoView.layer.addSublayer(avCaptureVidoePreviewLayer)
        
        //第一次啟動
        avCaptureSession.startRunning()

    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
            if metadataObjects.count > 0 {
                let machineReabableCode = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
                scanTextLabel.text = machineReabableCode.stringValue

            }
        }
}

