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
    var timer: Timer?
    
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
        var continousProgress = progress
        guard progress >= 0 && progress <= 1 else { return }
        
        // Invalidate the existing timer if it exists
        timer?.invalidate()
        
        // Create a new timer
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            // Code block to be executed continuously
            if animated {
                let animation = CABasicAnimation(keyPath: "strokeEnd")
                animation.fromValue = continousProgress
                animation.toValue = self.progress
                animation.duration = 0.5
                animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
                self.shapeLayer.add(animation, forKey: "strokeEndAnimation")
                self.progress += continousProgress
                continousProgress = self.progress - continousProgress
                self.progress -= continousProgress
            } else {
                // Stop the timer if the condition is no longer true
                timer.invalidate()
            }
        }
    }
    
}
