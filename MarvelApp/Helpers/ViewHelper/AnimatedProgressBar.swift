//
//  AnimatedProgressBar.swift
//  Marvel
//
//  Created by Ahmed Mahrous on 18/02/2024.
//

import UIKit

class AnimatedLinearProgressBar: UIView {
    
    //MARK: - Properties
    private let shapeLayer = CAShapeLayer()
    private var progress: CGFloat = 0
    
    
    //MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupProgressBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupProgressBar()
    }
    
    //MARK: - Support Functions
    private func setupProgressBar() {
        let lineWidth: CGFloat = 5
        let startPoint = CGPoint(x: 0, y: bounds.midY)
        let endPoint = CGPoint(x: bounds.width, y: bounds.midY)
        
        let path = UIBezierPath()
        path.move(to: endPoint)
        path.addLine(to: startPoint)
        
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = #colorLiteral(red: 0.1266870201, green: 0.7152357697, blue: 0.9988384843, alpha: 1)
        shapeLayer.strokeColor = #colorLiteral(red: 0.1266870201, green: 0.7152357697, blue: 0.9988384843, alpha: 1)
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineCap = .square
        shapeLayer.strokeEnd = 1
        
        layer.addSublayer(shapeLayer)
    }
    
    //MARK: - Services Functions
    
    func setProgress(_ progress: CGFloat, animated: Bool) {
        guard progress >= 0 && progress <= 1 else { return }
        
        if animated {
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = progress
            animation.toValue = self.progress
            animation.duration = 1.0
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
            shapeLayer.add(animation, forKey: "strokeEndAnimation")
        } else {
            shapeLayer.strokeEnd = progress
        }
        
        self.progress = progress
    }
}

