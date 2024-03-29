//
//  SplashViewController.swift
//  Marvel
//
//  Created by Ahmed Mahrous on 18/02/2024.
//

import UIKit

class SplashViewController: UIViewController {
    
    //MARK: - Outlet Connections
    @IBOutlet weak var logoImageView: UIImageView!
    

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUi()
    }
    
    //MARK: - Support Functions
    //This function responsible for everything related with UI
    private func updateUi() {
        setUpProgressBar()
        updateNavigationController()
    }
    
    ///This is a support function (support updateUi function) to set up navigation UI
    ///Note that: You can call this function only inside updateUi function otherwise your code will be a legacy code not a clean one
    private func updateNavigationController() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0 ) { [weak self] in
            let vc = HomeViewController()
            self?.navigationController?.setViewControllers([vc], animated: true)
        }
        
    }
    
    ///This is a support function (support updateUi function) to set up progress bar UI
    ///Note that: You can call this function only inside updateUi function otherwise your code will be a legacy code not a clean one
    private func setUpProgressBar() {
        let X = logoImageView.frame.minX + 25 //view.center.x - 60
        let Y = logoImageView.frame.maxY //view.center.y + 110

        let progressBar = AnimatedLinearProgressBar(frame: CGRect(x: X, y: Y, width:  150, height: 5))
        view.addSubview(progressBar)
        progressBar.setProgress(1, animated: true)
    }

}


