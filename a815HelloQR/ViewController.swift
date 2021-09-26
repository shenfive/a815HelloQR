//
//  ViewController.swift
//  a815HelloQR
//
//  Created by 申潤五 on 2021/9/26.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {

    @IBOutlet weak var outputVideoView: UIView!
    @IBOutlet weak var scanTextLabel: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let avCaptureSession = AVCaptureSession()
        guard let avCaptureDevice = AVCaptureDevice.default(for: AVMediaType.video) else {return}
        guard let avCaptureInput =
        try? AVCaptureDeviceInput(device: avCaptureDevice) else { return }
        avCaptureSession.addInput(avCaptureInput) //session 加上輸入
         
    }


}

