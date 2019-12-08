//
//  staffCell.swift
//  FastQ
//
//  Created by Mobark on 08/12/2019.
//  Copyright © 2019 emobark. All rights reserved.
//

import UIKit

class staffCell: UITableViewCell {
    @IBOutlet weak var numbers: UILabel!
    @IBOutlet weak var slide: UISlider!
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
