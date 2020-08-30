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
    
    @IBAction func sendEmail(_ sender: Any) {
        let parameters: Parameters=[
            "email":Email.text!,
        ]
        
        //Sending http post request
        Alamofire.request(URL_SEND_EMAIL, method: .post, parameters: parameters).responseJSON
        {
            response in
            //printing response
            print(response)
            
            //getting the json value from the server
            if let result = response.result.value {
                
                //converting it as NSDictionary
                let jsonData = result as! NSDictionary
                print(jsonData.value(forKey: "message")!)
            }
        }
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
