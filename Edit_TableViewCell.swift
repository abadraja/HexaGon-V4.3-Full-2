//
//  Edit_TableViewCell.swift
//  HexaGon
//
//  Created by Bondarenco Mihai on 6/12/17.
//  Copyright © 2017 Alen Badrajan. All rights reserved.
//

import UIKit

class Edit_TableViewCell: UITableViewCell {

    var edit_class: Edit_ViewController?
    
    @IBOutlet weak var edit_image: UIImageView!
    @IBOutlet weak var edit_slider: UISlider!
    var index = Int()
    var save_index = Int()
    
    @IBAction func slider_bar(_ sender: UISlider) {
        audioPL[index].volume = sender.value
        listVolum[save_index] = sender.value
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        edit_slider.minimumTrackTintColor = #colorLiteral(red: 0.7991214991, green: 0.2726472318, blue: 0.08792787045, alpha: 1)
        edit_slider.maximumTrackTintColor = #colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 1)
        edit_slider.setThumbImage(#imageLiteral(resourceName: "2_volume_dot"), for: UIControlState.normal)
    }

    @IBAction func edit_delete(_ sender: UIButton) {
        audioPL[index].pause()
        audioPL[index].currentTime = 0
        audioPL[index].volume = 0.5
        ListPlay.remove(at: save_index)
        listVolum.remove(at: save_index)
        edit_class?.viewDidLoad()
        edit_class?.table.reloadData()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
