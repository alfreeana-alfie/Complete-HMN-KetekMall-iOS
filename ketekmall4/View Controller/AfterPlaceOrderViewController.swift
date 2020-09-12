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
        if(lang == "ms"){
            changeLanguage(str: "ms")
            
        }else{
            changeLanguage(str: "en")
            
        }
        
        Tabbar.delegate = self
        ButtonShopping.layer.cornerRadius = 5
    }
    
    func changeLanguage(str: String){
        ButtonShopping.titleLabel?.text = "Continue Shopping".localized(lang: str)
        ContinueLabel.text = "Continue Shopping".localized(lang: str)
    }


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

    
    @IBAction func ContinueShopping(_ sender: Any) {
        let parameters: Parameters=[
            "customer_id": userID
        ]
        
        Alamofire.request(URL_DELETE, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        let user = jsonData.value(forKey: "read") as! NSArray
                        
                        let boostAd = self.storyboard!.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
                        boostAd.userID = self.userID
                        if let navigator = self.navigationController {
                            navigator.pushViewController(boostAd, animated: true)
                        }
                    }
                }else{
                    print("FAILED")
                }
                
        }
    }

}
