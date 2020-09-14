//
//  RegisterSellerViewController.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 31/08/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit
import Alamofire

class RegisterSellerViewController: UIViewController, UITabBarDelegate {
    
    let URL_EDIT = "https://ketekmall.com/ketekmall/edit_detail_seller.php"
    
    @IBOutlet weak var ICNOField: UITextField!
    @IBOutlet weak var BankNameField: UITextField!
    @IBOutlet weak var BankAccField: UITextField!
    @IBOutlet weak var ICView: UIView!
    @IBOutlet weak var BankNameView: UIView!
    @IBOutlet weak var BankAccView: UIView!
    @IBOutlet weak var ButtonAccept: UIButton!
    @IBOutlet weak var ButtonCancel: UIButton!
    @IBOutlet weak var Tabbar: UITabBar!
    
    let sharedPref = UserDefaults.standard
    var lang: String = ""
    var UserID: String = ""
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
        
        ICView.layer.cornerRadius = 5
        BankNameView.layer.cornerRadius = 5
        BankAccView.layer.cornerRadius = 5
        ButtonAccept.layer.cornerRadius = 5
        ButtonCancel.layer.cornerRadius = 5
    }
    
    func changeLanguage(str: String){
        ButtonAccept.titleLabel?.text = "ACCEPT".localized(lang: str)
        ButtonCancel.titleLabel?.text = "CANCEL".localized(lang: str)
        BankNameField.placeholder = "Bank Name".localized(lang: str)
        BankAccField.placeholder = "Bank Account".localized(lang: str)
        
        ICNOField.placeholder = "IC No. ".localized(lang: str)
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

    
    @IBAction func Accept(_ sender: Any) {
        let parameters: Parameters=[
            "id": UserID,
            "ic_no": ICNOField.text!,
            "bank_name": BankNameField.text!,
            "bank_acc": BankAccField.text!,
            "verification": "1"
        ]
        
        //Sending http post request
        Alamofire.request(URL_EDIT, method: .post, parameters: parameters).responseJSON
            {
                response in
                print(response)
                
                let boostAd = self.storyboard!.instantiateViewController(identifier: "AddNewProductViewController") as! AddNewProductViewController
                boostAd.userID = self.UserID
                if let navigator = self.navigationController {
                    navigator.pushViewController(boostAd, animated: true)
                }
        }
    }
    
    @IBAction func Cancel(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
}
