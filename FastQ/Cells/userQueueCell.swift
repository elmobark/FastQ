//
//  userQueueCell.swift
//  FastQ
//
//  Created by Mobark on 08/12/2019.
//  Copyright © 2019 emobark. All rights reserved.
//

import UIKit

class userQueueCell: UITableViewCell {

    @IBOutlet weak var ticket: UILabel!
    @IBOutlet weak var username: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
