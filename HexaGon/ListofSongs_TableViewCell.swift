//
//  ListofSongs_TableViewCell.swift
//  HexaGon
//
//  Created by Alen Badrajan on 4/14/17.
//  Copyright © 2017 Alen Badrajan. All rights reserved.
//

import UIKit

class ListofSongs_TableViewCell: UITableViewCell {
    @IBOutlet weak var Icon_ListofSongs: UIImageView!
    @IBOutlet weak var NameofSong_ListofSongs: UILabel!
    
    
    @IBAction func AddNewSongSpecial_Button(_ sender: UIButton) {
        print("song added")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
