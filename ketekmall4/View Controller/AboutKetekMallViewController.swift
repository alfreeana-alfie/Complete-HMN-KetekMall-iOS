import UIKit

class AboutKetekMallViewController: UIViewController, UITabBarDelegate {
    
    @IBOutlet weak var ButtonRefund: UIButton!
    @IBOutlet weak var ButtonTerms: UIButton!
    @IBOutlet weak var ButtonDelivery: UIButton!
    @IBOutlet weak var ButtonContact: UIButton!
    @IBOutlet weak var Tabbar: UITabBar!
    @IBOutlet weak var AppVersion: UIButton!
    
    var viewController1: UIViewController?
    
    let sharedPref = UserDefaults.standard
    var lang: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Tabbar.delegate = self
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

    @IBAction func GotoRefund(_ sender: Any) {
        let accountsettings = self.storyboard!.instantiateViewController(withIdentifier: "ReturnRefundPolicyViewController") as! ReturnRefundPolicyViewController
        if let navigator = self.navigationController {
            navigator.pushViewController(accountsettings, animated: true)
        }
    }
    
    @IBAction func ButtonAppVersion(_ sender: Any) {
        let accountsettings = self.storyboard!.instantiateViewController(withIdentifier: "AppVersionViewController") as! AppVersionViewController
        if let navigator = self.navigationController {
            navigator.pushViewController(accountsettings, animated: true)
        }
    }
    
    
    @IBAction func ButtonDelivery(_ sender: Any) {
        let accountsettings = self.storyboard!.instantiateViewController(withIdentifier: "DeliveryPolicyViewController") as! DeliveryPolicyViewController
        if let navigator = self.navigationController {
            navigator.pushViewController(accountsettings, animated: true)
        }
    }
    
    @IBAction func ButtonContact(_ sender: Any) {
        let accountsettings = self.storyboard!.instantiateViewController(withIdentifier: "ContactUsViewController") as! ContactUsViewController
        if let navigator = self.navigationController {
            navigator.pushViewController(accountsettings, animated: true)
        }
    }
    
    @IBAction func ButtonTerms(_ sender: Any) {
        let accountsettings = self.storyboard!.instantiateViewController(withIdentifier: "TermsConditionsViewController") as! TermsConditionsViewController
        if let navigator = self.navigationController {
            navigator.pushViewController(accountsettings, animated: true)
        }
    }
}
