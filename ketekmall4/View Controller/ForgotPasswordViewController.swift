//
//  ForgotPasswordViewController.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 27/08/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit
import Alamofire
import JGProgressHUD

class ForgotPasswordViewController: UIViewController {
    let URL_SEND_EMAIL = "https://ketekmall.com/ketekmall/sendEmail_getPassword.php";
    
    private let spinner = JGProgressHUD(style: .dark)
    
    @IBOutlet weak var EmailView: UIView!
    @IBOutlet weak var EmailImage: UIImageView!
    
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var Border: UIView!
    @IBOutlet weak var ButtonSend: UIButton!
    
    @IBAction func sendEmail(_ sender: Any) {
        spinner.show(in: self.view)
        let parameters: Parameters=[
            "email":Email.text!,
        ]
        Alamofire.request(URL_SEND_EMAIL, method: .post, parameters: parameters).responseJSON
        {
            response in
            if let result = response.result.value {
                let jsonData = result as! NSDictionary
                print(jsonData.value(forKey: "message")!)
                self.spinner.dismiss(afterDelay: 3.0)
            }else{
                self.spinner.indicatorView = JGProgressHUDErrorIndicatorView()
                self.spinner.textLabel.text = "Failed"
                self.spinner.show(in: self.view)
                self.spinner.dismiss(afterDelay: 4.0)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Border.layer.cornerRadius = 2
        ButtonSend.layer.cornerRadius = 20
        
        EmailView.layer.cornerRadius = 5
        EmailImage.layer.cornerRadius = 5
        
        EmailImage.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
    }
}
