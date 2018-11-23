//
//  ViewController2.swift
//  Movie
//
//  Created by ahmed gado on 11/13/18.
//  Copyright © 2018 ahmed gado. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {

    var singleItem :FilmeItem?
    
    @IBOutlet weak var desTextView: UITextView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = singleItem?.name
        imageImage.image = UIImage(named: (singleItem?.image!)!)
        desTextView.text = singleItem?.detail
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
