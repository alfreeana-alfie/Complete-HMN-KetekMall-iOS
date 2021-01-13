

import UIKit

class MoreDetailsViewController: UIViewController, UITabBarDelegate {

    var BRAND: String = ""
    var INNER: String = ""
    var STOCK: String = ""
    var DESC: String = ""
    var DIVISION: String = ""
    var DISTRICT: String = ""
    
    @IBOutlet weak var BrandMaterial: UILabel!
    @IBOutlet weak var InnerMaterial: UILabel!
    @IBOutlet weak var Stock: UILabel!
    @IBOutlet weak var ShipsFrom: UILabel!
    @IBOutlet weak var Description: UITextView!
    @IBOutlet weak var Tabbar: UITabBar!
    
    @IBOutlet weak var BrandLabel: UILabel!
    @IBOutlet weak var InnerLabel: UILabel!
    @IBOutlet weak var StockLabel: UILabel!
    @IBOutlet weak var ShipFromLabel: UILabel!
    @IBOutlet weak var DescriptionLabel: UILabel!
    let sharedPref = UserDefaults.standard
    var lang: String = ""

    var viewController1: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lang = sharedPref.string(forKey: "LANG") ?? "0"
        if(lang == "ms"){
            changeLanguage(str: "ms")
            
        }else{
            changeLanguage(str: "en")
            
        }
        
        Tabbar.delegate = self
        
        BrandMaterial.text! = BRAND
        InnerMaterial.text! = INNER
        Stock.text! = STOCK
        ShipsFrom.text! = DIVISION + "," + DISTRICT
        Description.text! = DESC
    }
    
    func changeLanguage(str: String){
        BrandLabel.text = "BRAND MATERIAL".localized(lang: str)
        InnerLabel.text = "INNER MATERIAL".localized(lang: str)

        StockLabel.text = "STOCK".localized(lang: str)
        
        ShipFromLabel.text = "SHIPS FROM".localized(lang: str)
        DescriptionLabel.text = "DESCRIPTION".localized(lang: str)
        
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
    
    func presentMethod(storyBoardName: String, storyBoardID: String) {
        let storyBoard: UIStoryboard = UIStoryboard(name: storyBoardName, bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: storyBoardID)
        self.definesPresentationContext = true
        self.present(newViewController, animated: true, completion: nil)
    }
}
