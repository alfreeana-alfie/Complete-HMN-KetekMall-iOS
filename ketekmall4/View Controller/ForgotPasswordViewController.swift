//
//  ForgotPasswordViewController.swift
//  ketekmall4
//
//  Created by HMN Nadhir on 27/08/2020.
//  Copyright © 2020 HMN Nadhir. All rights reserved.
//

import UIKit
import Alamofire
import JGProgressHUD

class ForgotPasswordViewController: UIViewController, UITextFieldDelegate {
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
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        ColorFunc()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Email.delegate = self
        
        Border.layer.cornerRadius = 2
        ButtonSend.layer.cornerRadius = 20
        
        EmailView.layer.cornerRadius = 5
        EmailImage.layer.cornerRadius = 5
        
        EmailImage.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func ColorFunc(){
        let color1 = UIColor(hexString: "#FC4A1A").cgColor
        let color2 = UIColor(hexString: "#F7B733").cgColor
        
        let l = CAGradientLayer()
        l.frame = ButtonSend.bounds
        l.colors = [color1, color2]
        l.startPoint = CGPoint(x: 0, y: 0.5)
        l.endPoint = CGPoint(x: 1, y: 0.5)
        l.cornerRadius = 16
        ButtonSend.layer.insertSublayer(l, at: 0)
    }
}
