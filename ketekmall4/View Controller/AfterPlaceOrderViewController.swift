//
//  AfterPlaceOrderViewController.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 02/09/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit
import Alamofire

class AfterPlaceOrderViewController: UIViewController, UITabBarDelegate {
    
    let URL_DELETE = "https://ketekmall.com/ketekmall/delete_order_buyer.php"
    
    let sharedPref = UserDefaults.standard
    var lang: String = ""
    var userID: String = ""
    
    @IBOutlet weak var ButtonShopping: UIButton!
    @IBOutlet weak var ContinueLabel: UILabel!
    @IBOutlet weak var Tabbar: UITabBar!

    var viewController1: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lang = sharedPref.string(forKey: "LANG") ?? "0"
//        userID = sharedPref.string(forKey: "USERID") ?? "0"
        
        if(lang == "ms"){
            changeLanguage(str: "ms")
            
        }else{
            changeLanguage(str: "en")
            
        }
        let parameters: Parameters=[
                   "customer_id": userID
               ]
               
               Alamofire.request(URL_DELETE, method: .post, parameters: parameters).responseJSON
                   {
                       response in
                       if let result = response.result.value{
                           let jsonData = result as! NSDictionary
                           
                       }else{
                           print("FAILED")
                       }
                       
               }
        Tabbar.delegate = self
        ButtonShopping.layer.cornerRadius = 5
    }
    
    func changeLanguage(str: String){
        ButtonShopping.setTitle("Continue Shopping".localized(lang: str), for: .normal)
        ContinueLabel.text = "Continue Shopping".localized(lang: str)
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

    
    @IBAction func ContinueShopping(_ sender: Any) {
       navigationController?.setNavigationBarHidden(true, animated: false)
       let storyboard = UIStoryboard(name: "Main", bundle: nil)
       viewController1 = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
       if let navigator = self.navigationController {
           navigator.pushViewController(viewController1!, animated: true)
       }
    }

}
