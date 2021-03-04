

import UIKit



class NotificationViewController: UIViewController, UITabBarDelegate {

    let URL_SEARCH_SHOCKING_SALE = "https://ketekmall.com/ketekmall/search/readall_shocking.php"
    let URL_FILTER_DIVISION_SHOCKING_SALE = "https://ketekmall.com/ketekmall/filter_division/readall_shocking.php"
    let URL_FILTER_DISTRICT_SHOCKING_SALE = "https://ketekmall.com/ketekmall/filter_district/readall_shocking.php"
    let URL_FILTER_SEARCH_DIVISION_SHOCKING_SALE = "https://ketekmall.com/ketekmall/filter_search_division/readall_shocking.php"
    let URL_PRICE_UP_SHOCKING_SALE = "https://ketekmall.com/ketekmall/price_up/readall_shocking.php"
    let URL_PRICE_DOWN_SHOCKING_SALE = "https://ketekmall.com/ketekmall/price_down/readall_shocking.php"
    let URL_READ_SHOCKING_SALE = "https://ketekmall.com/ketekmall/category/readall_shocking.php"
    
    let sharedPref = UserDefaults.standard
    var lang: String = ""
    var user: String = ""
    var viewController1: UIViewController?
    
    var CheckPage: Bool = false
    
    @IBOutlet weak var Tabbar: UITabBar!
    @IBOutlet weak var OrderUpdateBtn: UIButton!
    @IBOutlet weak var SocialUpdatesBtn: UIButton!
    @IBOutlet weak var PromotionBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Tabbar.delegate = self
        user = sharedPref.string(forKey: "USERID") ?? "0"
        lang = sharedPref.string(forKey: "LANG") ?? "0"
        if(lang == "ms"){
            changeLanguage(str: "ms")
        }else{
            changeLanguage(str: "en")
        }
        self.hideKeyboardWhenTappedAround()
        
    }

    @objc override func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
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
            if(user == "0"){
                let addProduct = self.storyboard!.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                if let navigator = self.navigationController {
                    navigator.pushViewController(addProduct, animated: true)
                }
            }else{
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                viewController1 = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                if let navigator = self.navigationController {
                    navigator.pushViewController(viewController1!, animated: true)
                }
            }
            break
            
        default:
            break
        }
    }
    
    func changeLanguage(str: String){
        
        Tabbar.items?[0].title = "Home".localized(lang: str)
        Tabbar.items?[1].title = "Notification".localized(lang: str)
        Tabbar.items?[2].title = "Me".localized(lang: str)

        OrderUpdateBtn.setTitle("Order Updates".localized(lang: str), for: .normal)
        SocialUpdatesBtn.setTitle("Social Updates".localized(lang: str), for: .normal)
        PromotionBtn.setTitle("Promotion".localized(lang: str), for: .normal)
    }

    
    @IBAction func OrderUpdates(_ sender: Any) {
        let myBuying = self.storyboard!.instantiateViewController(withIdentifier: "MyBuyingViewController") as! MyBuyingViewController
        myBuying.userID = String(user)
        if let navigator = self.navigationController {
            navigator.pushViewController(myBuying, animated: true)
        }
    }
    
    @IBAction func SocialUpdates(_ sender: Any) {
        let myBuying = self.storyboard!.instantiateViewController(withIdentifier: "ChatInboxTwoViewController") as! ChatInboxTwoViewController
        myBuying.BarHidden = true
        if let navigator = self.navigationController {
            navigator.pushViewController(myBuying, animated: true)
        }
    }
    
    @IBAction func Promotion(_ sender: Any) {
        let click = self.storyboard!.instantiateViewController(withIdentifier: "CategoryViewController") as! CategoryViewController
               click.UserID = String(user)
               click.URL_READ = URL_READ_SHOCKING_SALE
               click.URL_SEARCH = URL_SEARCH_SHOCKING_SALE
               click.URL_FILTER_DIVISION = URL_FILTER_DIVISION_SHOCKING_SALE
               click.URL_FILTER_DISTRICT = URL_FILTER_DISTRICT_SHOCKING_SALE
               click.URL_FILTER_SEARCH_DIVISION = URL_FILTER_SEARCH_DIVISION_SHOCKING_SALE
               click.URL_PRICE_UP_READALL = URL_PRICE_UP_SHOCKING_SALE
               click.URL_PRICE_DOWN = URL_PRICE_DOWN_SHOCKING_SALE
            click.CheckPage = CheckPage
               if let navigator = self.navigationController {
                   navigator.pushViewController(click, animated: true)
               }
    }
}
