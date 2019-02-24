//
//  MedTableViewCell.swift
//  Medi Ready v2
//
//  Created by Kevin Terwelp on 2/19/19.
//  Copyright © 2019 Kevin Terwelp. All rights reserved.
//

import UIKit

class MedTableViewCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var row1Label: UILabel!
    @IBOutlet weak var row2Label: UILabel!
    @IBOutlet weak var row3Label: UILabel!
    @IBOutlet weak var row4Label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
