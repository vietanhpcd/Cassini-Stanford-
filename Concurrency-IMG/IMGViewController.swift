//
//  IMGViewController.swift
//  Concurrency-IMG
//
//  Created by vietanh on 1/17/18.
//  Copyright © 2018 vietanh. All rights reserved.
//

import UIKit

class IMGViewController: UIViewController {
    
    // MARK: User Interface
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.delegate = self
            scrollView.contentSize = imageView.frame.size
            scrollView.addSubview(imageView)
            
            scrollView.minimumZoomScale = 0.03
            scrollView.maximumZoomScale = 1.0
        }
    }

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    // MARK: Model
    var imageURL: URL? {
        didSet {
            image = nil
            if view.window != nil {  // if we're on screen
                fetchImage()         // then fetch image
            }
        }
    }
    
    
    // MARK: Private Implementation
    private func fetchImage() {
        guard let url = imageURL  else {return}
        if let img = Cache.cache.object(forKey: url as NSURL){
            image = img
        } else {
            spinner.startAnimating()
            DispatchQueue.global(qos: .userInitiated).async {
                guard let imageData = try? Data(contentsOf: url) else {
                    self.spinner.stopAnimating()
                    return}
                DispatchQueue.main.async {
                    self.image = UIImage(data: imageData)
                    self.spinner.stopAnimating()
                    Cache.cache.setObject(self.image!, forKey: url as NSURL)
                }
            }
        }
    }
    
    var imageView = UIImageView()
    private var image: UIImage? {
        set {
            imageView.image = newValue
            imageView.sizeToFit()
        }
        get {
            return imageView.image
        }
    }
 
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if image == nil {   // we're about to appear on screen so, if needed
            fetchImage()    // fetch image
        }
    }
}

// MARK: UIScrollViewDelegate
// Extension which makes ImageViewController conform to UIScrollViewDelegate
// Handles viewForZooming(in scrollView:)
// by returning the UIImageView as the view to transform when zooming

extension IMGViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
