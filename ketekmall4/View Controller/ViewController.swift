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

class ViewController: UIViewController {
    
    private let spinner = JGProgressHUD(style: .dark)

    @IBOutlet weak var Segment: UISegmentedControl!
    @IBOutlet weak var BuyerView: UIView!
    @IBOutlet weak var SellerView: UIView!
    
    let URL_READ = "https://ketekmall.com/ketekmall/read_detail.php";
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var verify: UILabel!
    var userID: String = ""
    
    let sharedPref = UserDefaults.standard
    var lang: String = ""
    var user: String = ""
    var name: String = ""
    var email: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        lang = sharedPref.string(forKey: "LANG") ?? "0"
        if(lang == "ms"){
            changeLanguage(str: "ms")
            
        }else{
            changeLanguage(str: "en")
            
        }
        
        verify.layer.cornerRadius = 15
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
    
    func changeLanguage(str: String){
        verify.text = "VERIFICATION".localized(lang: str)
        if(verify.text == "SELLER"){
            verify.text = "SELLER".localized(lang: str)
        }else{
            verify.text = "BUYER".localized(lang: str)
        }
    }
    
    @IBAction func SegmentClick(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            BuyerView.alpha = 1
            SellerView.alpha = 0
            break
            
        case 1:
            SellerView.alpha = 1
            BuyerView.alpha = 0
            break
            
        default:
            break
        }
    }
}
