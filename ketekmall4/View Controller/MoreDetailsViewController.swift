//
//  MoreDetailsViewController.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 01/09/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit

class MoreDetailsViewController: UIViewController {

    var BRAND: String = ""
    var INNER: String = ""
    var STOCK: String = ""
    var DESC: String = ""
    var DIVISION: String = ""
    var DISTRICT: String = ""
    
    @IBOutlet weak var BrandMaterial: UILabel!
    @IBOutlet weak var InnerMaterial: UILabel!
    @IBOutlet weak var Stock: UILabel!
    @IBOutlet weak var ShipsFrom: UILabel!
    @IBOutlet weak var Description: UITextView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BrandMaterial.text! = BRAND
        InnerMaterial.text! = INNER
        Stock.text! = STOCK
        ShipsFrom.text! = DIVISION + "," + DISTRICT
        Description.text! = DESC
    }
}
