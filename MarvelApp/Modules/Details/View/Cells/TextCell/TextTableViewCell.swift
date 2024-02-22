//
//  TextTableViewCell.swift
//  MarvelApp
//
//  Created by Ahmed Mahrous on 22/02/2024.
//

import UIKit

class TextTableViewCell: UITableViewCell {
    
    //MARK: - Outlet Connections
    @IBOutlet weak var detailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    //MARK: - Support Functions
    //This function responsible for setting data to UI
    func configure(with info: String) {
        detailLabel.text = info
    }
}
