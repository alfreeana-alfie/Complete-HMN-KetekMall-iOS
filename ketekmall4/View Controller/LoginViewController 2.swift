//
//  LoginViewController.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 27/08/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {
    
    let URL_LOGIN = "https://ketekmall.com/ketekmall/login.php";
    let URL_READ = "https://ketekmall.com/ketekmall/read_detail.php";

    @IBOutlet weak var EmailField: UITextField!
    @IBOutlet weak var PasswordField: UITextField!
    
    @IBAction func Login(_ sender: Any) {
        let parameters: Parameters=[
                            "email":EmailField.text!,
                            "password":PasswordField.text!,
                        ]
                        
                       
                        Alamofire.request(URL_LOGIN, method: .post, parameters: parameters).responseJSON
                        {
                            response in
                            
                            if let result = response.result.value{
                                let jsonData = result as! NSDictionary

                                if((jsonData.value(forKey: "success") as! NSString).boolValue){
                                    let user = jsonData.value(forKey: "login") as! NSArray

                                    let userID = user.value(forKey: "id") as! [String]
                                    
                                    let tabbar = self.storyboard!.instantiateViewController(identifier: "myTab") as! BaseTabBarController
                                    tabbar.value = userID[0]
                                    if let navigator = self.navigationController {
                                        navigator.pushViewController(tabbar, animated: true)
                                    }
                                }else{
                                    print("Invalid email or password")
                                }
                            }
                        }
    }
    
    @IBAction func GotoReset(_ sender: Any) {
        let forgotViewController = self.storyboard!.instantiateViewController(identifier: "ForgotPasswordViewController") as! ForgotPasswordViewController
        
        self.navigationController?.pushViewController(forgotViewController, animated: true)
                                    
        self.dismiss(animated: false, completion: nil)
    }
    
    
    @IBAction func GotoRegister(_ sender: Any) {
        let registerViewController = self.storyboard!.instantiateViewController(identifier: "RegisterViewController") as! RegisterViewController
        
        self.navigationController?.pushViewController(registerViewController, animated: true)
                                    
        self.dismiss(animated: false, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
