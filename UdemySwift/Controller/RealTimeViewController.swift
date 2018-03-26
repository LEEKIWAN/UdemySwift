//
//  RealTimeViewController.swift
//  UdemySwift
//
//  Created by 이기완 on 2018. 3. 25..
//  Copyright © 2018년 이기완. All rights reserved.
//

import UIKit
import Vision

class RealTimeViewController: UIViewController {

    var videoCapture: VideoCapture!
    
    @IBOutlet weak var cameraView: UIView!
    
    let visionRequestHandler = VNSequenceRequestHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let spec = VideoSpec(fps: 3, size: CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height))
        videoCapture = VideoCapture(cameraType: CameraType.back, preferredSpec: spec, previewContainer: cameraView.layer)
        
        videoCapture.imageBufferHandler = { (imageBuffer, timestamp, outputBuffer) in
            self.detectObject(image: imageBuffer)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        videoCapture.startCapture()
    }
    override func viewWillDisappear(_ animated: Bool) {
        videoCapture.stopCapture()
    }
    
    func detectObject(image: CVImageBuffer) {
        
        
        do {
            let vnCoreMlModel = try VNCoreMLModel(for: Inceptionv3().model)
            let request = VNCoreMLRequest(model: vnCoreMlModel, completionHandler: self.handleObjectDetection)
            request.imageCropAndScaleOption = .centerCrop
            
            try visionRequestHandler.perform([request], on: image)
            
        } catch {
            print(error)
        }
        
    }
    
    func handleObjectDetection(request: VNRequest, error: Error?) {
        if let result = request.results?.first as? VNClassificationObservation {
            print("\(result.identifier) : \(result.confidence)")
        }
    }
    
}
