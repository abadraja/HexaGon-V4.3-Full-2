//
//  Favorit_ViewController.swift
//  HexaGon
//
//  Created by Bondarenco Mihai on 5/29/17.
//  Copyright © 2017 Alen Badrajan. All rights reserved.
//

import UIKit

class Favorit_ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var Clasa_main: MainMenuClass_ViewController?
    
    @IBOutlet weak var tableview_clasfavorit: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        if UserDefaults.standard.object(forKey: "saveMuz") != nil {
            saveMuz = UserDefaults.standard.array(forKey: "saveMuz") as! [[Int]]
            SaveVolum = UserDefaults.standard.array(forKey: "saveVolum") as! [[Float]]
            saveName = UserDefaults.standard.array(forKey: "saveName") as! [String]
            
        }
        NotificationCenter.default.addObserver(self, selector: #selector(Favorit_ViewController.reloadTable), name: NSNotification.Name(rawValue: "reloadFuckingTable"), object: nil)
    }
    func reloadTable()
    {
        tableview_clasfavorit.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Back_button_favorit(_ sender: UIBarButtonItem) {
        Clasa_main?.viewDidLoad()
        Clasa_main?.Activare_imagine()
        _ = navigationController?.popViewController(animated: true)
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return (saveMuz.count)
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Favorir_TableViewCell
        cell.tabfoto = saveMuz[indexPath.row]
         cell.indicele_TAB = indexPath.row
        cell.play_button_favorit.setImage(#imageLiteral(resourceName: "4_play_button.png"), for: .normal)
        cell.play_button_favorit.tag = 0
        if ListPlay.count == cell.tabfoto.count{
            for i in 0...ListPlay.count-1{
                if ListPlay[i] == cell.tabfoto[i] && ListPlay.count-1 == i{
                    cell.play_button_favorit.setImage(#imageLiteral(resourceName: "4_pause_button.png"), for: .normal)
                    cell.play_button_favorit.tag = 1
                }
            }
        }
        cell.label_cell_favorit.text = saveName[indexPath.row]
    
        
        cell.isUserInteractionEnabled = true
        cell.Clasa_favorit = self
        cell.Colection_vi.reloadData()
        return (cell)
    }
}
