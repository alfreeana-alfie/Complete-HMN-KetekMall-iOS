//
//  ForgotPasswordViewController.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 27/08/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit
import Alamofire

class ForgotPasswordViewController: UIViewController {
    let URL_SEND_EMAIL = "https://ketekmall.com/ketekmall/sendEmail_getPassword.php";
    
    
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var Border: UIView!
    @IBOutlet weak var ButtonSend: UIButton!
    
    @IBAction func sendEmail(_ sender: Any) {
        let parameters: Parameters=[
            "email":Email.text!,
        ]
        Alamofire.request(URL_SEND_EMAIL, method: .post, parameters: parameters).responseJSON
        {
            response in
            if let result = response.result.value {
                let jsonData = result as! NSDictionary
                print(jsonData.value(forKey: "message")!)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Border.layer.cornerRadius = 2
        ButtonSend.layer.cornerRadius = 20
    }
}
