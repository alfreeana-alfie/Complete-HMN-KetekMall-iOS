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
                        
                        //Sending http post request
                        Alamofire.request(URL_LOGIN, method: .post, parameters: parameters).responseJSON
                        {
                            response in
                            //printing response
//                            print(response)
                            
                            
                            if let result = response.result.value{
                                let jsonData = result as! NSDictionary

                                if((jsonData.value(forKey: "success") as! NSString).boolValue){
                                    let user = jsonData.value(forKey: "login") as! NSArray

                                    let userID = user.value(forKey: "id") as! [String]
//                                    let name = user.value(forKey: "name") as! [String]
//                                    let email = user.value(forKey: "email") as! [String]
//                                    let phone = user.value(forKey: "phone_no") as! [String]
//                                    let addr01 = user.value(forKey: "address_01") as! [String]
//                                    let addr02 = user.value(forKey: "address_02") as! [String]
//                                    let city = user.value(forKey: "division") as! [String]
//                                    let postcode = user.value(forKey: "postcode") as! [String]
//                                    let birthday = user.value(forKey: "birthday") as! [String]
//                                    let gender = user.value(forKey: "gender") as! [String]
//                                    let photo = user.value(forKey: "photo") as! [String]
//                                    let icno = user.value(forKey: "ic_no") as! [String]
//                                    let bankname = user.value(forKey: "bank_name") as! [String]
//                                    let bankacc = user.value(forKey: "bank_acc") as! [String]
                                
                                
        //                            let accountSettingsViewController = self.storyboard!.instantiateViewController(identifier: "AccountSettingsViewController") as! AccountSettingsViewController
        //                            accountSettingsViewController.userID = userID[0]
        //                            accountSettingsViewController.name = name[0]
        //                            accountSettingsViewController.email = email[0]
        //                            accountSettingsViewController.phone_no = phone[0]
        //                            accountSettingsViewController.addr01 = addr01[0]
        //                            accountSettingsViewController.addr02 = addr02[0]
        //                            accountSettingsViewController.city = city[0]
        //                            accountSettingsViewController.postcode = postcode[0]
        //                            accountSettingsViewController.birthday = birthday[0]
        //                            accountSettingsViewController.gender = gender[0]
        //                            accountSettingsViewController.icno = icno[0]
        //                            accountSettingsViewController.bankname = bankname[0]
        //                            accountSettingsViewController.bankacc = bankacc[0]
        //                            accountSettingsViewController.photo = photo[0]
        //
        //                            self.navigationController?.pushViewController(accountSettingsViewController, animated: true)
                                    
        //                            self.dismiss(animated: false, completion: nil)
                                    
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

//        view.backgroundColor = UIColor.red
    }
}
