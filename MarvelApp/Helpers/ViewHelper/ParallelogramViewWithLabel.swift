//
//  ParallelogramLabel.swift
//  MarvelApp
//
//  Created by Ahmed Mahrous on 19/02/2024.
//

import UIKit

class ParallelogramViewWithLabel: UIView {
    
    //MARK: - Properties
    var name: String = ""
    
    
    init(withText name: String) {
        self.name = name
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override class var layerClass: AnyClass {
        return CAShapeLayer.self
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        setupViews()
    }
    
    private func setupViews() {
        // Create a path for the parallelogram shape
        let path = UIBezierPath()
        path.move(to: CGPoint(x: bounds.minX + 20, y: bounds.minY))
        path.addLine(to: CGPoint(x: bounds.maxX, y: bounds.minY))
        path.addLine(to: CGPoint(x: bounds.maxX - 20, y: bounds.maxY))
        path.addLine(to: CGPoint(x: bounds.minX, y: bounds.maxY))
        path.close()
        
        // Set the path to the layer's mask
        let shapeLayer = layer as! CAShapeLayer
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.white.cgColor
        
        // Add a UILabel as a subview
        let label = UILabel()
        label.textAlignment = .center
        label.text = name
        label.textColor = .black
        label.numberOfLines = 1
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        
        // Set constraints for the label
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.widthAnchor.constraint(equalTo: widthAnchor, constant: 5),
            label.heightAnchor.constraint(equalTo: heightAnchor, constant: 5)
        ])
    }
}
