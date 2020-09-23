//
//  AddReviewViewController.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 02/09/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit
import Alamofire
import AARatingBar
import JGProgressHUD

class AddReviewViewController: UIViewController {
    
    let URL_ADD = "https://ketekmall.com/ketekmall/add_review.php"
    let URL_READ = "https://ketekmall.com/ketekmall/read_detail.php"
    
    private let spinner = JGProgressHUD(style: .dark)
    
    @IBOutlet weak var Review: UITextView!
    @IBOutlet weak var ButtonSubmit: UIButton!
    @IBOutlet weak var ButtonCancel: UIButton!
    @IBOutlet weak var Rating: AARatingBar!
    
    var USERNAME: String = ""
    var USERID: String = ""
    var SELLERID: String = ""
    var ITEMID: String = ""
    var RATING: String = ""
    
    let sharedPref = UserDefaults.standard
    var lang: String = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        lang = sharedPref.string(forKey: "LANG") ?? "0"
        if(lang == "ms"){
            changeLanguage(str: "ms")
            
        }else{
            changeLanguage(str: "en")
            
        }

        getUserDetails()
        
        ButtonSubmit.layer.cornerRadius = 5
        ButtonCancel.layer.cornerRadius = 5
        Rating.ratingDidChange = { ratingValue in
            self.RATING = String(format: "%.2f", ratingValue)
        }
        
    }
    
    func changeLanguage(str: String){
        ButtonSubmit.setTitle("SUBMIT".localized(lang: str), for: .normal)
        ButtonCancel.setTitle("Cancel".localized(lang: str), for: .normal)
    }

    
    func getUserDetails(){
        spinner.show(in: self.view)
        let parameters: Parameters=[
            "id": USERID
        ]
        
        Alamofire.request(URL_READ, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value{
                    self.spinner.dismiss(afterDelay: 3.0)
                    let jsonData = result as! NSDictionary
                    
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        let user = jsonData.value(forKey: "read") as! NSArray
                        
                        let name = user.value(forKey: "name") as! [String]
                        
                        self.USERNAME = name[0]
                    }
                }else{
                    self.spinner.indicatorView = JGProgressHUDErrorIndicatorView()
                    self.spinner.textLabel.text = "Failed"
                    self.spinner.show(in: self.view)
                    self.spinner.dismiss(afterDelay: 4.0)
                }
                
        }
    }
    
    @IBAction func Submit(_ sender: Any) {
        spinner.show(in: self.view)
        let parameters: Parameters=[
            "seller_id": SELLERID,
            "customer_id": USERID,
            "customer_name": USERNAME,
            "item_id": ITEMID,
            "review": Review.text!,
            "rating": RATING,
        ]
        
        //Sending http post request
        Alamofire.request(URL_ADD, method: .post, parameters: parameters).responseJSON
            {
                response in
                self.spinner.dismiss(afterDelay: 3.0)
                if let result = response.result.value {
                    
                    //converting it as NSDictionary
                    let jsonData = result as! NSDictionary
                    print(jsonData.value(forKey: "message")!)
                    let MeView = self.storyboard!.instantiateViewController(identifier: "MyBuyingViewController") as! MyBuyingViewController
                    MeView.userID = self.USERID
                    if let navigator = self.navigationController {
                        navigator.pushViewController(MeView, animated: true)
                    }
                }else{
                    self.spinner.indicatorView = JGProgressHUDErrorIndicatorView()
                    self.spinner.textLabel.text = "Failed"
                    self.spinner.show(in: self.view)
                    self.spinner.dismiss(afterDelay: 4.0)
                }
        }
    }
    
    @IBAction func Cancel(_ sender: Any) {
         _ = navigationController?.popViewController(animated: true)
    }
}
