//
//  WatchViewCell.swift
//  ayannacolden-pset3
//
//  Created by Ayanna Colden on 18/11/2016.
//  Copyright © 2016 Ayanna Colden. All rights reserved.
//

import UIKit

class WatchViewCell: UITableViewCell {
   
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    @IBOutlet weak var moviePoster: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
