//
//  PhotoLibraryViewController.swift
//  UdemySwift
//
//  Created by 이기완 on 2018. 3. 25..
//  Copyright © 2018년 이기완. All rights reserved.
//

import UIKit
import Vision


class PhotoLibraryViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate{

    @IBOutlet weak var selectedImageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var percentLabel: UILabel!
    
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    var selectedImage: UIImage? {
        didSet {
            selectedImageView.image = selectedImage
        }
    }
    
    var selectedCIIMage: CIImage? {
        get {
            if let selectedImage = selectedImage {
                return CIImage.init(image: selectedImage)
            }
            else {
                return nil
            }
        }
    }
    
    //MARK: - life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func addButtonTouched(_ sender: UIBarButtonItem) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let importPhoto = UIAlertAction(title: "앨범에서 가져오기", style: .default) { _ in
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .savedPhotosAlbum
            picker.allowsEditing = true
            
            self.present(picker, animated: true, completion: nil)
        }
        
        let takePhoto  = UIAlertAction(title: "카메라로 찍기", style: .default) {_ in
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .camera
            picker.cameraCaptureMode = .photo
            picker.allowsEditing = true
            
            self.present(picker, animated: true, completion: nil)
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        actionSheet.addAction(importPhoto)
        actionSheet.addAction(takePhoto)
        actionSheet.addAction(cancel)
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    //MARK: - UIImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage{
            selectedImage = image
            
            self.indicatorView.startAnimating()
            DispatchQueue.global(qos: .userInitiated).async {
                
                self.detectObject()
            }
        }
    }
    
    func detectObject() {
        if let ciImage = selectedCIIMage {
            do {
                let vnCoreMLModel = try VNCoreMLModel(for: Inceptionv3().model)
                let request = VNCoreMLRequest(model: vnCoreMLModel, completionHandler: handleReuqestResult)
                request.imageCropAndScaleOption = .centerCrop
                
                let requestHandler = VNImageRequestHandler(ciImage: ciImage, options: [ : ])
                
                try requestHandler.perform([request])
                
            } catch {
                print(error)
            }
        }
    }
    
    func handleReuqestResult(request: VNRequest, error: Error?) {
        if let result = request.results?.first as? VNClassificationObservation {
            
            DispatchQueue.main.async {
                self.categoryLabel.text = result.identifier
                self.percentLabel.text = "\(String.init(format: "%.1f", result.confidence * 100)) %"
                self.indicatorView.stopAnimating()
            }
        
        }
    }
    
}
