//
//  MyProductsViewController.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 27/08/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit

class MyProductsViewController: UIViewController {
    
    @IBOutlet weak var Value: UILabel!
    var userID: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        Value.text = userID
        // Do any additional setup after loading the view.
    }

}
