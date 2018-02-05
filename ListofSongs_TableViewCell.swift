//
//  ListofSongs_TableViewCell.swift
//  HexaGon
//
//  Created by Alen Badrajan on 4/14/17.
//  Copyright © 2017 Alen Badrajan. All rights reserved.
//

import UIKit

class ListofSongs_TableViewCell: UITableViewCell {


    @IBOutlet weak var Song_icon_List: UIImageView!
    @IBOutlet weak var Song_name_List: UILabel!
    
    @IBOutlet weak var addButton: UIButton!

    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    public func onClick() -> String
    {
        return(Song_name_List.text!)
    }
}
