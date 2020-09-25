//
//  GotoRegisterSellerViewController.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 31/08/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit

class GotoRegisterSeller2ViewController: UIViewController {

    @IBOutlet weak var ButtonSeller: UIButton!
    @IBOutlet weak var BeforeLabel: UILabel!
    @IBOutlet weak var YouNeedLabel: UILabel!
    
    let sharedPref = UserDefaults.standard
    var lang: String = ""
    var userID: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ButtonSeller.layer.cornerRadius = 15
        
        lang = sharedPref.string(forKey: "LANG") ?? "0"
        if(lang == "ms"){
            changeLanguage(str: "ms")
            
        }else{
            changeLanguage(str: "en")
            
        }
    }
    
    func changeLanguage(str: String){
        ButtonSeller.setTitle("BECOME A SELLER TODAY!".localized(lang: str), for: .normal)
        BeforeLabel.text = "You need to register as KetekMall Seller".localized(lang: str)
        YouNeedLabel.text = "Before you can start selling your product, ".localized(lang: str)
    }

    
    
    @IBAction func GotoRegisterPage(_ sender: Any) {

        let RegisterSeller = self.storyboard!.instantiateViewController(identifier: "BeforeRegisterViewController") as! BeforeRegisterViewController
//        RegisterSeller.UserID = userID
        if let navigator = self.navigationController {
            navigator.pushViewController(RegisterSeller, animated: true)
        }
    }
}
