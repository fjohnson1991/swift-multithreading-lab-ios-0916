//
//  ImageViewController.swift
//  swift-multithreading-lab
//
//  Created by Ian Rahman on 7/28/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import UIKit
import CoreImage


//MARK: Image View Controller

class ImageViewController : UIViewController {
    
    var scrollView: UIScrollView!
    var imageView = UIImageView()
    let picker = UIImagePickerController()
    var activityIndicator = UIActivityIndicatorView()
    let filtersToApply = ["CIBloom",
                          "CIPhotoEffectProcess",
                          "CIExposureAdjust"]
    
    let flatigram = Flatigram()
    
    //    var flatigram = Flatigram()
    
    @IBOutlet weak var filterButton: UIBarButtonItem!
    @IBOutlet weak var chooseImageButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        setUpViews()
    }
    
    @IBAction func cameraButtonTapped(_ sender: Any) {
        selectImage()
    }
    
    @IBAction func filterButtonTapped(_ sender: AnyObject) {
        
        if flatigram.state == .filtered {
            presentFilteredAlert()
        } else {
            startProcess()
        }
    }
}



extension ImageViewController {
    func filterImage(with completion: @escaping (Bool) -> Void) {
        let queue = OperationQueue()
        queue.name = "Image Filtration Queue"
        queue.qualityOfService = .userInitiated
        queue.maxConcurrentOperationCount = 1
        
        for filter in filtersToApply {
            
            let filtered = FilterOperation(flatigram: flatigram, filter: filter)
            filtered.completionBlock = {
                if queue.operationCount == 0 {
                    DispatchQueue.main.async {
                        self.flatigram.state = .filtered
                        completion(true)
                    }
                }
            }
            
            queue.addOperation(filtered)
            print("Added FilterOperation with \(filter) to \(queue.name!)")
        }
    }
    
    
    func startProcess() {
        activityIndicator.startAnimating()
        filterButton.isEnabled = false
        chooseImageButton.isEnabled = false

        filterImage { (success) in
            print(success)
            self.filterButton.isEnabled = true
            self.chooseImageButton.isEnabled = true
            self.activityIndicator.stopAnimating()
            self.imageView.image = self.flatigram.image
        }
    }
}





