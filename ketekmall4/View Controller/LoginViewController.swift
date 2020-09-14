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
import FBSDKCoreKit
import JGProgressHUD

class LoginViewController: UIViewController, GIDSignInDelegate, LoginButtonDelegate {
    
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
//    @IBOutlet weak var scrollView: UIScrollView!
    private let loginButton = FBLoginButton()
    @IBOutlet weak var FBView: UIView!
    
    let hud = JGProgressHUD(style: .dark)
    
    let sharedPref = UserDefaults.standard
    var tokenUser: String = ""
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let boolValue = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
        if(boolValue == true){
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            
            UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
            UserDefaults.standard.synchronize()
            let tabbar = self.storyboard!.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
//            tabbar.userID = userID[0]
            if let navigator = self.navigationController {
                navigator.pushViewController(tabbar, animated: true)
            }
        }else{
            hud.dismiss(afterDelay: 3.0)
        }
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.clientID = "918843433379-sttk0oa9ea0htiqt3j3ncakoi2vrma2i.apps.googleusercontent.com"
        GIDSignIn.sharedInstance()?.delegate = self
        
        loginButton.permissions = ["public_profile", "email"]
        FBView.addSubview(loginButton)
        
        loginButton.frame = CGRect(x: 0, y: 0, width: 300, height: FBView.bounds.height)
        
        if let token = AccessToken.current,
            !token.isExpired {
            let token = token.tokenString
            
            let request = FBSDKLoginKit.GraphRequest(graphPath: "me",
                                                     parameters: ["fields": "email, name"],
                                                     tokenString: token,
                                                     version: nil,
                                                     httpMethod: .get)
            request.start(completionHandler: {connection, result, error in
                print("Result: \(result ?? "No Data")")
                
                if error != nil {
                    self.hud.indicatorView = JGProgressHUDErrorIndicatorView()
                    self.hud.show(in: self.view)
                    self.hud.dismiss(afterDelay: 3.0)
                    print("FAILED FACEBOOK LOGIN")
                }
                else{
                    self.hud.show(in: self.view)
                    if let userData = result as? [String:AnyObject] {
                        let username = userData["name"] as? String
                        let email = userData["email"] as? String
                        let userID = userData["id"] as? String
                        let facebookProfileUrl = "http://graph.facebook.com/\(userID ?? "no data")/picture?type=large"
                        
                        let parameters: Parameters=[
                            "name": username!,
                            "email": email!,
                            "phone_no": "000000000000",
                            "password": username! + email!,
                            "birthday": "00/00/2020",
                            "gender": "Female",
                            "photo": facebookProfileUrl,
                            "verification": "0",
                        ]
                        Alamofire.request(self.URL_REGISTER, method: .post, parameters: parameters).responseJSON
                            {
                                response in
                                self.hud.dismiss(afterDelay: 3.0)
                                if let result = response.result.value {
                                    let jsonData = result as! NSDictionary
                                    print(jsonData.value(forKey: "message")!)
                                    self.login(email: email!, password: username! + email!)
                                }else{
                                    self.hud.dismiss(afterDelay: 3.0)
                                    self.login(email: email!, password: username! + email!)
                                }
                        }
                    }
                }
            })
        }

        GIDSignIn.sharedInstance()?.shouldFetchBasicProfile = true
        if (GIDSignIn.sharedInstance()?.hasPreviousSignIn())! {
            GIDSignIn.sharedInstance()?.restorePreviousSignIn()
            InstanceID.instanceID().instanceID { (result, error) in
                if let error = error {
                    print("Error fetching remote instange ID: \(error)")
                } else if let result = result {
                    print("Remote instance ID token: \(result.token)")
                    self.tokenUser = result.token
                }
            }
        }else{
            InstanceID.instanceID().instanceID { (result, error) in
                if let error = error {
                    print("Error fetching remote instange ID: \(error)")
                } else if let result = result {
                    print("Remote instance ID token: \(result.token)")
                    self.tokenUser = result.token
                }
            }
        }

        EmailImage.layer.cornerRadius = 5
        PasswordImage.layer.cornerRadius = 5
        Border.layer.cornerRadius = 2
        LoginStyle.layer.cornerRadius = 10
        GoogleSignInBtn.layer.cornerRadius = 10
        loginButton.layer.cornerRadius = 10
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        //TODO
    }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        let token = result?.token?.tokenString
        
        let request = FBSDKLoginKit.GraphRequest(graphPath: "me",
                                                 parameters: ["fields": "email, name"],
                                                 tokenString: token,
                                                 version: nil,
                                                 httpMethod: .get)
        request.start(completionHandler: {connection, result, error in
            print("\(result ?? "No Data")")
        })
        
        
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        print("\(user.profile.givenName ?? "No Email")")
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
    
    func login(email: String, password: String){
        hud.show(in: self.view)
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
                        self.hud.dismiss(afterDelay: 3.0)
                        let user = jsonData.value(forKey: "login") as! NSArray
                        
                        let userID = user.value(forKey: "id") as! [String]
                        let NAME = user.value(forKey: "name") as! [String]
                        let EMAIL = user.value(forKey: "email") as! [String]
                        
                        UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                        UserDefaults.standard.synchronize()
                        
                        self.sharedPref.setValue(userID[0], forKey: "USERID")
                        self.sharedPref.setValue(NAME[0], forKey: "NAME")
                        self.sharedPref.setValue(EMAIL[0], forKey: "EMAIL")
                        
                        let tabbar = self.storyboard!.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
                        tabbar.userID = userID[0]
                        if let navigator = self.navigationController {
                            navigator.pushViewController(tabbar, animated: true)
                        }
                    }else{
                        self.hud.indicatorView = JGProgressHUDErrorIndicatorView()
                        self.hud.textLabel.text = "Invalid email or password"
                        self.hud.show(in: self.view)
                        self.hud.dismiss(afterDelay: 4.0)
                        print("Invalid email or password")
                    }
                }
        }
    }
    
    @IBAction func Login(_ sender: Any) {
        hud.show(in: self.view)
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
                        self.hud.dismiss(afterDelay: 3.0)
                        let user = jsonData.value(forKey: "login") as! NSArray
                        
                        let userID = user.value(forKey: "id") as! [String]
                        let NAME = user.value(forKey: "name") as! [String]
                        let EMAIL = user.value(forKey: "email") as! [String]
                        
                        self.sharedPref.setValue(userID[0], forKey: "USERID")
                        self.sharedPref.setValue(NAME[0], forKey: "NAME")
                        self.sharedPref.setValue(EMAIL[0], forKey: "EMAIL")
                        
                        UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                        UserDefaults.standard.synchronize()
                        
                        let tabbar = self.storyboard!.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
                        tabbar.userID = userID[0]
                        if let navigator = self.navigationController {
                            navigator.pushViewController(tabbar, animated: true)
                        }
                    }else{
                        self.hud.indicatorView = JGProgressHUDErrorIndicatorView()
                        self.hud.textLabel.text = "Invalid email or password"
                        self.hud.show(in: self.view)
                        self.hud.dismiss(afterDelay: 4.0)
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
