//
//  LinkTableViewCell.swift
//  MarvelApp
//
//  Created by Ahmed Mahrous on 22/02/2024.
//

import UIKit

class LinkTableViewCell: UITableViewCell {

    //MARK: - Outlet Connections
    @IBOutlet weak var linkLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - Support Functions
    //This function responsible for setting data to UI
    func configure(withTitle title: String) {
        linkLabel.text = title
    }
    
}
