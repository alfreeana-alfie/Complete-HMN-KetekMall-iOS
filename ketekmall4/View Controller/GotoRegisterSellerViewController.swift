//
//  GotoRegisterSellerViewController.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 31/08/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit

class GotoRegisterSellerViewController: UIViewController, UITabBarDelegate {

    @IBOutlet weak var ButtonSeller: UIButton!
    @IBOutlet weak var BeforeLabel: UILabel!
    @IBOutlet weak var YouNeedLabel: UILabel!
    
    let sharedPref = UserDefaults.standard
    var lang: String = ""
    var userID: String = ""
    
    @IBOutlet weak var Tabbar: UITabBar!
    var viewController1: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Tabbar.delegate = self
        ButtonSeller.layer.cornerRadius = 15
        
        lang = sharedPref.string(forKey: "LANG") ?? "0"
        if(lang == "ms"){
            changeLanguage(str: "ms")
            
        }else{
            changeLanguage(str: "en")
            
        }
    }
    
    func changeLanguage(str: String){
        ButtonSeller.titleLabel?.text = "BECOME A SELLER TODAY!".localized(lang: str)
        BeforeLabel.text = "You need to register as KetekMall Seller".localized(lang: str)
        YouNeedLabel.text = "Before you can start selling your product, ".localized(lang: str)
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
    
    func presentMethod(storyBoardName: String, storyBoardID: String) {
        let storyBoard: UIStoryboard = UIStoryboard(name: storyBoardName, bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: storyBoardID)
        self.definesPresentationContext = true
        self.present(newViewController, animated: true, completion: nil)
    }
    
    @IBAction func GotoRegisterPage(_ sender: Any) {

        let RegisterSeller = self.storyboard!.instantiateViewController(identifier: "RegisterSellerViewController") as! RegisterSellerViewController
        RegisterSeller.UserID = userID
        if let navigator = self.navigationController {
            navigator.pushViewController(RegisterSeller, animated: true)
        }
    }
}
