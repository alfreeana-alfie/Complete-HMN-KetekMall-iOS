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
    var userID: String = ""
    
    @IBOutlet weak var Tabbar: UITabBar!
    var viewController1: UIViewController?
    
    @IBAction func GotoRegisterPage(_ sender: Any) {

        let RegisterSeller = self.storyboard!.instantiateViewController(identifier: "RegisterSellerViewController") as! RegisterSellerViewController
        RegisterSeller.UserID = userID
        if let navigator = self.navigationController {
            navigator.pushViewController(RegisterSeller, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Tabbar.delegate = self
        ButtonSeller.layer.cornerRadius = 15
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem){
        switch item.tag {
        case 1:
            navigationController?.setNavigationBarHidden(true, animated: false)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            viewController1 = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            self.view.insertSubview(viewController1!.view!, belowSubview: self.Tabbar)
            break
            
        case 2:
            navigationController?.setNavigationBarHidden(true, animated: false)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            viewController1 = storyboard.instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
            self.view.insertSubview(viewController1!.view!, belowSubview: self.Tabbar)
            break
            
        case 3:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            viewController1 = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            self.view.insertSubview(viewController1!.view!, belowSubview: self.Tabbar)
            break
            
        default:
            break
        }
    }
}
