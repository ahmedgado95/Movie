    //
//  LoginVC.swift
//  Movie
//
//  Created by ahmed gado on 11/18/18.
//  Copyright © 2018 ahmed gado. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginVC: UIViewController {

    @IBOutlet weak var passwordTextFeild: UITextField!
    @IBOutlet weak var emailTextFeild: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func login(_ sender: Any) {
        guard let email = emailTextFeild.text,  !email.isEmpty else{print("email not found");return}
        guard let password = passwordTextFeild.text,  !password.isEmpty else{print("password not found");return}
        self .view.endEditing(true)
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                print(error)
                if error._code == 17011 {
                    // user not found
                    let alert = UIAlertController(title: "NOT FOUND", message: "User Not Found", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                        switch action.style{
                        case .default:
                            print("default")
                            
                        case .cancel:
                            print("cancel")
                            
                        case .destructive:
                            print("destructive")
                            
                            
                        }}))
                    self.present(alert, animated: true, completion: nil)

                }
            }else{
                if let user = user{
                    print(user )
                    let sb = UIStoryboard(name: "Main", bundle: nil)
                    let vc = sb.instantiateViewController(withIdentifier: "MainVC")
                    self.present(vc, animated: true, completion: nil)
                    
                }
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
