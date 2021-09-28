//
//  AppVersionViewController.swift
//  ketekmall4

import UIKit

class AppVersionViewController: UIViewController, UITabBarDelegate {
    
    @IBOutlet weak var Tabbar: UITabBar!
    @IBOutlet weak var tvAppVersion: UITextView!
    
    var viewController1: UIViewController?
    
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        Tabbar.delegate = self
        self.hideKeyboardWhenTappedAround()
        
        let strAppVersion = "Current Version 1.4.8"
        
        tvAppVersion.text = strAppVersion
        
    }

    @objc override func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
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
