//
//  HomeTableViewCell.swift
//  MarvelApp
//
//  Created by Ahmed Mahrous on 19/02/2024.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    //MARK: - Outlet Connections
    @IBOutlet weak var characterImageView: UIImageView!
    
    //MARK: - Properties
    var name: String = "Ahmed mahrous" {
        didSet {
            // Call parallelogramViewWithLabel each time name changes
            updateParallelogramView()
        }
    }
    
    private var parallelogramView: ParallelogramViewWithLabel?
    
    //MARK: - Life Cycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initial setup
        updateParallelogramView()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 0.2, right: 0))
    }

    //MARK: - Support Functions
    //This function responsible for setting data to UI
    func configure(with image: String, for name: String) {
        self.name = name
    }
    
    // Update parallelogramViewWithLabel with the latest name value
    private func updateParallelogramView() {
        // Remove existing parallelogramView if any
        parallelogramView?.removeFromSuperview()
        
        // Create and configure the ParallelogramViewWithLabel instance
        let newParallelogramView = ParallelogramViewWithLabel(withText: name)
        
        // Add the ParallelogramView to the contentView
        contentView.addSubview(newParallelogramView)
        
        // Set constraints to bottom-left the view
        newParallelogramView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newParallelogramView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30.0),
            newParallelogramView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20.0),
            newParallelogramView.widthAnchor.constraint(equalToConstant: contentView.frame.size.width * 0.5),
            newParallelogramView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // Store reference to the new parallelogramView
        parallelogramView = newParallelogramView
    }
}
