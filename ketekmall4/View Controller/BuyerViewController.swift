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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tabbar = tabBarController as! BaseTabBarController
        userID = tabbar.value
    }
    
    @IBAction func didTapGoogle(sender: AnyObject) {
        UIApplication.shared.openURL(NSURL(string: "https://ketekmall.com")! as URL)
    }
    
  @IBAction func MyBuying(_ sender: Any) {
        let myBuying = self.storyboard!.instantiateViewController(identifier: "MyBuyingViewController") as! MyBuyingViewController
        myBuying.userID = userID
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
