//
//  Colection_Class.swift
//  HexaGon
//
//  Created by Bondarenco Mihai on 5/31/17.
//  Copyright © 2017 Alen Badrajan. All rights reserved.
//

import UIKit

class Colection_Class: UICollectionView {

    var tabelul_clasei = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func printeaza() {
        print(" tabelul celulei -----------\(tabelul_clasei)=============")
    }
}
