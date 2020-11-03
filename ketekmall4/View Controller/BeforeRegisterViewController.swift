//
//  BeforeRegisterViewController.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 18/09/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit
import SimpleCheckbox

class BeforeRegisterViewController: UIViewController, UITabBarDelegate  {
    
    @IBOutlet weak var Tabbar: UITabBar!
    @IBOutlet weak var CheckTerms: Checkbox!
    @IBOutlet weak var ButtonAgree: UIButton!
    @IBOutlet weak var ButtonAgreeHeight: NSLayoutConstraint!
    var viewController1: UIViewController?
    
    let sharedPref = UserDefaults.standard
    var lang: String = ""
    var user: String = ""
    
    override func viewDidAppear(_ animated: Bool) {
//        ColorFunc()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Tabbar.delegate = self
        user = sharedPref.string(forKey: "USERID") ?? "0"
        lang = sharedPref.string(forKey: "LANG") ?? "0"
        if(lang == "ms"){
            changeLanguage(str: "ms")
        }else{
            changeLanguage(str: "en")
        }
        CheckTerms.valueChanged = {(isChecked) in
            if (isChecked == false){
                self.ButtonAgree.isHidden = true
                self.ButtonAgreeHeight.constant = 0
            }else{
                self.ButtonAgree.isHidden = false
            }
        }
    }
    
    func ColorFunc(){
        let colorViewOne = UIColor(hexString: "#FC4A1A").cgColor
        let colorViewTwo = UIColor(hexString: "#F7B733").cgColor
        
        let ViewGradient = CAGradientLayer()
        ViewGradient.frame = ButtonAgree.bounds
        ViewGradient.colors = [colorViewOne, colorViewTwo]
        ViewGradient.startPoint = CGPoint(x: 0, y: 0.5)
        ViewGradient.endPoint = CGPoint(x: 1, y: 0.5)
        ViewGradient.cornerRadius = 5
        ButtonAgree.layer.insertSublayer(ViewGradient, at: 0)
    }
    
    func changeLanguage(str: String){
        
        Tabbar.items?[0].title = "Home".localized(lang: str)
        Tabbar.items?[1].title = "Notification".localized(lang: str)
        Tabbar.items?[2].title = "Me".localized(lang: str)
    }

    @IBAction func GotoRegister(_ sender: Any) {
        let RegisterSeller = self.storyboard!.instantiateViewController(withIdentifier: "RegisterSellerViewController") as! RegisterSellerViewController
        RegisterSeller.UserID = user
        if let navigator = self.navigationController {
            navigator.pushViewController(RegisterSeller, animated: true)
        }
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem){
        switch item.tag {
        case 1:
            navigationController?.setNavigationBarHidden(true, animated: false)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            viewController1 = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            if let navigator = self.navigationController {
                navigator.pushViewController(viewController1!, animated: true)
            }
            break
            
        case 2:
            navigationController?.setNavigationBarHidden(true, animated: false)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            viewController1 = storyboard.instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
            if let navigator = self.navigationController {
                navigator.pushViewController(viewController1!, animated: true)
            }
            break
            
        case 3:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            viewController1 = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            if let navigator = self.navigationController {
                navigator.pushViewController(viewController1!, animated: true)
            }
            break
            
        default:
            break
        }
    }
}
