//
//  jCell.swift
//  CoreDataDemo
//
//  Created by Ratnakala53 on 1/13/16.
//  Copyright © 2016 ratnakala. All rights reserved.
//

import UIKit

class jCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet var lbl_name:UILabel!
    @IBOutlet var lbl_city:UILabel!
    @IBOutlet var lbl_contact:UILabel!

}
