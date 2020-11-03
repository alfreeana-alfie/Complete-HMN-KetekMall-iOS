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
    }
    
    @IBAction func didTapGoogle(sender: AnyObject) {
        UIApplication.shared.openURL(NSURL(string: "https://ketekmall.com")! as URL)
    }
    
  @IBAction func MyBuying(_ sender: Any) {
        let myBuying = self.storyboard!.instantiateViewController(withIdentifier: "MyBuyingViewController") as! MyBuyingViewController
        myBuying.userID = userID
        myBuying.BarHidden = true
        if let navigator = self.navigationController {
            navigator.pushViewController(myBuying, animated: true)
        }
    }

    @IBAction func ChatInbox(_ sender: Any) {
       let myBuying = self.storyboard!.instantiateViewController(withIdentifier: "ChatInboxTwoViewController") as! ChatInboxTwoViewController
        myBuying.BarHidden = true
        if let navigator = self.navigationController {
            navigator.pushViewController(myBuying, animated: true)
        }
    }
    
    @IBAction func MyRating(_ sender: Any) {
        let myRating = self.storyboard!.instantiateViewController(withIdentifier: "MyRatingViewController") as! MyRatingViewController
        myRating.userID = userID
        if let navigator = self.navigationController {
            navigator.pushViewController(myRating, animated: true)
        }
    }
    
    @IBAction func MyLikes(_ sender: Any) {
        let myLikes = self.storyboard!.instantiateViewController(withIdentifier: "MyLikesViewController") as! MyLikesViewController
        myLikes.userID = userID
        if let navigator = self.navigationController {
            navigator.pushViewController(myLikes, animated: true)
        }
    }
    
    @IBAction func AccountSettings(_ sender: Any) {
        let accountsettings = self.storyboard!.instantiateViewController(withIdentifier: "AccountSettingsViewController") as! AccountSettingsViewController
        accountsettings.userID = userID
        if let navigator = self.navigationController {
            navigator.pushViewController(accountsettings, animated: true)
        }
    }
}
