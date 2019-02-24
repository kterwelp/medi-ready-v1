//
//  MedicineTableViewCell.swift
//  Medi Ready
//
//  Created by Kevin Terwelp on 2/18/19.
//  Copyright © 2019 Kevin Terwelp. All rights reserved.
//

import UIKit

class MedicineTableViewCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var medLabel: UILabel!
    @IBOutlet weak var tabDosageLabel: UILabel!
    @IBOutlet weak var doseLabel: UILabel!
    @IBOutlet weak var tabsLabel: UILabel!
    @IBOutlet weak var routeLabel: UILabel!
    @IBOutlet weak var frequencyLabel: UILabel!
    @IBOutlet weak var numOfDaysLabel: UILabel!
    @IBOutlet weak var dxLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
