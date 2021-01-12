//
//  GotoRegisterSellerViewController.swift
//  ketekmall4
//
//  Created by HMN Nadhir on 31/08/2020.
//  Copyright © 2020 HMN Nadhir. All rights reserved.
//

import UIKit

class GotoRegisterSeller2ViewController: UIViewController {

    @IBOutlet weak var ButtonSeller: UIButton!
    @IBOutlet weak var BeforeLabel: UILabel!
    @IBOutlet weak var YouNeedLabel: UILabel!
    
    let sharedPref = UserDefaults.standard
    var lang: String = ""
    var userID: String = ""
    
    override func viewDidAppear(_ animated: Bool) {
        ColorFunc()
    }
    
    
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
    
    func ColorFunc(){
        //Button Accept
                
        let colorImageOne1 = UIColor(hexString: "#FC4A1A").cgColor
        let colorImageOne2 = UIColor(hexString: "#F7B733").cgColor
        
        let ImageOneGradient = CAGradientLayer()
        ImageOneGradient.frame = ButtonSeller.bounds
        ImageOneGradient.colors = [colorImageOne1, colorImageOne2]
        ImageOneGradient.startPoint = CGPoint(x: 0, y: 0.5)
        ImageOneGradient.endPoint = CGPoint(x: 1, y: 0.5)
        ImageOneGradient.cornerRadius = 5
            ButtonSeller.layer.insertSublayer(ImageOneGradient, at: 0)
    }
    
    func changeLanguage(str: String){
        ButtonSeller.setTitle("BECOME A SELLER TODAY!".localized(lang: str), for: .normal)
        BeforeLabel.text = "You need to register as KetekMall Seller".localized(lang: str)
        YouNeedLabel.text = "Before you can start selling your product, ".localized(lang: str)
    }

    
    
    @IBAction func GotoRegisterPage(_ sender: Any) {

        let RegisterSeller = self.storyboard!.instantiateViewController(withIdentifier: "BeforeRegisterViewController") as! BeforeRegisterViewController
//        RegisterSeller.UserID = userID
        if let navigator = self.navigationController {
            navigator.pushViewController(RegisterSeller, animated: true)
        }
    }
}
