//
//  CellViewCell.swift
//  firstApp
//
//  Created by Aditya Tandon on 2019-07-20.
//  Copyright © 2019 Aditya Tandon. All rights reserved.
//

import UIKit

class CellViewCell: UITableViewCell {

    @IBOutlet weak var wondersLabelView: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
