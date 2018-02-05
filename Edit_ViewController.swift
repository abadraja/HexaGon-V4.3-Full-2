//
//  Edit_ViewController.swift
//  HexaGon
//
//  Created by Bondarenco Mihai on 6/12/17.
//  Copyright © 2017 Alen Badrajan. All rights reserved.
//

import UIKit



class Edit_ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var name_edit: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name_edit.delegate = self
       name_edit.text = saveName[edit_indice]
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        name_edit.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    @IBOutlet weak var Save_Button: UIBarButtonItem!
    @IBOutlet weak var Back_Button: UIBarButtonItem!
    
    @IBOutlet weak var table: UITableView!
    
    @IBAction func edit_back(_ sender: UIBarButtonItem) {
        saveMuz = UserDefaults.standard.array(forKey: "saveMuz") as! [[Int]]
        SaveVolum = UserDefaults.standard.array(forKey: "saveVolum") as! [[Float]]
        saveName = UserDefaults.standard.array(forKey: "saveName") as! [String]
        _ = navigationController?.popViewController(animated: true)
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return (ListPlay.count)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_edit", for: indexPath) as! Edit_TableViewCell
        cell.edit_image.image = UIImage(named: (imagini[ListPlay[indexPath.row]]))
        cell.index = ListPlay[indexPath.row]
        cell.save_index = indexPath.row
        let ind = ListPlay[indexPath.row]
        cell.edit_slider.value = audioPL[ind].volume
        cell.edit_class = self
        return (cell)
    }
    
    @IBAction func Save_edit(_ sender: UIBarButtonItem) {
        if ListPlay.count > 0 && name_edit.text != ""{
            saveName[edit_indice] = name_edit.text!
            saveMuz[edit_indice] = ListPlay
            SaveVolum[edit_indice] = listVolum
            UserDefaults.standard.set(saveMuz, forKey: "saveMuz")
            UserDefaults.standard.set(SaveVolum, forKey: "saveVolum")
            UserDefaults.standard.set(saveName, forKey: "saveName")
            createAlert(title: "GREAT!", message: "Composition have been added successfully to favorite list.")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadFuckingTable"), object: nil)
        }
        else{
            createAlert(title: "Warning", message: "You don't have songs in this composition.")
        }

    }
    
    func createAlert(title:String, message:String){
        let alert2 = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let ok = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
            _ = self.navigationController?.popViewController(animated: true)
        }
        alert2.addAction(ok)
        self.present(alert2, animated: true, completion:  nil);
    }

}
