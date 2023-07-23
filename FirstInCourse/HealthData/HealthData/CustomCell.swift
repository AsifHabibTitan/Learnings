//
//  CustomCell.swift
//  HealthData
//
//  Created by Asif Habib on 30/06/23.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var heartRate: UILabel!
    @IBOutlet weak var spo2: UILabel!
    @IBOutlet weak var stress: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
