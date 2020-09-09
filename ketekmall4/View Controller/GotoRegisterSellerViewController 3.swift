//
//  GotoRegisterSellerViewController.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 31/08/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit

class GotoRegisterSellerViewController: UIViewController {

    @IBOutlet weak var ButtonSeller: UIButton!
    var userID: String = ""
    @IBAction func GotoRegisterPage(_ sender: Any) {

        let RegisterSeller = self.storyboard!.instantiateViewController(identifier: "RegisterSellerViewController") as! RegisterSellerViewController
        RegisterSeller.UserID = userID
        if let navigator = self.navigationController {
            navigator.pushViewController(RegisterSeller, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ButtonSeller.layer.cornerRadius = 15
    }
}
