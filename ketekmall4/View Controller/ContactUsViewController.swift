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
            presentMethod(storyBoardName: "Main", storyBoardID: "HomeViewController")
            break
            
        case 2:
            presentMethod(storyBoardName: "Main", storyBoardID: "NotificationViewController")
            break
            
        case 3:
            presentMethod(storyBoardName: "Main", storyBoardID: "ViewController")
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Tabbar.delegate = self
    }
}
