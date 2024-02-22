//
//  PhotoGalleryViewController.swift
//  MarvelApp
//
//  Created by Ahmed Mahrous on 22/02/2024.
//

import UIKit

class PhotoGalleryViewController: UIViewController {
    
    let images: [String]
    let titles: [String]
    let selectedImage: UIImage
    
    init(images: [String], titles: [String], selectedImage: UIImage) {
        self.images = images
        self.titles = titles
        self.selectedImage = selectedImage
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
    
}
