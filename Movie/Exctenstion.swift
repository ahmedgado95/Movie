//
//  Exctenstion.swift
//  Movie
//
//  Created by ahmed gado on 11/19/18.
//  Copyright © 2018 ahmed gado. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(title : String , message : String , okTitle: String = "OK", okHandler : ((UIAlertAction)->Void)? = nil) {
        let alert = UIAlertController(title: title, message: message
            , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: okTitle, style: .cancel, handler: okHandler))
        
        self.present(alert, animated: true, completion: nil)

    }
}

