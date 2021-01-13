import UIKit
import Firebase
import GoogleSignIn
import Alamofire
import FBSDKCoreKit
import LanguageManager_iOS
import UserNotifications
import OneSignal

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate{
    
    var window: UIWindow?
    let ONESIGNAL_APP_ID = "6236bfc3-df4d-4f44-82d6-754332044779"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Remove this method to stop OneSignal Debugging
          OneSignal.setLogLevel(.LL_VERBOSE, visualLevel: .LL_NONE)

          // OneSignal initialization
          OneSignal.initWithLaunchOptions(launchOptions)
          OneSignal.setAppId(ONESIGNAL_APP_ID)

          // promptForPushNotifications will show the native iOS notification permission prompt.
          // We recommend removing the following code and instead using an In-App Message to prompt for notification permission (See step 8)
          OneSignal.promptForPushNotifications(userResponse: { accepted in
            print("User accepted notifications: \(accepted)")
          })

        if #available(iOS 13.0, *) {
            window = UIWindow(frame: UIScreen.main.bounds)
            window?.rootViewController = UINavigationController(rootViewController: UIViewController())
            
            let isUserLoggedIn:Bool = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
            if(isUserLoggedIn) {
                let mainStoryboard = UIStoryboard(name: "Main" , bundle: nil)
                let protectedPage = mainStoryboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                window!.rootViewController = protectedPage
                window!.makeKeyAndVisible()
            }
        } else {
            // Fallback on earlier versions
        }
        FirebaseApp.configure()
        return true
    }

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        ApplicationDelegate.shared.application(
            app,
            open: url,
            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
        )
        return GIDSignIn.sharedInstance().handle(url)
    }
    
    var indicator = UIActivityIndicatorView()
    
    func addIndicator(){
        indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50)) as UIActivityIndicatorView
         //  indicator.hidesWhenStopped = true
        indicator.style = UIActivityIndicatorView.Style.whiteLarge
        indicator.backgroundColor = .black
        indicator.alpha = 1.00
     }
    
    func showIndicator(){
    //show the Indicator
        indicator.startAnimating()
        window?.addSubview(indicator)

    }
     
    func hideIndicator(){
        //Hide the Indicator
        indicator.stopAnimating()
        indicator.removeFromSuperview()
    }
    
    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
    
//    func application(
//      _ application: UIApplication,
//      didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
//    ) {
//      let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
//      let token = tokenParts.joined()
//      print("Device Token: \(token)")
//    }
    
//    func application(
//      _ application: UIApplication,
//      didFailToRegisterForRemoteNotificationsWithError error: Error
//    ) {
//      print("Failed to register: \(error)")
//    }
}

