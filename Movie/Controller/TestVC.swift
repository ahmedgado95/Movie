//
//  TestVC.swift
//  Movie
//
//  Created by ahmed gado on 11/19/18.
//  Copyright © 2018 ahmed gado. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class TestVC: UIViewController {

    @IBOutlet weak var photoURLTextFiled: UITextField!
    @IBOutlet weak var nameTextFiled: UITextField!
    @IBOutlet weak var imagePhotoURL: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        LoadUserData()
    }
   
    
    func LoadUserData(){
        if let user = Auth.auth().currentUser{
            if let name = user.displayName{
                nameTextFiled.text = name
            }
            if let photoURL = user.photoURL{
                photoURLTextFiled.text = photoURL.absoluteString
                //Download Photo
                URLSession.shared.dataTask(with: photoURL , completionHandler:{(data , response , error) in
                    if let error = error{
                        DispatchQueue.global().async {
                            self.showAlert(title: "Error", message: error.localizedDescription)
                        }
                    }else{
                        if let data = data ,  let image = UIImage(data: data){
                            DispatchQueue.global().async {
                                self.imagePhotoURL.image = image
                                
                            }
                        }
                    }
                }).resume()
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    @IBAction func updatePressed(_ sender: Any) {
        guard let user = Auth.auth().currentUser else {return}
        let name = nameTextFiled.text!
        let photoURL = photoURLTextFiled.text!
        let changeRequest = user.createProfileChangeRequest()
        changeRequest.displayName = name
        changeRequest.photoURL = NSURL(string: photoURL)! as URL
        changeRequest.commitChanges { (error) in
            if let error = error {
                self.showAlert(title: "Error", message: error.localizedDescription)
            }else{
                
                self.showAlert(title: "Succeed", message: "Profile Updated !")
                self.LoadUserData()
            }
        }
        
    }

    // updat email
//    @IBAction func updateEmail(sender: UIButton){
//        guard let user = Auth.auth().currentUser else {
//            return
//        }
//        let alert = UIAlertController(title: "Enter", message: "New Email", preferredStyle: .alert)
//        alert.addTextField(configurationHandler: {( tf:UITextField) in
//            tf.placeholder = "New Email"
//        }
//
//    }
    
    @IBAction func changePreesed(_ sender: Any) {
        guard let user = Auth.auth().currentUser else{return}
        let alertController = UIAlertController(title: "Enter", message: "New Email", preferredStyle: .alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter New Email"
        }
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Current Email"
        }
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Current Password"
        }
        alertController.addAction(UIAlertAction(title: "Cancle", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "UPdate", style: .default, handler: { (action :UIAlertAction) in
            if let textFields = alertController.textFields{
                let newEmail = textFields.first!.text!
                let currentEmail = textFields[1].text!
                let currentPassword = textFields[2].text!
                user.updateEmail(to: newEmail, completion: { (error) in
                    if let error = error {
                        self.showAlert(title: "Error", message: error.localizedDescription)
                        print(error)
                        
                    }else{
                        self.showAlert(title: "Succeed", message: "Email Updated !")
                    }
                })
            }
        }))
        self.present(alertController, animated: true, completion: nil)
        
//        @IBAction func addButtonClicked(sender : AnyObject){
//            let alertController = UIAlertController(title: "Add New Name", message: "", preferredStyle: UIAlertControllerStyle.Alert)
//            alertController.addTextFieldWithConfigurationHandler { (textField : UITextField!) -> Void in
//                textField.placeholder = "Enter Second Name"
//            }
//            let saveAction = UIAlertAction(title: "Save", style: UIAlertActionStyle.Default, handler: { alert -> Void in
//                let firstTextField = alertController.textFields![0] as UITextField
//                let secondTextField = alertController.textFields![1] as UITextField
//            })
//            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: {
//                (action : UIAlertAction!) -> Void in })
//            alertController.addTextFieldWithConfigurationHandler { (textField : UITextField!) -> Void in
//                textField.placeholder = "Enter First Name"
//            }
//
//            alertController.addAction(saveAction)
//            alertController.addAction(cancelAction)
//
//            self.presentViewController(alertController, animated: true, completion: nil)
//        }
        }
    
    }

    

