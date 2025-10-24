//
//  PeripheralCellTableViewCell.swift
//  CoreBluetoothPOC
//
//  Created by Asif Habib on 11/08/23.
//

import UIKit

class PeripheralCell: UITableViewCell {

    @IBAction func buttonAction(_ sender: UIButton) {
        print("button CLicked")
    }
    @IBOutlet weak var button: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
