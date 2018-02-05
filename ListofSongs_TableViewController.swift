//
//  ListofSongs_TableViewController.swift
//  HexaGon
//
//  Created by Alen Badrajan on 4/14/17.
//  Copyright © 2017 Alen Badrajan. All rights reserved.
//

import UIKit

class ListofSongs_TableViewController: UITableViewController,UITableViewDelegate,UITableViewDataSource {

    let SongsList = ["CoolSong1","CoolSong2","CoolSong3"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return (SongsList.count)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let song_casete = tableView.dequeueReusableCell(withIdentifier: "song_caset", for: IndexPath) as! ViewControllerTableViewCell
    
        song_casete.Icon_ListofSongs.image = UIImage
    }
    
    func t


}
