//
//  LoginViewController.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 27/08/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//


import UIKit
import Alamofire
import GoogleSignIn
import Firebase
import FirebaseMessaging
import FirebaseInstanceID
import FBSDKLoginKit

class LoginViewController: UIViewController, GIDSignInDelegate {
    
    let URL_LOGIN = "https://ketekmall.com/ketekmall/login.php"
    let URL_READ = "https://ketekmall.com/ketekmall/read_detail.php"
    let URL_REGISTER = "https://ketekmall.com/ketekmall/register.php"
    let URL_FIREBASE = "https://click-1595830894120.firebaseio.com/users.json"

    @IBOutlet weak var Border: UIView!
    @IBOutlet weak var EmailField: UITextField!
    @IBOutlet weak var PasswordField: UITextField!
    @IBOutlet weak var LoginStyle: UIButton!
    @IBOutlet weak var EmailImage: UIImageView!
    @IBOutlet weak var PasswordImage: UIImageView!
    @IBOutlet weak var GoogleSignInBtn: GIDSignInButton!
//    @IBOutlet weak var loginButton: FBLoginButton!
    
    let sharedPref = UserDefaults.standard
    var tokenUser: String = ""
    
//    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
//        let token = result?.token?.tokenString
//
//        let request = FBSDKLoginKit.GraphRequest(graphPath: "me",
//                                                 parameters: ["fields": "email, name"],
//                                                 tokenString: token,
//                                                 version: nil,
//                                                 httpMethod: .get)
//        request.start(completionHandler: { connection , result, error in
//            print("\(result)")
//        })
//    }
//
//    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
//
//    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        let parameters: Parameters=[
                    "name": user.profile.familyName!,
                    "email": user.profile.email!,
                    "phone_no": "000000000000",
                    "password": user.profile.givenName + user.profile.familyName,
                    "birthday": "00/00/2020",
                    "gender": "Female",
                    "photo": user.profile.imageURL(withDimension: 100) ?? "No Email",
                    "verification": "0",
                ]
                Alamofire.request(URL_REGISTER, method: .post, parameters: parameters).responseJSON
                {
                    response in
                    if let result = response.result.value {
                        let jsonData = result as! NSDictionary
                        print(jsonData.value(forKey: "message")!)
                        self.login(email: user.profile.email, password: user.profile.givenName + user.profile.familyName)
                    }else{
                        print("FAILED")
                        self.login(email: user.profile.email!, password: user.profile.givenName + user.profile.familyName)
                    }
                }
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        loginButton.delegate = self
//        loginButton.permissions = ["public_profile", "email"]
        
//        if let token = AccessToken.current,
//            !token.isExpired {
//            let token = token.tokenString
//
//            let request = FBSDKLoginKit.GraphRequest(graphPath: "me",
//                                                     parameters: ["fields": "email, name"],
//                                                     tokenString: token,
//                                                     version: nil,
//                                                     httpMethod: .get)
//            request.start(completionHandler: { connection , result, error in
//                print("\(result)")
//            })
//
//        }
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.clientID = "918843433379-sttk0oa9ea0htiqt3j3ncakoi2vrma2i.apps.googleusercontent.com"
        GIDSignIn.sharedInstance()?.delegate = self
        
        InstanceID.instanceID().instanceID { (result, error) in
        if let error = error {
        print("Error fetching remote instange ID: \(error)")
        } else if let result = result {
        print("Remote instance ID token: \(result.token)")
            self.tokenUser = result.token
         }
        }
        
        
//        GIDSignIn.sharedInstance()?.signIn()
        
        GIDSignIn.sharedInstance()?.shouldFetchBasicProfile = true
        if (GIDSignIn.sharedInstance()?.hasPreviousSignIn())! {
            GIDSignIn.sharedInstance()?.restorePreviousSignIn()
            
        }else{
            GIDSignIn.sharedInstance()?.signIn()
             
        }
       
        let boolValue = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
        if(boolValue == true){
            UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
            UserDefaults.standard.synchronize()
            let tabbar = self.storyboard!.instantiateViewController(identifier: "myTab") as! BaseTabBarController
            if let navigator = self.navigationController {
                navigator.pushViewController(tabbar, animated: true)
            }
        }

        EmailImage.layer.cornerRadius = 5
        PasswordImage.layer.cornerRadius = 5
        Border.layer.cornerRadius = 2
        LoginStyle.layer.cornerRadius = 20
    }
    
    func login(email: String, password: String){
        let parameters: Parameters=[
            "email":email,
            "password":password,
        ]
        
        
        Alamofire.request(URL_LOGIN, method: .post, parameters: parameters).responseJSON
            {
                response in
                
                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        let user = jsonData.value(forKey: "login") as! NSArray
                        
                        let userID = user.value(forKey: "id") as! [String]
                        
                        self.sharedPref.setValue(userID[0], forKey: "USERID")
 
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
                        
                        self.sharedPref.setValue(userID[0], forKey: "USERID")
                        
                        
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
}
