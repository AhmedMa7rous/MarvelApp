//
//  SearchTableViewCell.swift
//  MarvelApp
//
//  Created by Ahmed Mahrous on 20/02/2024.
//

import UIKit
import Kingfisher

class SearchTableViewCell: UITableViewCell {
    
    //MARK: - Outlet Connections
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    

    //MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 0.2, right: 0))
    }
    
    //MARK: - Support Functions
    //This function responsible for setting data to UI
    func configure(with image: String, for name: String) {
        let imageUrl = URL(string: image)
        characterImageView.kf.setImage(with: imageUrl)
        characterNameLabel.text = name
    }
}
