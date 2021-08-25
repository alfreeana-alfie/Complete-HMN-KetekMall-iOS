

import UIKit
import Alamofire
import EasyNotificationBadge
import DropDown
import Firebase
import GoogleSignIn
import FBSDKLoginKit
import FBSDKCoreKit
import JGProgressHUD
import ImageSlideshow
import LanguageManager_iOS
import FirebaseInstanceID
import OneSignal

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, HotDelegate, ShockingDelegate, UITabBarDelegate {
    func onAddToCart(cell: HotCollectionViewCell) {
        if(user == "0"){
            let addProduct = self.storyboard!.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            if let navigator = self.navigationController {
                navigator.pushViewController(addProduct, animated: true)
            }
        }else{
            let spinner = JGProgressHUD(style: .dark)
            guard let indexPath = self.HotView.indexPath(for: cell) else{
                return
            }

            if(POSTCODEHOT[indexPath.row].contains("0")){
                POSTCODEHOT[indexPath.row] = "93050"
            }
            
            if(WEIGHTHOT[indexPath.row].contains("0.00")){
                WEIGHTHOT[indexPath.row] = "1.00"
            }
            
            let parameters: Parameters=[
                "seller_id": SELLERIDHOT[indexPath.row],
                "item_id": ID[indexPath.row],
                "customer_id": user,
                "main_category": MAINCATEHOT[indexPath.row],
                "sub_category": SUBCATEHOT[indexPath.row],
                "ad_detail": ADDETAILHOT[indexPath.row],
                "price": PRICEHOT[indexPath.row],
                "quantity": "1",
                "division": DIVISIONHOT[indexPath.row],
                "postcode": POSTCODEHOT[indexPath.row],
                "district": DISTRICTHOT[indexPath.row],
                "photo": PHOTOHOT[indexPath.row],
                "weight": WEIGHTHOT[indexPath.row]
            ]
            
            if(SELLERIDHOT[indexPath.row] == userID){
                let spinner = JGProgressHUD(style: .dark)

                spinner.indicatorView = JGProgressHUDSuccessIndicatorView()
                if(self.lang == "ms"){
                    spinner.textLabel.text = "Sorry, cannot add your own item".localized(lang: "ms")
                }else{
                    spinner.textLabel.text = "Sorry, cannot add your own item".localized(lang: "en")
                }
                    spinner.show(in: self.view)
                    spinner.dismiss(afterDelay: 3.0)
                
            }else{
                //Sending http post request
                Alamofire.request(URL_ADD_CART, method: .post, parameters: parameters).responseJSON
                    {
                        response in
                        if let result = response.result.value {
                            let jsonData = result as! NSDictionary
                            spinner.indicatorView = JGProgressHUDSuccessIndicatorView()
                            spinner.textLabel.text = "Added to Cart"
                            if(self.lang == "ms"){
                                spinner.textLabel.text = "Added to Cart".localized(lang: "ms")
                                
                            }else{
                                spinner.textLabel.text = "Added to Cart"
                               
                            }
                            spinner.show(in: self.view)
                            spinner.dismiss(afterDelay: 3.0)
                            print(jsonData.value(forKey: "message")!)
                            
                        }
                }
            }
        }
        
    }
    
    func onAddToCart1(cell: ShockingSaleCollectionViewCell) {
        if(user == "0"){
            let addProduct = self.storyboard!.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            if let navigator = self.navigationController {
                navigator.pushViewController(addProduct, animated: true)
            }
        }else{
            let spinner = JGProgressHUD(style: .dark)
            guard let indexPath = self.ShockingView.indexPath(for: cell) else{
                return
            }

            if(POSTCODESHOCKING[indexPath.row].contains("0")){
                POSTCODESHOCKING[indexPath.row] = "93050"
            }
            
            if(WEIGHTSHOCKING[indexPath.row].contains("0.00")){
                WEIGHTSHOCKING[indexPath.row] = "1.00"
            }
            
            let parameters: Parameters=[
                "seller_id": SELLERIDSHOCKING[indexPath.row],
                "item_id": ID1[indexPath.row],
                "customer_id": user,
                "main_category": MAINCATESHOCKING[indexPath.row],
                "sub_category": SUBCATESHOCKING[indexPath.row],
                "ad_detail": ADDETAILSHOCKING[indexPath.row],
                "price": PRICESHOCKING[indexPath.row],
                "quantity": "1",
                "division": DIVISIONSHOCKING[indexPath.row],
                "postcode": POSTCODESHOCKING[indexPath.row],
                "district": DISTRICTSHOCKING[indexPath.row],
                "photo": PHOTOSHOCKING[indexPath.row],
                "weight": WEIGHTSHOCKING[indexPath.row]
            ]
            
            if(SELLERIDSHOCKING[indexPath.row] == userID){
                let spinner = JGProgressHUD(style: .dark)

                spinner.indicatorView = JGProgressHUDSuccessIndicatorView()
                if(self.lang == "ms"){
                    spinner.textLabel.text = "Sorry, cannot add your own item".localized(lang: "ms")
                }else{
                    spinner.textLabel.text = "Sorry, cannot add your own item".localized(lang: "en")
                }
                    spinner.show(in: self.view)
                    spinner.dismiss(afterDelay: 3.0)
                
            }else{
                //Sending http post request
                Alamofire.request(URL_ADD_CART, method: .post, parameters: parameters).responseJSON
                    {
                        response in
                        if let result = response.result.value {
                            let jsonData = result as! NSDictionary
                            spinner.indicatorView = JGProgressHUDSuccessIndicatorView()
                            spinner.textLabel.text = "Added to Cart"
                            if(self.lang == "ms"){
                                spinner.textLabel.text = "Added to Cart".localized(lang: "ms")
                                
                            }else{
                                spinner.textLabel.text = "Added to Cart"
                               
                            }
                            spinner.show(in: self.view)
                            spinner.dismiss(afterDelay: 3.0)
                            print(jsonData.value(forKey: "message")!)
                            
                        }
                }
            }
        }
        
    }
    
    @objc func onViewClick1(cell: ShockingSaleCollectionViewCell) {
        guard let indexPath = self.ShockingView.indexPath(for: cell) else{
            return
        }
        
        let viewProduct = self.storyboard!.instantiateViewController(withIdentifier: "ViewProductViewController") as! ViewProductViewController
        viewProduct.USERID = String(user)
        viewProduct.ItemID = self.ID1[indexPath.row]
        viewProduct.SELLERID = self.SELLERIDSHOCKING[indexPath.row]
        viewProduct.MAINCATE = self.MAINCATESHOCKING[indexPath.row]
        viewProduct.SUBCATE = self.SUBCATESHOCKING[indexPath.row]
        viewProduct.ADDETAIL = self.ADDETAILSHOCKING[indexPath.row]
        viewProduct.BRAND = self.BRANDSHOCKING[indexPath.row]
        viewProduct.INNER = self.INNERSHOCKING[indexPath.row]
        viewProduct.STOCK = self.STOCKSHOCKING[indexPath.row]
        viewProduct.DESC = self.DESCSHOCKING[indexPath.row]
        viewProduct.PRICE = self.PRICESHOCKING[indexPath.row]
        viewProduct.POSTCODE = self.POSTCODESHOCKING[indexPath.row]
        viewProduct.WEIGHT = self.WEIGHTSHOCKING[indexPath.row]
        viewProduct.PHOTO = self.PHOTOSHOCKING[indexPath.row]
        viewProduct.PHOTO02 = self.PHOTOSHOCKING02[indexPath.row]
        viewProduct.PHOTO03 = self.PHOTOSHOCKING03[indexPath.row]
        viewProduct.PHOTO04 = self.PHOTOSHOCKING04[indexPath.row]
        viewProduct.PHOTO05 = self.PHOTOSHOCKING05[indexPath.row]
        viewProduct.DIVISION = self.DIVISIONSHOCKING[indexPath.row]
        viewProduct.DISTRICT = self.DISTRICTSHOCKING[indexPath.row]
        if let navigator = self.navigationController {
            navigator.pushViewController(viewProduct, animated: true)
        }
    }
    
    @objc func onViewClick(cell: HotCollectionViewCell) {
        guard let indexPath = self.HotView.indexPath(for: cell) else{
            return
        }
        
        let viewProduct = self.storyboard!.instantiateViewController(withIdentifier: "ViewProductViewController") as! ViewProductViewController
        viewProduct.USERID = String(user)
        viewProduct.ItemID = self.ID[indexPath.row]
        viewProduct.SELLERID = self.SELLERIDHOT[indexPath.row]
        viewProduct.MAINCATE = self.MAINCATEHOT[indexPath.row]
        viewProduct.SUBCATE = self.SUBCATEHOT[indexPath.row]
        viewProduct.ADDETAIL = self.ADDETAILHOT[indexPath.row]
        viewProduct.BRAND = self.BRANDHOT[indexPath.row]
        viewProduct.INNER = self.INNERHOT[indexPath.row]
        viewProduct.STOCK = self.STOCKHOT[indexPath.row]
        viewProduct.DESC = self.DESCHOT[indexPath.row]
        viewProduct.PRICE = self.PRICEHOT[indexPath.row]
        viewProduct.POSTCODE = self.POSTCODEHOT[indexPath.row]
        viewProduct.WEIGHT = self.WEIGHTHOT[indexPath.row]
        viewProduct.PHOTO = self.PHOTOHOT[indexPath.row]
        viewProduct.PHOTO02 = self.PHOTOHOT02[indexPath.row]
        viewProduct.PHOTO03 = self.PHOTOHOT03[indexPath.row]
        viewProduct.PHOTO04 = self.PHOTOHOT04[indexPath.row]
        viewProduct.PHOTO05 = self.PHOTOHOT05[indexPath.row]
        viewProduct.DIVISION = self.DIVISIONHOT[indexPath.row]
        viewProduct.DISTRICT = self.DISTRICTHOT[indexPath.row]
        
//        print("HOTSELLING: " + self.PHOTOHOT[indexPath.row])
        if let navigator = self.navigationController {
            navigator.pushViewController(viewProduct, animated: true)
        }
    }
    
    private let spinner = JGProgressHUD(style: .dark)
    
    let URL_ADD_CART = "https://ketekmall.com/ketekmall/add_to_cart.php"
    let MAIN_PHOTO = "https://ketekmall.com/ketekmall/profile_image/main_photo.png"
    let URL_READ_CART = "https://ketekmall.com/ketekmall/readcart.php"
    let URL_READ = "https://ketekmall.com/ketekmall/read_detail.php"
    let URL_READ_HOT = "https://ketekmall.com/ketekmall/category/readall_sold.php"
    let URL_READ_SHOCKING_SALE = "https://ketekmall.com/ketekmall/category/readall_shocking.php"
    
    let URL_ADD_PLAYERID = "https://ketekmall.com/ketekmall/add_playerID.php"
    let URL_READ_CHAT = "https://ketekmall.com/ketekmall/read_chat.php"
    let URL_GETCHATALL = "https://ketekmall.com/ketekmall/getChatIsReadAll.php"
    
    let URL_READ_CATEGORY_MAIN = "https://ketekmall.com/ketekmall/category/"
    let URL_READ_CATEGORY_SEARCH_MAIN = "https://ketekmall.com/ketekmall/search/"
    let URL_READ_CATEGORY_FILTER_DISTRICT_MAIN = "https://ketekmall.com/ketekmall/filter_district/"
    let URL_READ_CATEGORY_FILTER_DIVISION_MAIN = "https://ketekmall.com/ketekmall/filter_division/"
    let URL_READ_CATEGORY_FILTER_SEARCH_MAIN = "https://ketekmall.com/ketekmall/filter_search_division/"
    let URL_READ_CATEGORY_PRICE_UP = "https://ketekmall.com/ketekmall/price_up/"
    let URL_READ_CATEGORY_PRICE_DOWN = "https://ketekmall.com/ketekmall/price_down/"
    
    let ONESIGNAL_APP_ID = "6236bfc3-df4d-4f44-82d6-754332044779"
    
    var CATEGORYLIST: [String] = ["read_cake.php",
                                  "read_process.php",
                                  "read_handicraft.php",
                                  "read_retail.php",
                                  "read_agri.php",
                                  "read_service.php",
                                  "read_health.php",
                                  "read_home.php",
                                  "read_fashion.php",
                                  "read_pepper.php",
                                  "readall.php",
                                  "readall_sold.php",
                                  "readall_shocking.php",
                                  "read_pickup.php"]
    
    @IBOutlet weak var ProcessFood: UIView!
    @IBOutlet weak var HealthBeauty: UIView!
    @IBOutlet weak var Handicraft: UIView!
    @IBOutlet weak var HomeLiving: UIView!
    @IBOutlet weak var SarawakBased: UIView!
    @IBOutlet weak var Fashion: UIView!
    
    @IBOutlet weak var HotView: UICollectionView!
    @IBOutlet weak var ShockingView: UICollectionView!
    @IBOutlet weak var UserImage: UIImageView!
    @IBOutlet weak var Username: UILabel!
    @IBOutlet weak var Verify: UILabel!
    @IBOutlet weak var Carousel: ImageSlideshow!
    @IBOutlet weak var CartViewNav: UIView!
    @IBOutlet weak var ChatViewNav: UIView!
    
    @IBOutlet weak var VerifyView: UIView!
    
    @IBOutlet weak var ButtonProcess: UITextView!
    @IBOutlet weak var ButtonHealth: UITextView!
    @IBOutlet weak var ButtonHandicraft: UITextView!
    @IBOutlet weak var ButtonHome: UITextView!
    @IBOutlet weak var ButtonSarawak: UITextView!
    @IBOutlet weak var ButtonFashion: UITextView!
    
    @IBOutlet weak var BrowseCate: UILabel!
    @IBOutlet weak var ShockingLabel: UILabel!
    @IBOutlet weak var HotLabel: UILabel!
    @IBOutlet weak var ViewAllButton: UIButton!
    @IBOutlet weak var ViewAllHot: UIButton!
    @IBOutlet weak var ViewAllShocking: UIButton!
    @IBOutlet weak var WelcomeLabel: UILabel!
    @IBOutlet weak var BuyLabel: UILabel!
    
    @IBOutlet weak var ListBar: UIImageView!
    @IBOutlet weak var CartBar: UIImageView!
    @IBOutlet weak var FindBar: UIImageView!
    @IBOutlet weak var SellButton: UIButton!
    @IBOutlet weak var FindButton: UIButton!
    
    // Hot Sale
    var ID: [String] = []
    var SELLERIDHOT: [String] = []
    var MAINCATEHOT: [String] = []
    var SUBCATEHOT: [String] = []
    var ADDETAILHOT: [String] = []
    var BRANDHOT: [String] = []
    var INNERHOT: [String] = []
    var STOCKHOT: [String] = []
    var DESCHOT: [String] = []
    var PRICEHOT: [String] = []
    var RATINGHOT: [String] = []
    var PHOTOHOT: [String] = []
    var PHOTOHOT02: [String] = []
    var PHOTOHOT03: [String] = []
    var PHOTOHOT04: [String] = []
    var PHOTOHOT05: [String] = []
    var DIVISIONHOT: [String] = []
    var POSTCODEHOT: [String] = []
    var DISTRICTHOT: [String] = []
    var WEIGHTHOT: [String] = []
    
    // Shocking Sale
    var ID1: [String] = []
    var SELLERIDSHOCKING: [String] = []
    var MAINCATESHOCKING: [String] = []
    var SUBCATESHOCKING: [String] = []
    var ADDETAILSHOCKING: [String] = []
    var BRANDSHOCKING: [String] = []
    var INNERSHOCKING: [String] = []
    var STOCKSHOCKING: [String] = []
    var DESCSHOCKING: [String] = []
    var PRICESHOCKING: [String] = []
    var RATINGSHOCKING: [String] = []
    var PHOTOSHOCKING: [String] = []
    var PHOTOSHOCKING02: [String] = []
    var PHOTOSHOCKING03: [String] = []
    var PHOTOSHOCKING04: [String] = []
    var PHOTOSHOCKING05: [String] = []
    var DIVISIONSHOCKING: [String] = []
    var DISTRICTSHOCKING: [String] = []
    var POSTCODESHOCKING: [String] = []
    var WEIGHTSHOCKING: [String] = []
    
    var PROMOTION: String = ""
    
    var userID: String = ""
    var Cart_count: Int = 0
    let dropDown = DropDown()
    let sharedPref = UserDefaults.standard
    var user: String = ""
    var email: String = ""
    var CheckUser: Bool = true
    var viewController1: UIViewController?
    
    @IBOutlet weak var Tabbar: UITabBar!
    @IBOutlet weak var HomePageView: UIView!
    
    let sender = PushNotificationSender()
    var tokenUser: String = ""
    var lang: String = ""
    var CheckUSER: String = ""
    
    override func viewDidAppear(_ animated: Bool) {
        if(user == "0"){
            Verify.isHidden = true
            Username.isHidden = true
            VerifyView.isHidden = true
            UserImage.isHidden = true
        }
        ColorFunc()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Tabbar.delegate = self
        
        lang = sharedPref.string(forKey: "LANG") ?? "0"
        CheckUSER = sharedPref.string(forKey: "CheckUSER") ?? "true"
        print("\(CheckUSER)")
        if(lang == "ms"){
            changeLanguage(str: "ms")
            
        }else{
            changeLanguage(str: "en")
            
        }
        navigationController?.setNavigationBarHidden(true, animated: false)

//        Carousel.setImageInputs([
//            KingfisherSource(url: URL(string: "http://ketekmall.com/NewImage/K1.JPG")!),
//            KingfisherSource(url: URL(string: "http://ketekmall.com/NewImage/K2.JPG")!),
//            KingfisherSource(url: URL(string: "http://ketekmall.com/NewImage/K3.JPG")!)])
//        Carousel.slideshowInterval = 3.0
//        Carousel.contentScaleMode = .scaleAspectFill
        
        if(CheckUSER == "false"){
            user = "0"
            email = "0"
            Verify.isHidden = true
            Username.isHidden = true
            VerifyView.isHidden = true
        }else{
            Verify.isHidden = false
            Username.isHidden = false
            VerifyView.isHidden = false
            user = sharedPref.string(forKey: "USERID") ?? "0"
            email = sharedPref.string(forKey: "EMAIL") ?? "0"
        }
        
        let index = email.firstIndex(of: "@") ?? email.endIndex
        _ = email[..<index]
        
        dropDown.anchorView = ListBar
        dropDown.dataSource = ["Edit Profile","Change to BM","Change to ENG","About KetekMall", "Logout"]
        
        HotView.delegate = self
        HotView.dataSource = self
        
        ShockingView.delegate = self
        ShockingView.dataSource = self
        
        SellButton.layer.cornerRadius = 5
        FindButton.layer.cornerRadius = 5
        
        UserImage.layer.cornerRadius = UserImage.frame.width / 2
        UserImage.layer.masksToBounds = true
        VerifyView.layer.cornerRadius = 7
        
        ProcessFood.layer.cornerRadius = 10
        ProcessFood.layer.shadowOpacity = 1
        ProcessFood.layer.shadowOffset = .zero
        ProcessFood.layer.shadowRadius = 0.5
        
        HealthBeauty.layer.cornerRadius = 10
        HealthBeauty.layer.shadowOpacity = 1
        HealthBeauty.layer.shadowOffset = .zero
        HealthBeauty.layer.shadowRadius = 0.5

        Handicraft.layer.cornerRadius = 10
        Handicraft.layer.shadowOpacity = 1
        Handicraft.layer.shadowOffset = .zero
        Handicraft.layer.shadowRadius = 0.5

        HomeLiving.layer.cornerRadius = 10
        HomeLiving.layer.shadowOpacity = 1
        HomeLiving.layer.shadowOffset = .zero
        HomeLiving.layer.shadowRadius = 0.5
        
        SarawakBased.layer.cornerRadius = 10
        SarawakBased.layer.shadowOpacity = 1
        SarawakBased.layer.shadowOffset = .zero
        SarawakBased.layer.shadowRadius = 0.5
        
        Fashion.layer.cornerRadius = 10
        Fashion.layer.shadowOpacity = 1
        Fashion.layer.shadowOffset = .zero
        Fashion.layer.shadowRadius = 0.5
        
        ProcessFood.isUserInteractionEnabled = true
        HealthBeauty.isUserInteractionEnabled = true
        Handicraft.isUserInteractionEnabled = true
        HomeLiving.isUserInteractionEnabled = true
        SarawakBased.isUserInteractionEnabled = true
        Fashion.isUserInteractionEnabled = true
        FindBar.isUserInteractionEnabled = true
        CartBar.isUserInteractionEnabled = true
        ListBar.isUserInteractionEnabled = true
        
        let FindClick = UITapGestureRecognizer(target: self, action: #selector(onFindBarClick(sender:)))
        let CartClick = UITapGestureRecognizer(target: self, action: #selector(onCartBarClick(sender:)))
        let ListClick = UITapGestureRecognizer(target: self, action: #selector(onListClick(sender:)))

        let ProcessClick = UITapGestureRecognizer(target: self, action: #selector(onProcess(sender:)))
        let HealthClick = UITapGestureRecognizer(target: self, action: #selector(onHealth))
        let HandicraftClick = UITapGestureRecognizer(target: self, action: #selector(onHandicraft(sender:)))
        let HomeLivingClick = UITapGestureRecognizer(target: self, action: #selector(onHomeLiving(sender:)))
        let SarawakClick = UITapGestureRecognizer(target: self, action: #selector(onSarawakBased(sender:)))
        let FashionClick = UITapGestureRecognizer(target: self, action: #selector(onFashion(sender:)))
        
        FindBar.addGestureRecognizer(FindClick)
        CartBar.addGestureRecognizer(CartClick)
        ListBar.addGestureRecognizer(ListClick)
        ProcessFood.addGestureRecognizer(ProcessClick)
        HealthBeauty.addGestureRecognizer(HealthClick)
        Handicraft.addGestureRecognizer(HandicraftClick)
        HomeLiving.addGestureRecognizer(HomeLivingClick)
        SarawakBased.addGestureRecognizer(SarawakClick)
        Fashion.addGestureRecognizer(FashionClick)

        if(user != "0"){
            getUserDetails(userID: String(user))
            MessageCount03()
//            MessageCount02(EmailUser: String(newEmail))
            CartCount(UserID: String(user))
        }else{
            print("FAILED")
        }
        HotSelling()
        ShockingSale()
        ReadPromotion()
    }
    
    @objc override func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    func MessageCount03(){
        let parameters: Parameters=[
            "UserID": user
        ]
        
        Alamofire.request(URL_GETCHATALL, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value{
                    self.spinner.dismiss(afterDelay: 3.0)
                    let jsonData = result as! NSDictionary
                    
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        let user = jsonData.value(forKey: "read") as! NSArray
                        
                        if(user.count == 0){
                            
                        }else{
                            var badgeAppearance = BadgeAppearance()
                            badgeAppearance.backgroundColor = UIColor.red //default is red
                            badgeAppearance.textColor = UIColor.white // default is white
                            badgeAppearance.textAlignment = .center //default is center
//                            badgeAppearance.textSize = 10 //default is 12
                            badgeAppearance.distanceFromCenterX = 10 //default is 0
                            badgeAppearance.distanceFromCenterY = 1 //default is 0
                            badgeAppearance.allowShadow = false
                            badgeAppearance.borderColor = .red
                            badgeAppearance.borderWidth = 0
                            self.ChatViewNav.badge(text: String(user.count), appearance: badgeAppearance)
                        }
                    }
                }
        }
    }
    
    func MessageCount02(EmailUser: String){
        let parameters: Parameters=[
            "user_chatwith": EmailUser
        ]
        
        Alamofire.request(URL_READ_CHAT, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value{
                    self.spinner.dismiss(afterDelay: 3.0)
                    let jsonData = result as! NSDictionary
                    
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        let user = jsonData.value(forKey: "read") as! NSArray
                        
                        if(user.count == 0){
                            
                        }else{
                            var badgeAppearance = BadgeAppearance()
                            badgeAppearance.backgroundColor = UIColor.red //default is red
                            badgeAppearance.textColor = UIColor.white // default is white
                            badgeAppearance.textAlignment = .center //default is center
//                            badgeAppearance.textSize = 10 //default is 12
                            badgeAppearance.distanceFromCenterX = 10 //default is 0
                            badgeAppearance.distanceFromCenterY = 1 //default is 0
                            badgeAppearance.allowShadow = false
                            badgeAppearance.borderColor = .red
                            badgeAppearance.borderWidth = 0
                            self.ChatViewNav.badge(text: String(user.count), appearance: badgeAppearance)
                        }
                    }
                }
        }
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
    
    func ColorFunc(){
//        let colorViewOne = UIColor(hexString: "#FC4A1A").cgColor
//        let colorViewTwo = UIColor(hexString: "#F7B733").cgColor
//
//        let ViewGradient = CAGradientLayer()
//        ViewGradient.frame = self.view.bounds
//        ViewGradient.colors = [colorViewOne, colorViewTwo]
//        ViewGradient.startPoint = CGPoint(x: 0, y: 0.5)
//        ViewGradient.endPoint = CGPoint(x: 1, y: 0.5)
//        ViewGradient.cornerRadius = 16
//        self.view.layer.insertSublayer(ViewGradient, at: 0)
        
        let colorSellOne = UIColor(hexString: "#ED213A").cgColor
        let colorSellTwo = UIColor(hexString: "#93291E").cgColor
        
        let SellGradient = CAGradientLayer()
        SellGradient.frame = SellButton.bounds
        SellGradient.colors = [colorSellOne, colorSellTwo]
        SellGradient.startPoint = CGPoint(x: 0, y: 0.5)
        SellGradient.endPoint = CGPoint(x: 1, y: 0.5)
        SellGradient.cornerRadius = 7
        SellButton.layer.insertSublayer(SellGradient, at: 0)
        
        let colorFindOne = UIColor(hexString: "#0575E6").cgColor
        let colorFindTwo = UIColor(hexString: "#021B79").cgColor
        
        let FindGradient = CAGradientLayer()
        FindGradient.frame = FindButton.bounds
        FindGradient.colors = [colorFindOne, colorFindTwo]
        FindGradient.startPoint = CGPoint(x: 0, y: 0.5)
        FindGradient.endPoint = CGPoint(x: 1, y: 0.5)
        FindGradient.cornerRadius = 7
        FindButton.layer.insertSublayer(FindGradient, at: 0)
    }
    
    let URL_PROMOTION = "http://ketekmall.com/ketekmall/read_promotion.php";
    var PROMOTION_ARRY: [String] = []
    var PROMOTIONKING: [KingfisherSource] = []
    func ReadPromotion(){
        Alamofire.request(URL_PROMOTION, method: .post).responseJSON
            {
                response in
                if let result = response.result.value as? Dictionary<String,Any>{
                    if let list = result["read"] as? [Dictionary<String,Any>]{
                        for i in list{
                            self.PROMOTION = i["photo"] as! String
                            self.PROMOTIONKING.append(KingfisherSource(url: URL(string: self.PROMOTION)!))
                            
                            self.Carousel.setImageInputs(self.PROMOTIONKING)
                            self.Carousel.slideshowInterval = 3.0
                            self.Carousel.contentScaleMode = .scaleAspectFill

                            print("\(self.PROMOTIONKING)")
                        }
                    }
                    
                }
        }
    }
    
    @objc func onListClick(sender: Any){
        dropDown.show()
        dropDown.direction = .bottom
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            switch index{
            case 0:
                if(user == "0"){
                    let addProduct = self.storyboard!.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                    if let navigator = self.navigationController {
                        navigator.pushViewController(addProduct, animated: true)
                    }
                }else{
                    let accountsettings = self.storyboard!.instantiateViewController(withIdentifier: "AccountSettingsViewController") as! AccountSettingsViewController
                    accountsettings.userID = self.user
                    if let navigator = self.navigationController {
                        navigator.pushViewController(accountsettings, animated: true)
                    }
                }
                break
                
            case 1:
                self.changeLanguage(str: "ms")
                self.sharedPref.setValue("ms", forKey: "LANG")
                break
                
            case 2:
                self.changeLanguage(str: "en")
                self.sharedPref.setValue("en", forKey: "LANG")
                break
                
            case 3:
                let accountsettings = self.storyboard!.instantiateViewController(withIdentifier: "AboutKetekMallViewController") as! AboutKetekMallViewController
                if let navigator = self.navigationController {
                    navigator.pushViewController(accountsettings, animated: true)
                }
                break
                
            case 4:
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let click = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                click.CheckUser = false
                if let navigator = self.navigationController {
                    navigator.pushViewController(click, animated: true)
                }
                UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
                UserDefaults.standard.synchronize()
                self.sharedPref.setValue("false", forKey: "CheckUSER")

                GIDSignIn.sharedInstance()?.signOut()
                LoginManager().logOut()
                break
                
            default:
                break
            }
        }
        dropDown.width = 200
    }
    
    func NotificationSetup(){
        InstanceID.instanceID().instanceID { (result, error) in
            if let error = error {
                print("Error fetching remote instange ID: \(error)")
            } else if let result = result {
                print("Remote instance ID token: \(result.token)")
                self.tokenUser = result.token
                self.sender.sendPushNotification(to: result.token, title: "Notification title", body: "Notification body")
            }
        }
    }
    
    func changeLanguage(str: String){
        SellButton.setTitle("SELL".localized(lang: str), for: .normal)
        FindButton.setTitle("FIND".localized(lang: str), for: .normal)
        WelcomeLabel.text = "Welcome!".localized(lang: str)
        BuyLabel.text = "GREAT STORE.GREAT CHOICE".localized(lang: str)
        Verify.text = "VERIFICATION".localized(lang: str)
        if(Verify.text == "SELLER"){
            Verify.text = "SELLER".localized(lang: str)
        }else{
            Verify.text = "BUYER".localized(lang: str)
        }
        
        BrowseCate.text = "BROWSE CATEGORIES".localized(lang: str)
        HotLabel.text = "HOT SELLING".localized(lang: str)
        ShockingLabel.text = "SHOCKING SALE".localized(lang: str)
        
        ViewAllHot.setTitle("View".localized(lang: str), for: .normal)
        ViewAllButton.setTitle("View".localized(lang: str), for: .normal)
        ViewAllShocking.setTitle("View".localized(lang: str), for: .normal)
        
        ButtonProcess.text = "Process Food".localized(lang: str)
        ButtonFashion.text = "Fashion Accessories".localized(lang: str)
        ButtonHandicraft.text = "Handicraft".localized(lang: str)
        ButtonSarawak.text = "Sarawak Product".localized(lang: str)
        ButtonHealth.text = "Health and Beauty".localized(lang: str)
        ButtonHome.text = "Home and Living".localized(lang: str)
        
    
        Tabbar.items?[0].title = "Home".localized(lang: str)
        Tabbar.items?[1].title = "Notification".localized(lang: str)
        Tabbar.items?[2].title = "Me".localized(lang: str)
    }
    
    func InsertNotificationData(Name: String){
        let parameters: Parameters=[
            "PlayerID": OneSignal.getDeviceState()!.userId!,
            "Name": Name,
            "UserID": user
        ]
        
        Alamofire.request(URL_ADD_PLAYERID, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value{
                    print("ONESIGNAL SUCCESS")
                }else{
                    self.spinner.dismiss(afterDelay: 3.0)
                    print("FAILED")
                }
                
        }
    }
    
    @objc func onCartBarClick(sender: Any){
        if(user == "0"){
            let addProduct = self.storyboard!.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            if let navigator = self.navigationController {
                navigator.pushViewController(addProduct, animated: true)
            }
        }else{
            let click = self.storyboard!.instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
            click.userID = String(user)
            if let navigator = self.navigationController {
                navigator.pushViewController(click, animated: true)
            }
        }
    }
    
    @IBAction func ViewAllCate(_ sender: Any) {
//        let tabbar = tabBarController as! BaseTabBarController
        let click = self.storyboard!.instantiateViewController(withIdentifier: "CategoryViewController") as! CategoryViewController
        click.UserID = String(user)
        click.URL_READ = URL_READ_CATEGORY_MAIN + CATEGORYLIST[10]
        click.URL_SEARCH = URL_READ_CATEGORY_SEARCH_MAIN + CATEGORYLIST[10]
        click.URL_FILTER_DIVISION = URL_READ_CATEGORY_FILTER_DIVISION_MAIN + CATEGORYLIST[10]
        click.URL_FILTER_DISTRICT = URL_READ_CATEGORY_FILTER_DISTRICT_MAIN + CATEGORYLIST[10]
        click.URL_FILTER_SEARCH_DIVISION = URL_READ_CATEGORY_FILTER_SEARCH_MAIN + CATEGORYLIST[10]
        click.URL_PRICE_UP_READALL = URL_READ_CATEGORY_PRICE_UP + CATEGORYLIST[10]
        click.URL_PRICE_DOWN = URL_READ_CATEGORY_PRICE_DOWN + CATEGORYLIST[10]
        if let navigator = self.navigationController {
            navigator.pushViewController(click, animated: true)
        }
    }
    
    @IBAction func ViewAllHot(_ sender: Any) {
//        let tabbar = tabBarController as! BaseTabBarController
        let click = self.storyboard!.instantiateViewController(withIdentifier: "CategoryViewController") as! CategoryViewController
        click.UserID = String(user)
        click.URL_READ = URL_READ_CATEGORY_MAIN + CATEGORYLIST[11]
        click.URL_SEARCH = URL_READ_CATEGORY_SEARCH_MAIN + CATEGORYLIST[11]
        click.URL_FILTER_DIVISION = URL_READ_CATEGORY_FILTER_DIVISION_MAIN + CATEGORYLIST[11]
        click.URL_FILTER_DISTRICT = URL_READ_CATEGORY_FILTER_DISTRICT_MAIN + CATEGORYLIST[11]
        click.URL_FILTER_SEARCH_DIVISION = URL_READ_CATEGORY_FILTER_SEARCH_MAIN + CATEGORYLIST[11]
        click.URL_PRICE_UP_READALL = URL_READ_CATEGORY_PRICE_UP + CATEGORYLIST[11]
        click.URL_PRICE_DOWN = URL_READ_CATEGORY_PRICE_DOWN + CATEGORYLIST[11]
        if let navigator = self.navigationController {
            navigator.pushViewController(click, animated: true)
        }
    }
    
    @IBAction func ViewAllShockingSale(_ sender: Any) {
//        let tabbar = tabBarController as! BaseTabBarController
        let click = self.storyboard!.instantiateViewController(withIdentifier: "CategoryViewController") as! CategoryViewController
        click.UserID = String(user)
        click.URL_READ = URL_READ_CATEGORY_MAIN + CATEGORYLIST[12]
        click.URL_SEARCH = URL_READ_CATEGORY_SEARCH_MAIN + CATEGORYLIST[12]
        click.URL_FILTER_DIVISION = URL_READ_CATEGORY_FILTER_DIVISION_MAIN + CATEGORYLIST[12]
        click.URL_FILTER_DISTRICT = URL_READ_CATEGORY_FILTER_DISTRICT_MAIN + CATEGORYLIST[12]
        click.URL_FILTER_SEARCH_DIVISION = URL_READ_CATEGORY_FILTER_SEARCH_MAIN + CATEGORYLIST[12]
        click.URL_PRICE_UP_READALL = URL_READ_CATEGORY_PRICE_UP + CATEGORYLIST[12]
        click.URL_PRICE_DOWN = URL_READ_CATEGORY_PRICE_DOWN + CATEGORYLIST[12]
        if let navigator = self.navigationController {
            navigator.pushViewController(click, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func Sell(_ sender: Any) {
        if(user == "0"){
            let addProduct = self.storyboard!.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            if let navigator = self.navigationController {
                navigator.pushViewController(addProduct, animated: true)
            }
        }else{
            //        let tabbar = tabBarController as! BaseTabBarController
            let parameters: Parameters=[
                "id": String(user)
            ]
            
            Alamofire.request(URL_READ, method: .post, parameters: parameters).responseJSON
                {
                    response in
                    if let result = response.result.value{
                        let jsonData = result as! NSDictionary
                        
                        if((jsonData.value(forKey: "success") as! NSString).boolValue){
                            let user = jsonData.value(forKey: "read") as! NSArray
                            
                            let name = user.value(forKey: "name") as! [String]
                            let verify = user.value(forKey: "verification") as! [String]
                            let Photo = user.value(forKey: "photo") as! [String]
                            
                            self.Username.text = name[0]
                            if verify[0] == "0" {
                                
                                let gotoRegister = self.storyboard!.instantiateViewController(withIdentifier: "GotoRegisterSellerViewController") as! GotoRegisterSellerViewController
                                gotoRegister.userID = self.user
                                if let navigator = self.navigationController {
                                    navigator.pushViewController(gotoRegister, animated: true)
                                }
                            }else{
                                let addProduct = self.storyboard!.instantiateViewController(withIdentifier: "AddNewProductViewController") as! AddNewProductViewController
                                addProduct.userID = self.user
                                if let navigator = self.navigationController {
                                    navigator.pushViewController(addProduct, animated: true)
                                }
                            }
                            
                            self.UserImage.setImageWith(URL(string: Photo[0])!)
                        }
                    }else{

                    }
                        print("FAILED")
                    }
                    
            }
        }
    @IBAction func Find(_ sender: Any) {
//        let tabbar = tabBarController as! BaseTabBarController
        let click = self.storyboard!.instantiateViewController(withIdentifier: "CategoryViewController") as! CategoryViewController
        click.UserID = String(user)
        click.URL_READ = URL_READ_CATEGORY_MAIN + CATEGORYLIST[10]
        click.URL_SEARCH = URL_READ_CATEGORY_SEARCH_MAIN + CATEGORYLIST[10]
        click.URL_FILTER_DIVISION = URL_READ_CATEGORY_FILTER_DIVISION_MAIN + CATEGORYLIST[10]
        click.URL_FILTER_DISTRICT = URL_READ_CATEGORY_FILTER_DISTRICT_MAIN + CATEGORYLIST[10]
        click.URL_FILTER_SEARCH_DIVISION = URL_READ_CATEGORY_FILTER_SEARCH_MAIN + CATEGORYLIST[10]
        click.URL_PRICE_UP_READALL = URL_READ_CATEGORY_PRICE_UP + CATEGORYLIST[10]
        click.URL_PRICE_DOWN = URL_READ_CATEGORY_PRICE_DOWN + CATEGORYLIST[10]
        if let navigator = self.navigationController {
            navigator.pushViewController(click, animated: true)
        }
    }
    
    @objc func onFindBarClick(sender: Any){
        if(user == "0"){
            let addProduct = self.storyboard!.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            if let navigator = self.navigationController {
                navigator.pushViewController(addProduct, animated: true)
            }
        }else{
            let myBuying = self.storyboard!.instantiateViewController(withIdentifier: "ChatInboxTwoViewController") as! ChatInboxTwoViewController
            myBuying.BarHidden = true
            if let navigator = self.navigationController {
                navigator.pushViewController(myBuying, animated: true)
            }
        }
    }
    
    @objc func onProcess(sender: Any){
        print("Success")
//        let tabbar = tabBarController as! BaseTabBarController
        let click = self.storyboard!.instantiateViewController(withIdentifier: "CategoryViewController") as! CategoryViewController
        click.UserID = String(user)
        click.URL_READ = URL_READ_CATEGORY_MAIN + CATEGORYLIST[1]
        click.URL_SEARCH = URL_READ_CATEGORY_SEARCH_MAIN + CATEGORYLIST[1]
        click.URL_FILTER_DIVISION = URL_READ_CATEGORY_FILTER_DIVISION_MAIN + CATEGORYLIST[1]
        click.URL_FILTER_DISTRICT = URL_READ_CATEGORY_FILTER_DISTRICT_MAIN + CATEGORYLIST[1]
        click.URL_FILTER_SEARCH_DIVISION = URL_READ_CATEGORY_FILTER_SEARCH_MAIN + CATEGORYLIST[1]
        click.URL_PRICE_UP_READALL = URL_READ_CATEGORY_PRICE_UP + CATEGORYLIST[1]
        click.URL_PRICE_DOWN = URL_READ_CATEGORY_PRICE_DOWN + CATEGORYLIST[1]
        if let navigator = self.navigationController {
            navigator.pushViewController(click, animated: true)
        }
    }
    @objc func onHealth(sender: Any){
        print("Success")
//        let tabbar = tabBarController as! BaseTabBarController
        let click = self.storyboard!.instantiateViewController(withIdentifier: "CategoryViewController") as! CategoryViewController
        click.UserID = String(user)
        click.URL_READ = URL_READ_CATEGORY_MAIN + CATEGORYLIST[6]
        click.URL_SEARCH = URL_READ_CATEGORY_SEARCH_MAIN + CATEGORYLIST[6]
        click.URL_FILTER_DIVISION = URL_READ_CATEGORY_FILTER_DIVISION_MAIN + CATEGORYLIST[6]
        click.URL_FILTER_DISTRICT = URL_READ_CATEGORY_FILTER_DISTRICT_MAIN + CATEGORYLIST[6]
        click.URL_FILTER_SEARCH_DIVISION = URL_READ_CATEGORY_FILTER_SEARCH_MAIN + CATEGORYLIST[6]
        click.URL_PRICE_UP_READALL = URL_READ_CATEGORY_PRICE_UP + CATEGORYLIST[6]
        click.URL_PRICE_DOWN = URL_READ_CATEGORY_PRICE_DOWN + CATEGORYLIST[6]
        if let navigator = self.navigationController {
            navigator.pushViewController(click, animated: true)
        }
    }
    @objc func onHandicraft(sender: Any){
        print("Success")
//        let tabbar = tabBarController as! BaseTabBarController
        let click = self.storyboard!.instantiateViewController(withIdentifier: "CategoryViewController") as! CategoryViewController
        click.UserID = String(user)
        click.URL_READ = URL_READ_CATEGORY_MAIN + CATEGORYLIST[2]
        click.URL_SEARCH = URL_READ_CATEGORY_SEARCH_MAIN + CATEGORYLIST[2]
        click.URL_FILTER_DIVISION = URL_READ_CATEGORY_FILTER_DIVISION_MAIN + CATEGORYLIST[2]
        click.URL_FILTER_DISTRICT = URL_READ_CATEGORY_FILTER_DISTRICT_MAIN + CATEGORYLIST[2]
        click.URL_FILTER_SEARCH_DIVISION = URL_READ_CATEGORY_FILTER_SEARCH_MAIN + CATEGORYLIST[2]
        click.URL_PRICE_UP_READALL = URL_READ_CATEGORY_PRICE_UP + CATEGORYLIST[2]
        click.URL_PRICE_DOWN = URL_READ_CATEGORY_PRICE_DOWN + CATEGORYLIST[2]
        if let navigator = self.navigationController {
            navigator.pushViewController(click, animated: true)
        }
    }
    @objc func onHomeLiving(sender: Any){
        print("Success")
//        let tabbar = tabBarController as! BaseTabBarController
        let click = self.storyboard!.instantiateViewController(withIdentifier: "CategoryViewController") as! CategoryViewController
        click.UserID = String(user)
        click.URL_READ = URL_READ_CATEGORY_MAIN + CATEGORYLIST[7]
        click.URL_SEARCH = URL_READ_CATEGORY_SEARCH_MAIN + CATEGORYLIST[7]
        click.URL_FILTER_DIVISION = URL_READ_CATEGORY_FILTER_DIVISION_MAIN + CATEGORYLIST[7]
        click.URL_FILTER_DISTRICT = URL_READ_CATEGORY_FILTER_DISTRICT_MAIN + CATEGORYLIST[7]
        click.URL_FILTER_SEARCH_DIVISION = URL_READ_CATEGORY_FILTER_SEARCH_MAIN + CATEGORYLIST[7]
        click.URL_PRICE_UP_READALL = URL_READ_CATEGORY_PRICE_UP + CATEGORYLIST[7]
        click.URL_PRICE_DOWN = URL_READ_CATEGORY_PRICE_DOWN + CATEGORYLIST[7]
        if let navigator = self.navigationController {
            navigator.pushViewController(click, animated: true)
        }
    }
    @objc func onSarawakBased(sender: Any){
        print("Success")
//        let tabbar = tabBarController as! BaseTabBarController
        let click = self.storyboard!.instantiateViewController(withIdentifier: "CategoryViewController") as! CategoryViewController
        click.UserID = String(user)
        click.URL_READ = URL_READ_CATEGORY_MAIN + CATEGORYLIST[9]
        click.URL_SEARCH = URL_READ_CATEGORY_SEARCH_MAIN + CATEGORYLIST[9]
        click.URL_FILTER_DIVISION = URL_READ_CATEGORY_FILTER_DIVISION_MAIN + CATEGORYLIST[9]
        click.URL_FILTER_DISTRICT = URL_READ_CATEGORY_FILTER_DISTRICT_MAIN + CATEGORYLIST[9]
        click.URL_FILTER_SEARCH_DIVISION = URL_READ_CATEGORY_FILTER_SEARCH_MAIN + CATEGORYLIST[9]
        click.URL_PRICE_UP_READALL = URL_READ_CATEGORY_PRICE_UP + CATEGORYLIST[9]
        click.URL_PRICE_DOWN = URL_READ_CATEGORY_PRICE_DOWN + CATEGORYLIST[9]
        if let navigator = self.navigationController {
            navigator.pushViewController(click, animated: true)
        }
    }
    @objc func onFashion(sender: Any){
        print("Success")
//        let tabbar = tabBarController as! BaseTabBarController
        let click = self.storyboard!.instantiateViewController(withIdentifier: "CategoryViewController") as! CategoryViewController
        click.UserID = String(user)
        click.URL_READ = URL_READ_CATEGORY_MAIN + CATEGORYLIST[8]
        click.URL_SEARCH = URL_READ_CATEGORY_SEARCH_MAIN + CATEGORYLIST[8]
        click.URL_FILTER_DIVISION = URL_READ_CATEGORY_FILTER_DIVISION_MAIN + CATEGORYLIST[8]
        click.URL_FILTER_DISTRICT = URL_READ_CATEGORY_FILTER_DISTRICT_MAIN + CATEGORYLIST[8]
        click.URL_FILTER_SEARCH_DIVISION = URL_READ_CATEGORY_FILTER_SEARCH_MAIN + CATEGORYLIST[8]
        click.URL_PRICE_UP_READALL = URL_READ_CATEGORY_PRICE_UP + CATEGORYLIST[8]
        click.URL_PRICE_DOWN = URL_READ_CATEGORY_PRICE_DOWN + CATEGORYLIST[8]
        if let navigator = self.navigationController {
            navigator.pushViewController(click, animated: true)
        }
    }
    
    func getUserDetails(userID: String){
        spinner.show(in: self.view)
        let parameters: Parameters=[
            "id": userID
        ]
        
        Alamofire.request(URL_READ, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        self.spinner.dismiss(afterDelay: 3.0)
                        let user = jsonData.value(forKey: "read") as! NSArray
                        
                        let name = user.value(forKey: "name") as! [String]
                        let verify = user.value(forKey: "verification") as! [String]
                        let Photo = user.value(forKey: "photo") as! [String]
                        
                        self.Username.text = name[0]
                        if verify[0] == "1" {
                            self.Verify.text = "SELLER"
                            
                        }else{
                            self.Verify.text = "BUYER"
                        }
                        
                        self.UserImage.setImageWith(URL(string: Photo[0])!)
                        
                        self.InsertNotificationData(Name: name[0])
                    }
                }else{
                    self.spinner.dismiss(afterDelay: 3.0)
                    print("FAILED")
                }
                
        }
    }
    
    func HotSelling(){
        spinner.show(in: self.HotView)
        Alamofire.request(URL_READ_CATEGORY_MAIN + CATEGORYLIST[11], method: .post).responseJSON
            {
                response in
                if let result = response.result.value{
                    self.spinner.dismiss(afterDelay: 3.0)
                    let jsonData = result as! NSDictionary
                    
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        let user = jsonData.value(forKey: "read") as! NSArray
                        
                        let ItemID = user.value(forKey: "id") as! [String]
                        let seller_id = user.value(forKey: "user_id") as! [String]
                        let main_category = user.value(forKey: "main_category") as! [String]
                        let sub_category = user.value(forKey: "sub_category") as! [String]
                        let brand_material = user.value(forKey: "brand_material") as! [String]
                        let inner_material = user.value(forKey: "inner_material") as! [String]
                        let stock = user.value(forKey: "stock") as! [String]
                        let description = user.value(forKey: "description") as! [String]
                        let Ad_Detail = user.value(forKey: "ad_detail") as! [String]
                        let Price = user.value(forKey: "price") as! [String]
                        let rating = user.value(forKey: "rating") as! [String]
                        let Photo = user.value(forKey: "photo") as! [String]
                        let Photo02 = user.value(forKey: "photo02") as! [String]
                        let Photo03 = user.value(forKey: "photo03") as! [String]
                        let Photo04 = user.value(forKey: "photo04") as! [String]
                        let Photo05 = user.value(forKey: "photo05") as! [String]
                        
                        let division = user.value(forKey: "division") as! [String]
                        let district = user.value(forKey: "district") as! [String]
                        let postcode = user.value(forKey: "postcode") as? [String] ?? ["93050"]
                        let weight = user.value(forKey: "weight") as? [String] ?? ["1.00"]
                        
                        self.ID = ItemID
                        self.SELLERIDHOT = seller_id
                        self.MAINCATEHOT = main_category
                        self.SUBCATEHOT = sub_category
                        self.ADDETAILHOT = Ad_Detail
                        self.BRANDHOT = brand_material
                        self.INNERHOT = inner_material
                        self.STOCKHOT = stock
                        self.DESCHOT = description
                        self.PRICEHOT = Price
                        self.RATINGHOT = rating
                        self.PHOTOHOT = Photo
                        self.PHOTOHOT02 = Photo02
                        self.PHOTOHOT03 = Photo03
                        self.PHOTOHOT04 = Photo04
                        self.PHOTOHOT05 = Photo05
                        
                        self.DIVISIONHOT = division
                        self.DISTRICTHOT = district
                        self.POSTCODEHOT = postcode
                        self.WEIGHTHOT = weight
                                                
                        self.HotView.reloadData()
                        
                    }
                }
        }
    }
    
    func ShockingSale(){
        spinner.show(in: self.ShockingView)
            Alamofire.request(URL_READ_CATEGORY_MAIN + CATEGORYLIST[12], method: .post).responseJSON
                {
                    response in
                    self.spinner.dismiss(afterDelay: 3.0)
                    if let result = response.result.value{
                        let jsonData = result as! NSDictionary
                        
                        if((jsonData.value(forKey: "success") as! NSString).boolValue){
                            let user = jsonData.value(forKey: "read") as! NSArray
                            
                            let ItemID = user.value(forKey: "id") as! [String]
                            let seller_id = user.value(forKey: "user_id") as! [String]
                            let main_category = user.value(forKey: "main_category") as! [String]
                            let sub_category = user.value(forKey: "sub_category") as! [String]
                            let brand_material = user.value(forKey: "brand_material") as! [String]
                            let inner_material = user.value(forKey: "inner_material") as! [String]
                            let stock = user.value(forKey: "stock") as! [String]
                            let description = user.value(forKey: "description") as! [String]
                            let Ad_Detail = user.value(forKey: "ad_detail") as! [String]
                            let Price = user.value(forKey: "price") as! [String]
                            let rating = user.value(forKey: "rating") as! [String]
                            let Photo = user.value(forKey: "photo") as! [String]
                            let Photo02 = user.value(forKey: "photo02") as! [String]
                            let Photo03 = user.value(forKey: "photo03") as! [String]
                            let Photo04 = user.value(forKey: "photo04") as! [String]
                            let Photo05 = user.value(forKey: "photo05") as! [String]
                            let division = user.value(forKey: "division") as! [String]
                            let district = user.value(forKey: "district") as! [String]
                            let postcode = user.value(forKey: "postcode") as? [String] ?? ["93050"]
                            let weight = user.value(forKey: "weight") as? [String] ?? ["1.00"]
                            
                            self.ID1 = ItemID
                            self.SELLERIDSHOCKING = seller_id
                            self.MAINCATESHOCKING = main_category
                            self.SUBCATESHOCKING = sub_category
                            self.ADDETAILSHOCKING = Ad_Detail
                            self.BRANDSHOCKING = brand_material
                            self.INNERSHOCKING = inner_material
                            self.STOCKSHOCKING = stock
                            self.DESCSHOCKING = description
                            self.PRICESHOCKING = Price
                            self.RATINGSHOCKING = rating
                            self.PHOTOSHOCKING = Photo
                            self.PHOTOSHOCKING02 = Photo02
                            self.PHOTOSHOCKING03 = Photo03
                            self.PHOTOSHOCKING04 = Photo04
                            self.PHOTOSHOCKING05 = Photo05
                            self.DIVISIONSHOCKING = division
                            self.DISTRICTSHOCKING = district
                            self.POSTCODESHOCKING = postcode
                            self.WEIGHTSHOCKING = weight

                            self.ShockingView.reloadData()
                            
                        }
                    }
            }
        }
    
    func CartCount(UserID: String) {
        let parameters: Parameters=[
            "customer_id": UserID
        ]
        
        
        Alamofire.request(URL_READ_CART, method: .post, parameters: parameters).responseJSON
                    {
                        response in
                        if let result = response.result.value{
                            let jsonData = result as! NSDictionary
                            
                            if((jsonData.value(forKey: "success") as! NSString).boolValue){
                                let user = jsonData.value(forKey: "read") as! NSArray
                                
                                if(user.count == 0){
                                    
                                }else{
                                    let ItemID = user.value(forKey: "id") as! [String]
                                    
                                    self.ID1 = ItemID
                                    self.Cart_count = ItemID.count
                                    
                                    var badgeAppearance = BadgeAppearance()
                                    badgeAppearance.backgroundColor = UIColor.red //default is red
                                    badgeAppearance.textColor = UIColor.white // default is white
                                    badgeAppearance.textAlignment = .center //default is center
//                                    badgeAppearance.textSize = 10 //default is 12
                                    badgeAppearance.distanceFromCenterX = 10 //default is 0
                                    badgeAppearance.distanceFromCenterY = 1 //default is 0
                                    badgeAppearance.allowShadow = false
                                    badgeAppearance.borderColor = .red
                                    badgeAppearance.borderWidth = 0
                                    self.CartViewNav.badge(text: String(self.Cart_count), appearance: badgeAppearance)
                                }
                                
                            }
                        }
                }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.HotView{
            return ID.count
        }else{
            return PHOTOSHOCKING.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.HotView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HotCollectionViewCell", for: indexPath) as! HotCollectionViewCell
            
            if !self.PHOTOHOT[indexPath.row].contains("%20"){
                print("contain whitespace \(self.PHOTOHOT[indexPath.row].trimmingCharacters(in: .whitespaces))")
                let NEWIm = self.PHOTOHOT[indexPath.row].addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
                
                cell.ItemImage.setImageWith(URL(string: NEWIm!)!)
            }else{
                print("contain whitespace")
                
                cell.ItemImage.setImageWith(URL(string: self.PHOTOHOT[indexPath.row])!)
            }
            
            if let n = NumberFormatter().number(from: self.RATINGHOT[indexPath.row]) {
                let f = CGFloat(truncating: n)
                cell.Rating.value = f
            }
            cell.ItemName.text! = self.ADDETAILHOT[indexPath.row]
            cell.ItemPrice.text! = "RM" + self.PRICEHOT[indexPath.row]
            cell.ButtonView.layer.cornerRadius = 5
            if(lang == "ms"){
                cell.ButtonView.setTitle("ADD TO CART".localized(lang: "ms"), for: .normal)
            }else{
                cell.ButtonView.setTitle("ADD TO CART".localized(lang: "en"), for: .normal)
            }
            
            cell.layer.cornerRadius = 5
            cell.delegate = self
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShockingSaleCollectionViewCell", for: indexPath) as! ShockingSaleCollectionViewCell
            
            if !self.PHOTOSHOCKING[indexPath.row].contains("%20"){
                print("contain whitespace \(self.PHOTOSHOCKING[indexPath.row].trimmingCharacters(in: .whitespaces))")
                let NEWIm = self.PHOTOSHOCKING[indexPath.row].addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
                
                cell.ItemImage.setImageWith(URL(string: NEWIm!)!)
            }else{
                print("contain whitespace")
                
                cell.ItemImage.setImageWith(URL(string: self.PHOTOSHOCKING[indexPath.row])!)
            }
            
            if let n = NumberFormatter().number(from: self.RATINGSHOCKING[indexPath.row]) {
                let f = CGFloat(truncating: n)
                cell.Rating.value = f
            }
            cell.ItemName.text! = self.ADDETAILSHOCKING[indexPath.row]
            cell.ItemPrice.text! = "RM" + self.PRICESHOCKING[indexPath.row]
            cell.ButtonView.layer.cornerRadius = 5
            if(lang == "ms"){
                cell.ButtonView.setTitle("ADD TO CART".localized(lang: "ms"), for: .normal)
            }else{
                cell.ButtonView.setTitle("ADD TO CART".localized(lang: "en"), for: .normal)
            }
            
            cell.layer.cornerRadius = 5
            cell.delegate = self
            return cell
        }

    }
}


