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

//    override func viewDidAppear(_ animated: Bool) {
//        ColorFunc()
//    }
    
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
    
    func ColorFunc(){
        let colorView1 = UIColor(hexString: "#FC4A1A").cgColor
        let colorView2 = UIColor(hexString: "#F7B733").cgColor
        
        let l = CAGradientLayer()
        l.frame = self.view.bounds
        l.colors = [colorView1, colorView2]
        l.startPoint = CGPoint(x: 0, y: 0.5)
        l.endPoint = CGPoint(x: 1, y: 0.5)
        l.cornerRadius = 5
        self.view.layer.insertSublayer(l, at: 0)
        
        let color1 = UIColor(hexString: "#FC4A1A").cgColor
        let color2 = UIColor(hexString: "#F7B733").cgColor
        
        let ReceivedGradient = CAGradientLayer()
        ReceivedGradient.frame = ButtonSubmit.bounds
        ReceivedGradient.colors = [color1, color2]
        ReceivedGradient.startPoint = CGPoint(x: 0, y: 0.5)
        ReceivedGradient.endPoint = CGPoint(x: 1, y: 0.5)
        ReceivedGradient.cornerRadius = 5
        ButtonSubmit.layer.insertSublayer(ReceivedGradient, at: 0)
        
        let color3 = UIColor(hexString: "#FC4A1A").cgColor
        let color4 = UIColor(hexString: "#F7B733").cgColor
        
        let CancelGradient = CAGradientLayer()
        CancelGradient.frame = ButtonCancel.bounds
        CancelGradient.colors = [color3, color4]
        CancelGradient.startPoint = CGPoint(x: 0, y: 0.5)
        CancelGradient.endPoint = CGPoint(x: 1, y: 0.5)
        CancelGradient.cornerRadius = 5
        ButtonCancel.layer.insertSublayer(CancelGradient, at: 0)
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
                    self.spinner.indicatorView = JGProgressHUDSuccessIndicatorView()
                    self.spinner.textLabel.text = "Success"
                    self.spinner.show(in: self.view)
                    self.spinner.dismiss(afterDelay: 4.0)
                    _ = self.navigationController?.popToRootViewController(animated: true)
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
