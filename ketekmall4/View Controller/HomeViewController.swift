//
//  HomeViewController.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 27/08/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit
import Alamofire
import EasyNotificationBadge

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, HotDelegate, ShockingDelegate{

    let MAIN_PHOTO = "https://ketekmall.com/ketekmall/profile_image/main_photo.png"
    let URL_READ_CART = "https://ketekmall.com/ketekmall/readcart.php"
    let URL_READ = "https://ketekmall.com/ketekmall/read_detail.php"
    let URL_READ_HOT = "https://ketekmall.com/ketekmall/category/readall_sold.php"
    let URL_READ_SHOCKING_SALE = "https://ketekmall.com/ketekmall/category/readall_shocking.php"
    
    let URL_READ_CAKE = "https://ketekmall.com/ketekmall/category/read_cake.php"
    let URL_READ_PROCESS = "https://ketekmall.com/ketekmall/category/read_process.php"
    let URL_READ_HEALTH = "https://ketekmall.com/ketekmall/category/read_health.php"
    let URL_READ_HANDICRAFT = "https://ketekmall.com/ketekmall/category/read_handicraft.php"
    let URL_READ_HOMELIVING = "https://ketekmall.com/ketekmall/category/read_home.php"
    let URL_READ_RETAIL = "https://ketekmall.com/ketekmall/category/read_retail.php"
    let URL_READ_AGRICULTURE = "https://ketekmall.com/ketekmall/category/read_agri.php"
    let URL_READ_SARAWAKBASED = "https://ketekmall.com/ketekmall/category/read_pepper.php"
    let URL_READ_SERVICE = "https://ketekmall.com/ketekmall/category/read_service.php"
    let URL_READ_FASHION = "https://ketekmall.com/ketekmall/category/read_fashion.php"
    let URL_READ_VIEWALL = "https://ketekmall.com/ketekmall/category/readall.php"
    
    let URL_SEARCH_CAKE = "https://ketekmall.com/ketekmall/search/read_cake.php"
    let URL_SEARCH_PROCESS = "https://ketekmall.com/ketekmall/search/read_process.php"
    let URL_SEARCH_HEALTH = "https://ketekmall.com/ketekmall/search/read_health.php"
    let URL_SEARCH_HANDICRAFT = "https://ketekmall.com/ketekmall/search/read_handicraft.php"
    let URL_SEARCH_HOMELIVING = "https://ketekmall.com/ketekmall/search/read_home.php"
    let URL_SEARCH_RETAIL = "https://ketekmall.com/ketekmall/search/read_retail.php"
    let URL_SEARCH_AGRICULTURE = "https://ketekmall.com/ketekmall/search/read_agri.php"
    let URL_SEARCH_SARAWAKBASED = "https://ketekmall.com/ketekmall/search/read_pepper.php"
    let URL_SEARCH_SERVICE = "https://ketekmall.com/ketekmall/search/read_service.php"
    let URL_SEARCH_FASHION = "https://ketekmall.com/ketekmall/search/read_fashion.php"
    let URL_SEARCH_VIEWALL = "https://ketekmall.com/ketekmall/search/readall.php"
    let URL_SEARCH_HOT = "https://ketekmall.com/ketekmall/search/readall_sold.php"
    let URL_SEARCH_SHOCKING_SALE = "https://ketekmall.com/ketekmall/search/readall_shocking.php"
    
    let URL_FILTER_DIVISION_CAKE = "https://ketekmall.com/ketekmall/filter_division/read_cake.php"
    let URL_FILTER_DIVISION_PROCESS = "https://ketekmall.com/ketekmall/filter_division/read_process.php"
    let URL_FILTER_DIVISION_HEALTH = "https://ketekmall.com/ketekmall/filter_division/read_health.php"
    let URL_FILTER_DIVISION_HANDICRAFT = "https://ketekmall.com/ketekmall/filter_division/read_handicraft.php"
    let URL_FILTER_DIVISION_HOMELIVING = "https://ketekmall.com/ketekmall/filter_division/read_home.php"
    let URL_FILTER_DIVISION_RETAIL = "https://ketekmall.com/ketekmall/filter_division/read_retail.php"
    let URL_FILTER_DIVISION_AGRICULTURE = "https://ketekmall.com/ketekmall/filter_division/read_agri.php"
    let URL_FILTER_DIVISION_SARAWAKBASED = "https://ketekmall.com/ketekmall/filter_division/read_pepper.php"
    let URL_FILTER_DIVISION_SERVICE = "https://ketekmall.com/ketekmall/filter_division/read_service.php"
    let URL_FILTER_DIVISION_FASHION = "https://ketekmall.com/ketekmall/filter_division/read_fashion.php"
    let URL_FILTER_DIVISION_VIEWALL = "https://ketekmall.com/ketekmall/filter_division/readall.php"
    let URL_FILTER_DIVISION_HOT = "https://ketekmall.com/ketekmall/filter_division/readall_sold.php"
    let URL_FILTER_DIVISION_SHOCKING_SALE = "https://ketekmall.com/ketekmall/filter_division/readall_shocking.php"
    
    let URL_FILTER_DISTRICT_CAKE = "https://ketekmall.com/ketekmall/filter_district/read_cake.php"
    let URL_FILTER_DISTRICT_PROCESS = "https://ketekmall.com/ketekmall/filter_district/read_process.php"
    let URL_FILTER_DISTRICT_HEALTH = "https://ketekmall.com/ketekmall/filter_district/read_health.php"
    let URL_FILTER_DISTRICT_HANDICRAFT = "https://ketekmall.com/ketekmall/filter_district/read_handicraft.php"
    let URL_FILTER_DISTRICT_HOMELIVING = "https://ketekmall.com/ketekmall/filter_district/read_home.php"
    let URL_FILTER_DISTRICT_RETAIL = "https://ketekmall.com/ketekmall/filter_district/read_retail.php"
    let URL_FILTER_DISTRICT_AGRICULTURE = "https://ketekmall.com/ketekmall/filter_district/read_agri.php"
    let URL_FILTER_DISTRICT_SARAWAKBASED = "https://ketekmall.com/ketekmall/filter_district/read_pepper.php"
    let URL_FILTER_DISTRICT_SERVICE = "https://ketekmall.com/ketekmall/filter_district/read_service.php"
    let URL_FILTER_DISTRICT_FASHION = "https://ketekmall.com/ketekmall/filter_district/read_fashion.php"
    let URL_FILTER_DISTRICT_VIEWALL = "https://ketekmall.com/ketekmall/filter_district/readall.php"
    let URL_FILTER_DISTRICT_HOT = "https://ketekmall.com/ketekmall/filter_district/readall_sold.php"
    let URL_FILTER_DISTRICT_SHOCKING_SALE = "https://ketekmall.com/ketekmall/filter_district/readall_shocking.php"
    
    let URL_FILTER_SEARCH_DIVISION_CAKE = "https://ketekmall.com/ketekmall/filter_search_division/read_cake.php"
    let URL_FILTER_SEARCH_DIVISION_PROCESS = "https://ketekmall.com/ketekmall/filter_search_division/read_process.php"
    let URL_FILTER_SEARCH_DIVISION_HEALTH = "https://ketekmall.com/ketekmall/filter_search_division/read_health.php"
    let URL_FILTER_SEARCH_DIVISION_HANDICRAFT = "https://ketekmall.com/ketekmall/filter_search_division/read_handicraft.php"
    let URL_FILTER_SEARCH_DIVISION_HOMELIVING = "https://ketekmall.com/ketekmall/filter_search_division/read_home.php"
    let URL_FILTER_SEARCH_DIVISION_RETAIL = "https://ketekmall.com/ketekmall/filter_search_division/read_retail.php"
    let URL_FILTER_SEARCH_DIVISION_AGRICULTURE = "https://ketekmall.com/ketekmall/filter_search_division/read_agri.php"
    let URL_FILTER_SEARCH_DIVISION_SARAWAKBASED = "https://ketekmall.com/ketekmall/filter_search_division/read_pepper.php"
    let URL_FILTER_SEARCH_DIVISION_SERVICE = "https://ketekmall.com/ketekmall/filter_search_division/read_service.php"
    let URL_FILTER_SEARCH_DIVISION_FASHION = "https://ketekmall.com/ketekmall/filter_search_division/read_fashion.php"
    let URL_FILTER_SEARCH_DIVISION_VIEWALL = "https://ketekmall.com/ketekmall/filter_search_division/readall.php"
    let URL_FILTER_SEARCH_DIVISION_HOT = "https://ketekmall.com/ketekmall/filter_search_division/readall_sold.php"
    let URL_FILTER_SEARCH_DIVISION_SHOCKING_SALE = "https://ketekmall.com/ketekmall/filter_search_division/readall_shocking.php"
    
    @IBOutlet weak var CakePastries: UIView!
    @IBOutlet weak var ProcessFood: UIView!
    @IBOutlet weak var HealthBeauty: UIView!
    @IBOutlet weak var Handicraft: UIView!
    @IBOutlet weak var HomeLiving: UIView!
    @IBOutlet weak var Retail: UIView!
    @IBOutlet weak var Agriculture: UIView!
    @IBOutlet weak var SarawakBased: UIView!
    @IBOutlet weak var Service: UIView!
    @IBOutlet weak var Fashion: UIView!
    @IBOutlet weak var HotView: UICollectionView!
    @IBOutlet weak var ShockingView: UICollectionView!
    @IBOutlet weak var UserImage: UIImageView!
    @IBOutlet weak var Username: UILabel!
    @IBOutlet weak var Verify: UILabel!
    
    @IBOutlet weak var ListBar: UIImageView!
    @IBOutlet weak var CartBar: UIImageView!
    @IBOutlet weak var FindBar: UIImageView!
    @IBOutlet weak var SellButton: UIButton!
    @IBOutlet weak var FindButton: UIButton!
    

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
    var PHOTOHOT: [String] = []
    var DIVISIONHOT: [String] = []
    var DISTRICTHOT: [String] = []
    
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
    var PHOTOSHOCKING: [String] = []
    var DIVISIONSHOCKING: [String] = []
    var DISTRICTSHOCKING: [String] = []
    
    var userID: String = ""
    var Cart_count: Int = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        HotView.delegate = self
        HotView.dataSource = self
        
        ShockingView.delegate = self
        ShockingView.dataSource = self
        
        SellButton.layer.cornerRadius = 5
        FindButton.layer.cornerRadius = 5
        
        UserImage.layer.cornerRadius = UserImage.frame.width / 2
        UserImage.layer.masksToBounds = true
        Verify.layer.cornerRadius = 2
        
        CakePastries.layer.cornerRadius = 10
        CakePastries.layer.shadowOpacity = 1
        CakePastries.layer.shadowOffset = .zero
        CakePastries.layer.shadowRadius = 0.5
        
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
        
        Retail.layer.cornerRadius = 10
        Retail.layer.shadowOpacity = 1
        Retail.layer.shadowOffset = .zero
        Retail.layer.shadowRadius = 0.5
        
        Agriculture.layer.cornerRadius = 10
        Agriculture.layer.shadowOpacity = 1
        Agriculture.layer.shadowOffset = .zero
        Agriculture.layer.shadowRadius = 0.5
        
        SarawakBased.layer.cornerRadius = 10
        SarawakBased.layer.shadowOpacity = 1
        SarawakBased.layer.shadowOffset = .zero
        SarawakBased.layer.shadowRadius = 0.5
        
        Service.layer.cornerRadius = 10
        Service.layer.shadowOpacity = 1
        Service.layer.shadowOffset = .zero
        Service.layer.shadowRadius = 0.5
        
        Fashion.layer.cornerRadius = 10
        Fashion.layer.shadowOpacity = 1
        Fashion.layer.shadowOffset = .zero
        Fashion.layer.shadowRadius = 0.5
        
        CakePastries.isUserInteractionEnabled = true
        ProcessFood.isUserInteractionEnabled = true
        HealthBeauty.isUserInteractionEnabled = true
        Handicraft.isUserInteractionEnabled = true
        HomeLiving.isUserInteractionEnabled = true
        Retail.isUserInteractionEnabled = true
        Agriculture.isUserInteractionEnabled = true
        SarawakBased.isUserInteractionEnabled = true
        Service.isUserInteractionEnabled = true
        Fashion.isUserInteractionEnabled = true
        FindBar.isUserInteractionEnabled = true
        CartBar.isUserInteractionEnabled = true
        
        let FindClick = UITapGestureRecognizer(target: self, action: #selector(onFindBarClick(sender:)))
        let CartClick = UITapGestureRecognizer(target: self, action: #selector(onCartBarClick(sender:)))

        let CakeClick = UITapGestureRecognizer(target: self, action: #selector(onCake(sender:)))
        let ProcessClick = UITapGestureRecognizer(target: self, action: #selector(onProcess(sender:)))
        let HealthClick = UITapGestureRecognizer(target: self, action: #selector(onHealth))
        let HandicraftClick = UITapGestureRecognizer(target: self, action: #selector(onHandicraft(sender:)))
        let HomeLivingClick = UITapGestureRecognizer(target: self, action: #selector(onHomeLiving(sender:)))
        let RetailClick = UITapGestureRecognizer(target: self, action: #selector(onRetail(sender:)))
        let AgricultureClick = UITapGestureRecognizer(target: self, action: #selector(onAgriculture(sender:)))
        let SarawakClick = UITapGestureRecognizer(target: self, action: #selector(onSarawakBased(sender:)))
        let ServiceClick = UITapGestureRecognizer(target: self, action: #selector(onService(sender:)))
        let FashionClick = UITapGestureRecognizer(target: self, action: #selector(onFashion(sender:)))
        
        FindBar.addGestureRecognizer(FindClick)
        CartBar.addGestureRecognizer(CartClick)
        CakePastries.addGestureRecognizer(CakeClick)
        ProcessFood.addGestureRecognizer(ProcessClick)
        HealthBeauty.addGestureRecognizer(HealthClick)
        Handicraft.addGestureRecognizer(HandicraftClick)
        HomeLiving.addGestureRecognizer(HomeLivingClick)
        Retail.addGestureRecognizer(RetailClick)
        Agriculture.addGestureRecognizer(AgricultureClick)
        SarawakBased.addGestureRecognizer(SarawakClick)
        Service.addGestureRecognizer(ServiceClick)
        Fashion.addGestureRecognizer(FashionClick)
          
        let tabbar = tabBarController as! BaseTabBarController
        getUserDetails(userID: tabbar.value)
        HotSelling()
        ShockingSale()
        CartCount(UserID: tabbar.value)
        
    }
    
    @objc func onCartBarClick(sender: Any){
        let tabbar = tabBarController as! BaseTabBarController
        let click = self.storyboard!.instantiateViewController(identifier: "CartViewController") as! CartViewController
        click.userID = tabbar.value
        if let navigator = self.navigationController {
            navigator.pushViewController(click, animated: true)
        }
    }
    
    @IBAction func ViewAllCate(_ sender: Any) {
        let tabbar = tabBarController as! BaseTabBarController
        let click = self.storyboard!.instantiateViewController(identifier: "CategoryViewController") as! CategoryViewController
        click.UserID = tabbar.value
        click.URL_READ = URL_READ_VIEWALL
        click.URL_SEARCH = URL_SEARCH_VIEWALL
        click.URL_FILTER_DIVISION = URL_FILTER_DIVISION_VIEWALL
        click.URL_FILTER_DISTRICT = URL_FILTER_DISTRICT_VIEWALL
        click.URL_FILTER_SEARCH_DIVISION = URL_FILTER_SEARCH_DIVISION_VIEWALL
        if let navigator = self.navigationController {
            navigator.pushViewController(click, animated: true)
        }
    }
    
    @IBAction func ViewAllHot(_ sender: Any) {
        let tabbar = tabBarController as! BaseTabBarController
        let click = self.storyboard!.instantiateViewController(identifier: "CategoryViewController") as! CategoryViewController
        click.UserID = tabbar.value
        click.URL_READ = URL_READ_HOT
        click.URL_SEARCH = URL_SEARCH_HOT
        click.URL_FILTER_DIVISION = URL_FILTER_DIVISION_HOT
        click.URL_FILTER_DISTRICT = URL_FILTER_DISTRICT_HOT
        click.URL_FILTER_SEARCH_DIVISION = URL_FILTER_SEARCH_DIVISION_HOT
        if let navigator = self.navigationController {
            navigator.pushViewController(click, animated: true)
        }
    }
    
    @IBAction func ViewAllShockingSale(_ sender: Any) {
        let tabbar = tabBarController as! BaseTabBarController
        let click = self.storyboard!.instantiateViewController(identifier: "CategoryViewController") as! CategoryViewController
        click.UserID = tabbar.value
        click.URL_READ = URL_READ_SHOCKING_SALE
        click.URL_SEARCH = URL_SEARCH_SHOCKING_SALE
        click.URL_FILTER_DIVISION = URL_FILTER_DIVISION_SHOCKING_SALE
        click.URL_FILTER_DISTRICT = URL_FILTER_DISTRICT_SHOCKING_SALE
        click.URL_FILTER_SEARCH_DIVISION = URL_FILTER_SEARCH_DIVISION_SHOCKING_SALE
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
        let tabbar = tabBarController as! BaseTabBarController
        let parameters: Parameters=[
            "id": tabbar.value
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
                            
                            let gotoRegister = self.storyboard!.instantiateViewController(identifier: "GotoRegisterSellerViewController") as! GotoRegisterSellerViewController
                            gotoRegister.userID = tabbar.value
                            if let navigator = self.navigationController {
                                navigator.pushViewController(gotoRegister, animated: true)
                            }
                        }else{
                            let addProduct = self.storyboard!.instantiateViewController(identifier: "AddNewProductViewController") as! AddNewProductViewController
                            addProduct.userID = tabbar.value
                            if let navigator = self.navigationController {
                                navigator.pushViewController(addProduct, animated: true)
                            }
                        }
                        
                        self.UserImage.setImageWith(URL(string: Photo[0])!)
                    }
                }else{
                    print("FAILED")
                }
                
        }
    }
    
    
    @IBAction func Find(_ sender: Any) {
        let tabbar = tabBarController as! BaseTabBarController
        let click = self.storyboard!.instantiateViewController(identifier: "CategoryViewController") as! CategoryViewController
        click.UserID = tabbar.value
        click.URL_READ = URL_READ_VIEWALL
        click.URL_SEARCH = URL_SEARCH_VIEWALL
        click.URL_FILTER_DIVISION = URL_FILTER_DIVISION_VIEWALL
        click.URL_FILTER_DISTRICT = URL_FILTER_DISTRICT_VIEWALL
        click.URL_FILTER_SEARCH_DIVISION = URL_FILTER_SEARCH_DIVISION_VIEWALL
        if let navigator = self.navigationController {
            navigator.pushViewController(click, animated: true)
        }
    }
    
    @objc func onFindBarClick(sender: Any){
        let tabbar = tabBarController as! BaseTabBarController
        let click = self.storyboard!.instantiateViewController(identifier: "CategoryViewController") as! CategoryViewController
        click.UserID = tabbar.value
        click.URL_READ = URL_READ_VIEWALL
        click.URL_SEARCH = URL_SEARCH_VIEWALL
        click.URL_FILTER_DIVISION = URL_FILTER_DIVISION_VIEWALL
        click.URL_FILTER_DISTRICT = URL_FILTER_DISTRICT_VIEWALL
        click.URL_FILTER_SEARCH_DIVISION = URL_FILTER_SEARCH_DIVISION_VIEWALL
        if let navigator = self.navigationController {
            navigator.pushViewController(click, animated: true)
        }
    }
    
    @objc func onCake(sender: Any){
        let tabbar = tabBarController as! BaseTabBarController
        let click = self.storyboard!.instantiateViewController(identifier: "CategoryViewController") as! CategoryViewController
        click.UserID = tabbar.value
        click.URL_READ = URL_READ_CAKE
        click.URL_SEARCH = URL_SEARCH_CAKE
        click.URL_FILTER_DIVISION = URL_FILTER_DIVISION_CAKE
        click.URL_FILTER_DISTRICT = URL_FILTER_DISTRICT_CAKE
        click.URL_FILTER_SEARCH_DIVISION = URL_FILTER_SEARCH_DIVISION_CAKE
        if let navigator = self.navigationController {
            navigator.pushViewController(click, animated: true)
        }
    }    
    @objc func onProcess(sender: Any){
        print("Success")
        let tabbar = tabBarController as! BaseTabBarController
        let click = self.storyboard!.instantiateViewController(identifier: "CategoryViewController") as! CategoryViewController
        click.UserID = tabbar.value
        click.URL_READ = URL_READ_PROCESS
        click.URL_SEARCH = URL_SEARCH_PROCESS
        click.URL_FILTER_DIVISION = URL_FILTER_DIVISION_PROCESS
        click.URL_FILTER_DISTRICT = URL_FILTER_DISTRICT_PROCESS
        click.URL_FILTER_SEARCH_DIVISION = URL_FILTER_SEARCH_DIVISION_PROCESS
        if let navigator = self.navigationController {
            navigator.pushViewController(click, animated: true)
        }
    }
    @objc func onHealth(sender: Any){
        print("Success")
        let tabbar = tabBarController as! BaseTabBarController
        let click = self.storyboard!.instantiateViewController(identifier: "CategoryViewController") as! CategoryViewController
        click.UserID = tabbar.value
        click.URL_READ = URL_READ_HEALTH
        click.URL_SEARCH = URL_SEARCH_HEALTH
        click.URL_FILTER_DIVISION = URL_FILTER_DIVISION_HEALTH
        click.URL_FILTER_DISTRICT = URL_FILTER_DISTRICT_HEALTH
        click.URL_FILTER_SEARCH_DIVISION = URL_FILTER_SEARCH_DIVISION_HEALTH
        if let navigator = self.navigationController {
            navigator.pushViewController(click, animated: true)
        }
    }
    @objc func onHandicraft(sender: Any){
        print("Success")
        let tabbar = tabBarController as! BaseTabBarController
        let click = self.storyboard!.instantiateViewController(identifier: "CategoryViewController") as! CategoryViewController
        click.UserID = tabbar.value
        click.URL_READ = URL_READ_HANDICRAFT
        click.URL_SEARCH = URL_SEARCH_HANDICRAFT
        click.URL_FILTER_DIVISION = URL_FILTER_DIVISION_HANDICRAFT
        click.URL_FILTER_DISTRICT = URL_FILTER_DISTRICT_HANDICRAFT
        click.URL_FILTER_SEARCH_DIVISION = URL_FILTER_SEARCH_DIVISION_HANDICRAFT
        if let navigator = self.navigationController {
            navigator.pushViewController(click, animated: true)
        }
    }
    @objc func onHomeLiving(sender: Any){
        print("Success")
        let tabbar = tabBarController as! BaseTabBarController
        let click = self.storyboard!.instantiateViewController(identifier: "CategoryViewController") as! CategoryViewController
        click.UserID = tabbar.value
        click.URL_READ = URL_READ_HOMELIVING
        click.URL_SEARCH = URL_SEARCH_HOMELIVING
        click.URL_FILTER_DIVISION = URL_FILTER_DIVISION_HOMELIVING
        click.URL_FILTER_DISTRICT = URL_FILTER_DISTRICT_HOMELIVING
        click.URL_FILTER_SEARCH_DIVISION = URL_FILTER_SEARCH_DIVISION_HOMELIVING
        if let navigator = self.navigationController {
            navigator.pushViewController(click, animated: true)
        }
    }
    @objc func onRetail(sender: Any){
        print("Success")
        let tabbar = tabBarController as! BaseTabBarController
        let click = self.storyboard!.instantiateViewController(identifier: "CategoryViewController") as! CategoryViewController
        click.UserID = tabbar.value
        click.URL_READ = URL_READ_RETAIL
        click.URL_SEARCH = URL_SEARCH_RETAIL
        click.URL_FILTER_DIVISION = URL_FILTER_DIVISION_RETAIL
        click.URL_FILTER_DISTRICT = URL_FILTER_DISTRICT_RETAIL
        click.URL_FILTER_SEARCH_DIVISION = URL_FILTER_SEARCH_DIVISION_RETAIL
        if let navigator = self.navigationController {
            navigator.pushViewController(click, animated: true)
        }
    }
    @objc func onAgriculture(sender: Any){
        print("Success")
        let tabbar = tabBarController as! BaseTabBarController
        let click = self.storyboard!.instantiateViewController(identifier: "CategoryViewController") as! CategoryViewController
        click.UserID = tabbar.value
        click.URL_READ = URL_READ_AGRICULTURE
        click.URL_SEARCH = URL_SEARCH_AGRICULTURE
        click.URL_FILTER_DIVISION = URL_FILTER_DIVISION_AGRICULTURE
        click.URL_FILTER_DISTRICT = URL_FILTER_DISTRICT_AGRICULTURE
        click.URL_FILTER_SEARCH_DIVISION = URL_FILTER_SEARCH_DIVISION_AGRICULTURE
        if let navigator = self.navigationController {
            navigator.pushViewController(click, animated: true)
        }
    }
    @objc func onSarawakBased(sender: Any){
        print("Success")
        let tabbar = tabBarController as! BaseTabBarController
        let click = self.storyboard!.instantiateViewController(identifier: "CategoryViewController") as! CategoryViewController
        click.UserID = tabbar.value
        click.URL_READ = URL_READ_SARAWAKBASED
        click.URL_SEARCH = URL_SEARCH_SARAWAKBASED
        click.URL_FILTER_DIVISION = URL_FILTER_DIVISION_SARAWAKBASED
        click.URL_FILTER_DISTRICT = URL_FILTER_DISTRICT_SARAWAKBASED
        click.URL_FILTER_SEARCH_DIVISION = URL_FILTER_SEARCH_DIVISION_SARAWAKBASED
        if let navigator = self.navigationController {
            navigator.pushViewController(click, animated: true)
        }
    }
    @objc func onService(sender: Any){
        print("Success")
        let tabbar = tabBarController as! BaseTabBarController
        let click = self.storyboard!.instantiateViewController(identifier: "CategoryViewController") as! CategoryViewController
        click.UserID = tabbar.value
        click.URL_READ = URL_READ_SERVICE
        click.URL_SEARCH = URL_SEARCH_SERVICE
        click.URL_FILTER_DIVISION = URL_FILTER_DIVISION_SERVICE
        click.URL_FILTER_DISTRICT = URL_FILTER_DISTRICT_SERVICE
        click.URL_FILTER_SEARCH_DIVISION = URL_FILTER_SEARCH_DIVISION_SERVICE
        if let navigator = self.navigationController {
            navigator.pushViewController(click, animated: true)
        }
    }
    @objc func onFashion(sender: Any){
        print("Success")
        let tabbar = tabBarController as! BaseTabBarController
        let click = self.storyboard!.instantiateViewController(identifier: "CategoryViewController") as! CategoryViewController
        click.UserID = tabbar.value
        click.URL_READ = URL_READ_FASHION
        click.URL_SEARCH = URL_SEARCH_FASHION
        click.URL_FILTER_DIVISION = URL_FILTER_DIVISION_FASHION
        click.URL_FILTER_DISTRICT = URL_FILTER_DISTRICT_CAKE
        click.URL_FILTER_SEARCH_DIVISION = URL_FILTER_SEARCH_DIVISION_FASHION
        if let navigator = self.navigationController {
            navigator.pushViewController(click, animated: true)
        }
    }
    
    func getUserDetails(userID: String){
        let parameters: Parameters=[
            "id": userID
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
                        if verify[0] == "1" {
                            self.Verify.text = "SELLER"
                        }else{
                            self.Verify.text = "BUYER"
                        }
                        
                        self.UserImage.setImageWith(URL(string: Photo[0])!)
                    }
                }else{
                    print("FAILED")
                }
                
        }
    }
    
    func HotSelling(){
        Alamofire.request(URL_READ_HOT, method: .post).responseJSON
            {
                response in
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
                        let Photo = user.value(forKey: "photo") as! [String]
                        let division = user.value(forKey: "division") as! [String]
                        let district = user.value(forKey: "district") as! [String]
                        
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
                        self.PHOTOHOT = Photo
                        self.DIVISIONHOT = division
                        self.DISTRICTHOT = district
                        
                        self.HotView.reloadData()
                        
                    }
                }
        }
    }
    
    func ShockingSale(){
            Alamofire.request(URL_READ_SHOCKING_SALE, method: .post).responseJSON
                {
                    response in
                    //printing response
    //                print(response)
                    
                    //getting the json value from the server
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
                            let Photo = user.value(forKey: "photo") as! [String]
                            let division = user.value(forKey: "division") as! [String]
                            let district = user.value(forKey: "district") as! [String]
                            
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
                            self.PHOTOSHOCKING = Photo
                            self.DIVISIONSHOCKING = division
                            self.DISTRICTSHOCKING = district

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
                        //printing response
        //                print(response)
                        
                        //getting the json value from the server
                        if let result = response.result.value{
                            let jsonData = result as! NSDictionary
                            
                            if((jsonData.value(forKey: "success") as! NSString).boolValue){
                                let user = jsonData.value(forKey: "read") as! NSArray
                                
                                let ItemID = user.value(forKey: "id") as! [String]
                                
                                self.ID1 = ItemID
                                self.Cart_count = ItemID.count
                                
                                var badgeAppearance = BadgeAppearance()
                                badgeAppearance.backgroundColor = UIColor.red //default is red
                                badgeAppearance.textColor = UIColor.white // default is white
                                badgeAppearance.textAlignment = .center //default is center
                                badgeAppearance.textSize = 10 //default is 12
                                badgeAppearance.distanceFromCenterX = -0.001 //default is 0
                                badgeAppearance.distanceFromCenterY = -7 //default is 0
                                badgeAppearance.allowShadow = true
                                badgeAppearance.borderColor = .red
                                badgeAppearance.borderWidth = 0
                                self.CartBar.badge(text: String(self.Cart_count), appearance: badgeAppearance)
                            }
                        }
                }
    }
    
    func onViewClick(cell: ShockingSaleCollectionViewCell) {
        guard let indexPath = self.HotView.indexPath(for: cell) else{
            return
        }
        
        let viewProduct = self.storyboard!.instantiateViewController(identifier: "ViewProductViewController") as! ViewProductViewController
        viewProduct.USERID = userID
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
        viewProduct.PHOTO = self.PHOTOHOT[indexPath.row]
        viewProduct.DIVISION = self.DIVISIONHOT[indexPath.row]
        viewProduct.DISTRICT = self.DISTRICTHOT[indexPath.row]
        if let navigator = self.navigationController {
            navigator.pushViewController(viewProduct, animated: true)
        }
    }
    
    
    func onViewClick(cell: HotCollectionViewCell) {
        guard let indexPath = self.HotView.indexPath(for: cell) else{
            return
        }
        
        let viewProduct = self.storyboard!.instantiateViewController(identifier: "ViewProductViewController") as! ViewProductViewController
        viewProduct.USERID = userID
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
        viewProduct.PHOTO = self.PHOTOSHOCKING[indexPath.row]
        viewProduct.DIVISION = self.DIVISIONSHOCKING[indexPath.row]
        viewProduct.DISTRICT = self.DISTRICTSHOCKING[indexPath.row]
        if let navigator = self.navigationController {
            navigator.pushViewController(viewProduct, animated: true)
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
            
            let NEWIm = self.PHOTOHOT[indexPath.row].addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
            
            cell.ItemImage.setImageWith(URL(string: NEWIm!)!)
            
            cell.ItemName.text! = self.ADDETAILHOT[indexPath.row]
            cell.ItemPrice.text! = self.PRICEHOT[indexPath.row]
            cell.ButtonView.layer.cornerRadius = 2
            cell.ButtonView.layer.borderWidth = 1
            
            cell.delegate = self
            return cell
        }else{
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "ShockingSaleCollectionViewCell", for: indexPath) as! ShockingSaleCollectionViewCell
            let NEWIm = self.PHOTOSHOCKING[indexPath.row].addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
            cell1.ItemImage.setImageWith(URL(string: NEWIm!)!)
            cell1.ItemName.text! = self.ADDETAILSHOCKING[indexPath.row]
            cell1.ItemPrice.text! = self.PRICESHOCKING[indexPath.row]
            cell1.ButtonView.layer.cornerRadius = 2
            cell1.ButtonView.layer.borderWidth = 1
            
            cell1.delegate = self
            return cell1
        }

    }
}
