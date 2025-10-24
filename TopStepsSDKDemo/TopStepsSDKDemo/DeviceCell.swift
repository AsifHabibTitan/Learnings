//
//  DeviceCell.swift
//  TopStepsSDKDemo
//
//  Created by Asif Habib on 07/10/23.
//

import UIKit

class DeviceCell: UITableViewCell {

    
    @IBOutlet weak var deviceName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setLabel(label: String) {
        self.textLabel?.text = label
    }
    
}
