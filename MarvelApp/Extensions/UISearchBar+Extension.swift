//
//  UISearchBar+Extension.swift
//  MarvelApp
//
//  Created by Ahmed Mahrous on 21/02/2024.
//

import UIKit

extension UISearchBar {
    var cancelButton: UIButton? {
        return self.value(forKey: "cancelButton") as? UIButton
    }
}
