//
//  BuyerViewController.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 05/09/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit

class BuyerViewController: UIViewController {

    var userID: String = ""
    let sharedPref = UserDefaults.standard
    var user: String = ""
    var name: String = ""
    var email: String = ""
    var lang: String = ""
    
    @IBOutlet weak var ButtonMyBuying: UIButton!
    @IBOutlet weak var ButtonMyLikes: UIButton!
    @IBOutlet weak var ButtonMyRating: UIButton!
    @IBOutlet weak var ButtonAccountSettings: UIButton!
    @IBOutlet weak var ButtonHelpCentre: UIButton!
    @IBOutlet weak var ButtonChatInbox: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lang = sharedPref.string(forKey: "LANG") ?? "0"
        if(lang == "ms"){
            changeLanguage(str: "ms")
            
        }else{
            changeLanguage(str: "en")
            
        }
        
        user = sharedPref.string(forKey: "USERID") ?? "0"
        name = sharedPref.string(forKey: "NAME") ?? "0"
        email = sharedPref.string(forKey: "EMAIL") ?? "0"
        
        userID = String(user)
    }
    
    func changeLanguage(str: String){
        ButtonMyBuying.setTitle("My Buying".localized(lang: str), for: .normal)
        ButtonMyLikes.setTitle("My Likes".localized(lang: str), for: .normal)
        ButtonMyRating.setTitle("My Rating".localized(lang: str), for: .normal)
        ButtonAccountSettings.setTitle("Account Settings".localized(lang: str), for: .normal)
        ButtonHelpCentre.setTitle("Help Centre".localized(lang: str), for: .normal)
        ButtonChatInbox.setTitle("Chat Inbox".localized(lang: str), for: .normal)
        
//        ButtonMyBuying.titleLabel?.text = "My Buying".localized(lang: str)
//        ButtonMyLikes.titleLabel?.text = "My Likes".localized(lang: str)
//        ButtonMyRating.titleLabel?.text = "My Rating".localized(lang: str)
//        ButtonAccountSettings.titleLabel?.text = "Account Settings".localized(lang: str)
//        ButtonHelpCentre.titleLabel?.text = "Help Centre".localized(lang: str)
//        ButtonChatInbox.titleLabel?.text = "Chat Inbox".localized(lang: str)
    }
    
    @IBAction func didTapGoogle(sender: AnyObject) {
        UIApplication.shared.openURL(NSURL(string: "https://ketekmall.com")! as URL)
    }
    
  @IBAction func MyBuying(_ sender: Any) {
        let myBuying = self.storyboard!.instantiateViewController(identifier: "MyBuyingViewController") as! MyBuyingViewController
        myBuying.userID = userID
        myBuying.BarHidden = true
        if let navigator = self.navigationController {
            navigator.pushViewController(myBuying, animated: true)
        }
    }

    @IBAction func ChatInbox(_ sender: Any) {
        let myBuying = self.storyboard!.instantiateViewController(identifier: "ChatInboxViewController") as! ChatInboxViewController
        myBuying.BarHidden = true
        if let navigator = self.navigationController {
            navigator.pushViewController(myBuying, animated: true)
        }
    }
    
    @IBAction func MyRating(_ sender: Any) {
        let myRating = self.storyboard!.instantiateViewController(identifier: "MyRatingViewController") as! MyRatingViewController
        myRating.userID = userID
        if let navigator = self.navigationController {
            navigator.pushViewController(myRating, animated: true)
        }
    }
    
    @IBAction func MyLikes(_ sender: Any) {
        let myLikes = self.storyboard!.instantiateViewController(identifier: "MyLikesViewController") as! MyLikesViewController
        myLikes.userID = userID
        if let navigator = self.navigationController {
            navigator.pushViewController(myLikes, animated: true)
        }
    }
    
    @IBAction func AccountSettings(_ sender: Any) {
        let accountsettings = self.storyboard!.instantiateViewController(identifier: "AccountSettingsViewController") as! AccountSettingsViewController
        accountsettings.userID = userID
        if let navigator = self.navigationController {
            navigator.pushViewController(accountsettings, animated: true)
        }
    }
}
