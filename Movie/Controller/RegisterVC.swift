//
//  RegisterVC.swift
//  Movie
//
//  Created by ahmed gado on 11/18/18.
//  Copyright © 2018 ahmed gado. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth


class RegisterVC: UIViewController {

    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var rpeatePasswordTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func registerPreesed(_ sender: Any) {
        guard let email = emailTextField.text,  !email.isEmpty else{print("email not found");return}
        guard let password = passwordTextField.text,  !password.isEmpty else{print("password not found");return}
        guard let repeatepassword = rpeatePasswordTextField.text,  !repeatepassword.isEmpty else{print("Repeat password not found");return}
        guard password == repeatepassword else{
            print("Password Dont Match")
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                print(error)
            }else {
                if let user = user {
                    print(user)
                    let sb = UIStoryboard(name: "Main", bundle: nil)
                    let vc = sb.instantiateViewController(withIdentifier: "MainVC")
                    self.present(vc, animated: true, completion: nil)
                }
            }
        }
    }
    
    

}
