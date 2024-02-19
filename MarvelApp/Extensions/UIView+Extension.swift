//
//  UIView+Extension.swift
//  WookieMovies
//
//  Created by Ahmed Mahrous on 12/07/2023.
//

import UIKit

extension UIView {
    
    //This for cell identifier to be safe from writing errors for identifier
    static var identifier: String {
        return String(describing: self)
    }
    
    //This is for the nib file
    static var nib: UINib {
        return UINib(nibName: "\(self)", bundle: nil)
    }
    
}
