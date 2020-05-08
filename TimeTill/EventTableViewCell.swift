//
//  EventTableViewCell.swift
//  TimeTill
//
//  Created by Kenneth Jones on 5/8/20.
//  Copyright © 2020 Kenneth Jones. All rights reserved.
//

import UIKit
import EventKit

class EventTableViewCell: UITableViewCell {
    
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var countdownLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
