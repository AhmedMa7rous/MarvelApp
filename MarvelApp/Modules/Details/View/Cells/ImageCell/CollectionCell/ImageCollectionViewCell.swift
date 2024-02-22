//
//  ImageCollectionViewCell.swift
//  MarvelApp
//
//  Created by Ahmed Mahrous on 22/02/2024.
//

import UIKit
import  Kingfisher

class ImageCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Outlet Connections
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var imageTitleLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layoutIfNeeded()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0))
    }
    
    //MARK: - Support Functions
    ///This function responsible for every thing related with UI
    func updateUi() {
        
    }
    
    //MARK: - Public Functions
    func configure(forImage image: String, withTitle title: String) {
        let imageUrl = URL(string: image)
        detailImageView.kf.setImage(with: imageUrl)
        imageTitleLabel.text = title
    }
}
