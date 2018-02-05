//
//  AddNewSong_TableViewCell.swift
//  HexaGon
//
//  Created by Alen Badrajan on 4/13/17.
//  Copyright © 2017 Alen Badrajan. All rights reserved.
//

import UIKit

class AddNewSong_TableViewCell: UITableViewCell {

    var Song_Class: AddNewSong_Class?
    
    @IBOutlet weak var icon_song: UIImageView!
    @IBOutlet weak var slider: UISlider!
    
    var index = Int()
    var del_index = Int()
    
    
    @IBAction func slider_volum(_ sender: UISlider) {
        audioPL[index].volume = sender.value
        listVolum[del_index] = sender.value
    }
    
    @IBAction func dell_but(_ sender: UIButton) {
        audioPL[index].pause()
        audioPL[index].currentTime = 0
        audioPL[index].volume = 0.5
        ListPlay.remove(at: del_index)
        listVolum.remove(at: del_index)
        Song_Class?.viewDidLoad()
        Song_Class?.table.reloadData()
        
    }
    override func awakeFromNib(){
        super.awakeFromNib()
        slider.minimumTrackTintColor = #colorLiteral(red: 0.7991214991, green: 0.2726472318, blue: 0.08792787045, alpha: 1)
        slider.maximumTrackTintColor = #colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 1)
        slider.setThumbImage(#imageLiteral(resourceName: "2_volume_dot"), for: UIControlState.normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
