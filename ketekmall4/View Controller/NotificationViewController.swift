//
//  NotificationViewController.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 09/09/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit



class NotificationViewController: UIViewController {

    let URL_SEARCH_SHOCKING_SALE = "https://ketekmall.com/ketekmall/search/readall_shocking.php"
    let URL_FILTER_DIVISION_SHOCKING_SALE = "https://ketekmall.com/ketekmall/filter_division/readall_shocking.php"
    let URL_FILTER_DISTRICT_SHOCKING_SALE = "https://ketekmall.com/ketekmall/filter_district/readall_shocking.php"
    let URL_FILTER_SEARCH_DIVISION_SHOCKING_SALE = "https://ketekmall.com/ketekmall/filter_search_division/readall_shocking.php"
    let URL_PRICE_UP_SHOCKING_SALE = "https://ketekmall.com/ketekmall/price_up/readall_shocking.php"
    let URL_PRICE_DOWN_SHOCKING_SALE = "https://ketekmall.com/ketekmall/price_down/readall_shocking.php"
    let URL_READ_SHOCKING_SALE = "https://ketekmall.com/ketekmall/category/readall_shocking.php"
    
    let sharedPref = UserDefaults.standard
    var lang: String = ""
    var user: String = ""
    
    
    @IBOutlet weak var OrderUpdateBtn: UIButton!
    @IBOutlet weak var SocialUpdatesBtn: UIButton!
    @IBOutlet weak var PromotionBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        user = sharedPref.string(forKey: "USERID") ?? "0"
        lang = sharedPref.string(forKey: "LANG") ?? "0"
        if(lang == "ms"){
            changeLanguage(str: "ms")
        }else{
            changeLanguage(str: "en")
        }
        
    }
    
    func changeLanguage(str: String){
        
        OrderUpdateBtn.titleLabel?.text = "Order Updates".localized(lang: str)
        SocialUpdatesBtn.titleLabel?.text = "Social Updates".localized(lang: str)
        PromotionBtn.titleLabel?.text = "Promotion".localized(lang: str)
    }

    
    @IBAction func OrderUpdates(_ sender: Any) {
        let myBuying = self.storyboard!.instantiateViewController(identifier: "MyBuyingViewController") as! MyBuyingViewController
        myBuying.userID = String(user)
        if let navigator = self.navigationController {
            navigator.pushViewController(myBuying, animated: true)
        }
    }
    
    @IBAction func SocialUpdates(_ sender: Any) {
        let myBuying = self.storyboard!.instantiateViewController(identifier: "ChatInboxViewController") as! ChatInboxViewController
        if let navigator = self.navigationController {
            navigator.pushViewController(myBuying, animated: true)
        }
    }
    
    @IBAction func Promotion(_ sender: Any) {
        let click = self.storyboard!.instantiateViewController(identifier: "CategoryViewController") as! CategoryViewController
               click.UserID = String(user)
               click.URL_READ = URL_READ_SHOCKING_SALE
               click.URL_SEARCH = URL_SEARCH_SHOCKING_SALE
               click.URL_FILTER_DIVISION = URL_FILTER_DIVISION_SHOCKING_SALE
               click.URL_FILTER_DISTRICT = URL_FILTER_DISTRICT_SHOCKING_SALE
               click.URL_FILTER_SEARCH_DIVISION = URL_FILTER_SEARCH_DIVISION_SHOCKING_SALE
               click.URL_PRICE_UP_READALL = URL_PRICE_UP_SHOCKING_SALE
               click.URL_PRICE_DOWN = URL_PRICE_DOWN_SHOCKING_SALE
               if let navigator = self.navigationController {
                   navigator.pushViewController(click, animated: true)
               }
    }
}
extension String {
func localized2(lang:String) ->String {

    let path = Bundle.main.path(forResource: lang, ofType: "lproj")
    let bundle = Bundle(path: path!)

    return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
}}