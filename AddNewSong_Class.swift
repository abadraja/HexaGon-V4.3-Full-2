//
//  AddNewSong_Class.swift
//  HexaGon
//
//  Created by Alen Badrajan on 4/13/17.
//  Copyright © 2017 Alen Badrajan. All rights reserved.
//

import UIKit

var saveMuz: [[Int]] = []
var SaveVolum: [[Float]] = []
var saveName = [String]()
var edit_indice: Int = -1


class AddNewSong_Class: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var Clasa_main: MainMenuClass_ViewController?
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var Add_favorit: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.object(forKey: "saveMuz") != nil {
            saveMuz = UserDefaults.standard.array(forKey: "saveMuz") as! [[Int]]
            SaveVolum = UserDefaults.standard.array(forKey: "saveVolum") as! [[Float]]
            saveName = UserDefaults.standard.array(forKey: "saveName") as! [String]
        }
        self.navigationController?.isNavigationBarHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func Back_button(_ sender: UIBarButtonItem) {
        Clasa_main?.viewDidLoad()
        Clasa_main?.Activare_imagine()
        _ = navigationController?.popViewController(animated: true)
    }
    
  
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return (ListPlay.count)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AddNewSong_TableViewCell
    
        cell.icon_song.image = UIImage(named: (imagini[ListPlay[indexPath.row]]))
        cell.index = ListPlay[indexPath.row]
        cell.del_index = indexPath.row
        cell.Song_Class = self
        cell.slider.value = listVolum[indexPath.row]
        return (cell)
    }

    @IBAction func Button_delet(_ sender: UIBarButtonItem) {
        for i in 0...audioPL.count-1
        {
            audioPL[i].stop();
            audioPL[i].currentTime = 0
            audioPL[i].volume = 0.5
        }
        ListPlay.removeAll()
        listVolum.removeAll()
        table.reloadData()
        Clasa_main?.viewDidLoad()
        Clasa_main?.Activare_imagine()
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func Add_favorit(_ sender: UIButton) {
        if ListPlay.count > 0{
            salvare_denumire_song()
        }
    }
    
    func salvare_denumire_song(){
        let alert = UIAlertController(title: "Save Song", message: "Set the name of the song", preferredStyle: UIAlertControllerStyle.alert)

        let save = UIAlertAction(title: "Save", style: .default) { (UIAlertAction) in
            if (alert.textFields?[0].text?.isEmpty)!{
                self.createAlert(title: "Error", message: "Set the name of the song")
            }
            else{
                self.cauta_denumirea(textfield: (alert.textFields?[0].text)!)
            }
        }
        alert.addTextField { (textfield: UITextField) in
            textfield.placeholder = "Place song name"
        }
        
        alert.addAction(save)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion:  nil)
    }
    
    func cauta_denumirea(textfield:String){
        for compar in saveName{
            if compar == textfield{
                self.save_yes_no(cauta: textfield)
                break
            }
            if compar != textfield && compar == saveName[saveName.count-1]{
                saveName.append(textfield)
                saveMuz.append(ListPlay)
                SaveVolum.append(listVolum)
                UserDefaults.standard.set(saveMuz, forKey: "saveMuz")
                UserDefaults.standard.set(SaveVolum, forKey: "saveVolum")
                UserDefaults.standard.set(saveName, forKey: "saveName")
                self.createAlert(title: "GREAT!", message: "Composition have been added successfully to favorite list.")
            }
        }
        if saveName.count == 0{
            saveName.append(textfield)
            saveMuz.append(ListPlay)
            SaveVolum.append(listVolum)
            UserDefaults.standard.set(saveMuz, forKey: "saveMuz")
            UserDefaults.standard.set(SaveVolum, forKey: "saveVolum")
            UserDefaults.standard.set(saveName, forKey: "saveName")
            self.createAlert(title: "GREAT!", message: "Composition have been added successfully to favorite list.")
        }
    }
    
    
    
    func save_yes_no(cauta: String){
        let alert3 = UIAlertController(title: "Attention", message: "This song name already exists in your Favorites!", preferredStyle: UIAlertControllerStyle.alert)
        let save = UIAlertAction(title: "Replace", style: .default) { (UIAlertAction) in
            for i in 0...saveName.count-1{
                if cauta == saveName[i]{
                    saveName[i] = cauta
                    saveMuz[i] = ListPlay
                    SaveVolum[i] = listVolum
                    UserDefaults.standard.set(saveMuz, forKey: "saveMuz")
                    UserDefaults.standard.set(SaveVolum, forKey: "saveVolum")
                    UserDefaults.standard.set(saveName, forKey: "saveName")
                    self.createAlert(title: "GREAT!", message: "Composition have been added successfully to favorite list.")
                }
            }
        }
        alert3.addAction(save)
        alert3.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert3, animated: true, completion:  nil);
    }

    
    func createAlert(title:String, message:String){
        let alert2 = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert2.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert2, animated: true, completion:  nil);
    }
}
