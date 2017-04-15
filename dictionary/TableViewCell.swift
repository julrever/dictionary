//
//  TableViewCell.swift
//  dictionary
//
//  Created by Юля on 12.04.17.
//  Copyright © 2017 jul. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var translateLabel: UILabel!
    @IBOutlet weak var notesImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    

}
