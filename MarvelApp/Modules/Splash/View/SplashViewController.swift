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
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Support Functions
    //This function responsible for everything related with UI
    private func updateUi() {
        setUpProgressBar()
        updateNavigationController()
    }
    
    ///This is a support function (support updateUi function) to set up navigation bar UI
    ///Note that: You can call this function only inside updateUi function otherwise your code will be a legacy code not a clean one
    private func updateNavigationController() {
        #warning("change the rootViewController for Navigation Controller it must be the Home screen")
        
    }
    
    ///This is a support function (support updateUi function) to set up progress bar UI
    ///Note that: You can call this function only inside updateUi function otherwise your code will be a legacy code not a clean one
    private func setUpProgressBar() {
        let centerX = view.center.x - 60
        let centerY = view.center.y + 110

        let progressBar = AnimatedLinearProgressBar(frame: CGRect(x: centerX, y: centerY, width:  150, height: 5))
        view.addSubview(progressBar)
        progressBar.setProgress(1, animated: true)
    }

}


