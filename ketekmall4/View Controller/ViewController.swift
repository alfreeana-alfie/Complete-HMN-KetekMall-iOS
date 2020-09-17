//
//  ViewController.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 05/09/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit
import Alamofire
import JGProgressHUD

class ViewController: UIViewController, UITabBarDelegate {
    
    private let spinner = JGProgressHUD(style: .dark)

    @IBOutlet weak var Segment: UISegmentedControl!
    @IBOutlet weak var BuyerView: UIView!
    @IBOutlet weak var SellerView: UIView!
    @IBOutlet weak var VerifyView: UIView!
    @IBOutlet weak var CheckSellerView: UIView!
    
    let URL_READ = "https://ketekmall.com/ketekmall/read_detail.php";
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var verify: UILabel!
    var userID: String = ""
    
    @IBOutlet weak var Tabbar: UITabBar!
    var viewController1: UIViewController?
    
    let sharedPref = UserDefaults.standard
    var lang: String = ""
    var user: String = ""
    var name: String = ""
    var email: String = ""
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Tabbar.delegate = self
        lang = sharedPref.string(forKey: "LANG") ?? "0"
        if(lang == "ms"){
            changeLanguage(str: "ms")
            
        }else{
            changeLanguage(str: "en")
            
        }
        
        VerifyView.layer.cornerRadius = 7
        userImage.layer.cornerRadius = userImage.frame.width / 2
        userImage.layer.masksToBounds = true
        user = sharedPref.string(forKey: "USERID") ?? "0"
        name = sharedPref.string(forKey: "NAME") ?? "0"
        email = sharedPref.string(forKey: "EMAIL") ?? "0"
        userID = String(user)
        
        spinner.show(in: self.userImage)
        let parameters: Parameters=[
            "id": userID
        ]
        
        Alamofire.request(URL_READ, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        self.spinner.dismiss(afterDelay: 3.0)
                        let user = jsonData.value(forKey: "read") as! NSArray
                        
                        let name = user.value(forKey: "name") as! [String]
                        let verify = user.value(forKey: "verification") as! [String]
                        let Photo = user.value(forKey: "photo") as! [String]
                        
                        self.username.text = name[0]
                        if verify[0] == "1" {
                            self.verify.text = "SELLER"
                            
                        }else{
                            self.verify.text = "BUYER"
                        }
                        
                        self.userImage.setImageWith(URL(string: Photo[0])!)
                    }
                }else{
                    print("FAILED")
                }
                
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
    
    func changeLanguage(str: String){
        verify.text = "VERIFICATION".localized(lang: str)
        if(verify.text == "SELLER"){
            verify.text = "SELLER".localized(lang: str)
        }else{
            verify.text = "BUYER".localized(lang: str)
        }
        
        Tabbar.items?[0].title = "Home".localized(lang: str)
        Tabbar.items?[1].title = "Notification".localized(lang: str)
        Tabbar.items?[2].title = "Me".localized(lang: str)
        
        Segment.setTitle("My Buying".localized(lang: str), forSegmentAt: 0)
        Segment.setTitle("My Selling".localized(lang: str), forSegmentAt: 1)
    }
    
    @IBAction func SegmentClick(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            BuyerView.alpha = 1
            SellerView.alpha = 0
            break
            
        case 1:
            if(self.verify.text == "BUYER"){
                CheckSellerView.alpha = 1
                SellerView.alpha = 0
                BuyerView.alpha = 0
            }else{
                CheckSellerView.alpha = 0
                SellerView.alpha = 1
                BuyerView.alpha = 0
            }
            break
            
        default:
            break
        }
    }
}
