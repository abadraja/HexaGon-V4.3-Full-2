//
//  ListofSongs_ViewController.swift
//  HexaGon
//
//  Created by Alen Badrajan on 4/14/17.
//  Copyright © 2017 Alen Badrajan. All rights reserved.
//

import UIKit

class ListofSongs_ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var ListofSongs = ["CoolSong1","CoolSong2","CoolSong3"]
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return (ListofSongs.count)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let song_casete = tableView.dequeueReusableCell(withIdentifier: "song_container", for: indexPath) as! ListofSongs_TableViewCell
        
        song_casete.Song_icon_List.image = UIImage(named: (ListofSongs[indexPath.row] + ".png"))
        song_casete.Song_name_List.text = ListofSongs[indexPath.row]
        song_casete.addButton.addTarget(song_casete, action: #selector(song_casete.onClick), for: .touchUpInside)
        
        return (song_casete)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
