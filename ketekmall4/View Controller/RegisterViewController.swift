//
//  RegisterViewController.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 27/08/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit
import Alamofire

class RegisterViewController: UIViewController {
    
    let URL_REGISTER = "https://ketekmall.com/ketekmall/register.php";
    let URL_PHOTO = "https://ketekmall.com/ketekmall/profile_image/main_photo.png";
    let VERIFY = "0";
    let GENDER = "Female";
    
    @IBOutlet weak var Name: UITextField!
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var PhoneNo: UITextField!
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var ConfirmPassword: UITextField!
    
    @IBAction func Register(_ sender: Any) {
        let parameters: Parameters=[
                    "name":Name.text!,
                    "email":Email.text!,
                    "phone_no":PhoneNo.text!,
                    "password":Password.text!,
                    "birthday": "",
                    "gender": GENDER,
                    "photo": URL_PHOTO,
                    "verification": VERIFY,
                ]
                
                //Sending http post request
                Alamofire.request(URL_REGISTER, method: .post, parameters: parameters).responseJSON
                {
                    response in
                    //printing response
                    print(response)
                    
                    //getting the json value from the server
                    if let result = response.result.value {
                        
                        //converting it as NSDictionary
                        let jsonData = result as! NSDictionary
                        print(jsonData.value(forKey: "message")!)
        //                self.labelMessage.text = jsonData.value(forKey: "message") as! String?
                    }
                }
    }
    
    @IBAction func GotoLogin(_ sender: Any) {
        let loginViewController = self.storyboard!.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
        
        self.navigationController?.pushViewController(loginViewController, animated: true)
                                    
        self.dismiss(animated: false, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
