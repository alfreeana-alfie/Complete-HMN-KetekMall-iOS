//
//  ContactUsViewController.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 10/09/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit

class ContactUsViewController: UIViewController, UITabBarDelegate {

    @IBOutlet weak var Tabbar: UITabBar!
    var viewController1: UIViewController?
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Tabbar.delegate = self
    }
}
