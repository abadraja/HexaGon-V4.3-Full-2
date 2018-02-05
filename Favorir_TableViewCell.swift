//
//  Favorir_TableViewCell.swift
//  HexaGon
//
//  Created by Bondarenco Mihai on 5/18/17.
//  Copyright © 2017 Alen Badrajan. All rights reserved.
//

import UIKit

class Favorir_TableViewCell: UITableViewCell, UICollectionViewDataSource{
    
    var Clasa_favorit: Favorit_ViewController?
    
    @IBOutlet weak var Colection_vi: UICollectionView!
    var indicele_TAB = -1
    
    @IBOutlet weak var label_cell_favorit: UILabel!
    @IBOutlet weak var play_button_favorit: UIButton!
    @IBOutlet weak var edit_button_favorit: UIButton!
    @IBOutlet weak var delete_button_favorit: UIButton!
    
    var favorit_Volume = [Float]()
    var tabfoto = [Int]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if play_button_favorit.tag == 0{
            play_button_favorit.setImage(#imageLiteral(resourceName: "4_play_button.png"), for: .normal)
        }
        else{
            play_button_favorit.setImage(#imageLiteral(resourceName: "4_pause_button.png"), for: .normal)
        }
    }
    
    @IBAction func Play_favorit(_ sender: UIButton) {
        if sender.tag == 0{
            sender.tag = 1
            play_button_favorit.setImage(#imageLiteral(resourceName: "4_pause_button.png"), for: .normal)
            for play in ListPlay{
                audioPL[play].stop()
                audioPL[play].currentTime = 0
            }
            ListPlay.removeAll()
            listVolum.removeAll()
            ListPlay = saveMuz[indicele_TAB]
            listVolum = SaveVolum[indicele_TAB]
            favorit_Volume = SaveVolum[indicele_TAB]
            for initiere in 0...ListPlay.count - 1{
                let fff = ListPlay[initiere]
                audioPL[fff].volume = favorit_Volume[initiere]
            }
            for play in ListPlay{
                audioPL[play].play()
            }
        }
        else{
            sender.tag = 0
            play_button_favorit.setImage(#imageLiteral(resourceName: "4_play_button.png"), for: .normal)
            for play in ListPlay{
                audioPL[play].pause()
                audioPL[play].currentTime = 0
            }
            ListPlay.removeAll()
            listVolum.removeAll()
        }
        Clasa_favorit?.viewDidLoad()
        Clasa_favorit?.tableview_clasfavorit.reloadData()
        
    }
    @IBAction func Edit_favorit(_ sender: UIButton) {
        edit_indice = indicele_TAB
        for play in ListPlay{
            audioPL[play].stop()
            audioPL[play].currentTime = 0
        }
        ListPlay.removeAll()
        ListPlay = saveMuz[indicele_TAB]
        favorit_Volume = SaveVolum[indicele_TAB]
        listVolum.removeAll()
        listVolum = SaveVolum[indicele_TAB]
        for initiere in 0...ListPlay.count - 1{
            let fff = ListPlay[initiere]
            audioPL[fff].volume = favorit_Volume[initiere]
        }
        for play in ListPlay{
            audioPL[play].play()
        }
        Clasa_favorit?.viewDidLoad()
        Clasa_favorit?.tableview_clasfavorit.reloadData()
    }
    @IBAction func Delet_favorit(_ sender: UIButton) {
        if ListPlay.count == tabfoto.count{
            for i in 0...ListPlay.count-1{
                if ListPlay[i] == tabfoto[i] && ListPlay.count-1 == i{
                    for play in ListPlay{
                        audioPL[play].pause()
                        audioPL[play].currentTime = 0
                    }
                    ListPlay.removeAll()
                }
            }
        }
        saveMuz.remove(at: self.indicele_TAB)
        SaveVolum.remove(at: self.indicele_TAB)
        saveName.remove(at: self.indicele_TAB)
        UserDefaults.standard.set(saveMuz, forKey: "saveMuz")
        UserDefaults.standard.set(SaveVolum, forKey: "saveVolum")
        UserDefaults.standard.set(saveName, forKey: "saveName")
        self.Clasa_favorit?.viewDidLoad()
        self.Clasa_favorit?.tableview_clasfavorit.reloadData()
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return saveMuz[indicele_TAB].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:Collection_ViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "colect_cell", for: indexPath) as! Collection_ViewCell
        cell.colection_cel_imagine.image = UIImage(named: (imagini[tabfoto[indexPath.row]]))
        return cell
    }

}

