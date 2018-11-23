//
//  TableCell.swift
//  Movie
//
//  Created by ahmed gado on 11/12/18.
//  Copyright © 2018 ahmed gado. All rights reserved.
//

import UIKit

class TableCell: UITableViewCell {

    
    @IBOutlet weak var nameCell: UILabel!
    @IBOutlet weak var imageCell: UIImageView!
    func SetImage(url:String) {
        
        do{
            let AppUrl = URL(string: url)!
            let data = try Data(contentsOf: AppUrl)
            imageCell.image = UIImage(data: data)
            
        }catch{
             print("Cant load image from server")
        }
        
        
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
