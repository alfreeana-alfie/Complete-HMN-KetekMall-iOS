

import UIKit

class GotoRegisterSellerViewController: UIViewController, UITabBarDelegate {

    @IBOutlet weak var ButtonSeller: UIButton!
    @IBOutlet weak var BeforeLabel: UILabel!
    @IBOutlet weak var YouNeedLabel: UILabel!
    
    let sharedPref = UserDefaults.standard
    var lang: String = ""
    var userID: String = ""
    
    @IBOutlet weak var Tabbar: UITabBar!
    var viewController1: UIViewController?
    
    override func viewDidAppear(_ animated: Bool) {
        ColorFunc()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Tabbar.delegate = self
        ButtonSeller.layer.cornerRadius = 15
        
        lang = sharedPref.string(forKey: "LANG") ?? "0"
        if(lang == "ms"){
            changeLanguage(str: "ms")
            
        }else{
            changeLanguage(str: "en")
            
        }
        self.hideKeyboardWhenTappedAround()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil);
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
         self.view.frame.origin.y = -150 // Move view 150 points upward
    }

    @objc func keyboardWillHide(sender: NSNotification) {
         self.view.frame.origin.y = 0 // Move view to original position
    }
    
    @objc override func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }


    func ColorFunc(){
        let colorViewOne = UIColor(hexString: "#FC4A1A").cgColor
        let colorViewTwo = UIColor(hexString: "#F7B733").cgColor
        
        let ViewGradient = CAGradientLayer()
        ViewGradient.frame = ButtonSeller.bounds
        ViewGradient.colors = [colorViewOne, colorViewTwo]
        ViewGradient.startPoint = CGPoint(x: 0, y: 0.5)
        ViewGradient.endPoint = CGPoint(x: 1, y: 0.5)
        ViewGradient.cornerRadius = 15
        ButtonSeller.layer.insertSublayer(ViewGradient, at: 0)
    }
    
    func changeLanguage(str: String){
        ButtonSeller.setTitle("BECOME A SELLER TODAY!".localized(lang: str), for: .normal)
        BeforeLabel.text = "You need to register as KetekMall Seller".localized(lang: str)
        YouNeedLabel.text = "Before you can start selling your product, ".localized(lang: str)
        Tabbar.items?[0].title = "Home".localized(lang: str)
        Tabbar.items?[1].title = "Notification".localized(lang: str)
        Tabbar.items?[2].title = "Me".localized(lang: str)
    }

    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem){
        switch item.tag {
        case 1:
            navigationController?.setNavigationBarHidden(true, animated: false)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            viewController1 = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            if let navigator = self.navigationController {
                navigator.pushViewController(viewController1!, animated: true)
            }
            break
            
        case 2:
            navigationController?.setNavigationBarHidden(true, animated: false)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            viewController1 = storyboard.instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
            if let navigator = self.navigationController {
                navigator.pushViewController(viewController1!, animated: true)
            }
            break
            
        case 3:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            viewController1 = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            if let navigator = self.navigationController {
                navigator.pushViewController(viewController1!, animated: true)
            }
            break
            
        default:
            break
        }
    }
    
    @IBAction func GotoRegisterPage(_ sender: Any) {

        let RegisterSeller = self.storyboard!.instantiateViewController(withIdentifier: "BeforeRegisterViewController") as! BeforeRegisterViewController
//        RegisterSeller.UserID = userID
        if let navigator = self.navigationController {
            navigator.pushViewController(RegisterSeller, animated: true)
        }
    }
}
