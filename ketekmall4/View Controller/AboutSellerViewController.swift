//
//  AboutSellerViewController.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 01/09/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit
import Alamofire
import JGProgressHUD

class AboutSellerViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, AboutSellerDelegate, UITabBarDelegate, UICollectionViewDelegateFlowLayout {
    
    let URL_READ_SELLER = "https://ketekmall.com/ketekmall/read_order_done_seller_shop.php"
    let URL_READALL_SELLER = "https://ketekmall.com/ketekmall/readall_seller.php"
    let URL_ADD_FAV = "https://ketekmall.com/ketekmall/add_to_fav.php"
    let URL_ADD_CART = "https://ketekmall.com/ketekmall/add_to_cart.php"
    let URL_READ = "https://ketekmall.com/ketekmall/read_detail.php"
    
    private let spinner = JGProgressHUD(style: .dark)
    
    let sharedPref = UserDefaults.standard
    var lang: String = ""
    var email_user: String = ""

    @IBOutlet weak var ButtonChatSeller: UIImageView!
    @IBOutlet weak var ProductLabel: UILabel!
    @IBOutlet weak var SoldLabel: UILabel!
    @IBOutlet weak var ButtonChat: UIButton!
    
    @IBOutlet weak var ListLabel: UILabel!
    @IBOutlet weak var SellerView: UIView!
    @IBOutlet weak var DetailView: UIView!
    @IBOutlet weak var AboutSellerView: UICollectionView!
    @IBOutlet weak var SellerImage: UIImageView!
    @IBOutlet weak var SellerName: UILabel!
    @IBOutlet weak var SellerLocation: UILabel!
    @IBOutlet weak var Products: UILabel!
    @IBOutlet weak var Sold: UILabel!
    @IBOutlet weak var Tabbar: UITabBar!
    
    var viewController1: UIViewController?
    var UserID: String = ""
    var SELLERID1: String = ""
    var SELLLERNAME: String = ""
    var SELLERLOCATION: String = ""
    var SELLERIMAGE: String = ""
    var SELLERPHONE: String = ""
    
    var SELLERID: [String] = []
    var MAINCATE: [String] = []
    var SUBCATE: [String] = []
    var BRAND: [String] = []
    var INNER: [String] = []
    var STOCK: [String] = []
    var DESC: [String] = []
    var MAXORDER: [String] = []
    var DIVISION: [String] = []
    var RATING: [String] = []
    var ITEMID: [String] = []
    var ADDETAIL: [String] = []
    var PRICE: [String] = []
    var PHOTO: [String] = []
    var DISTRICT: [String] = []
    var SOLD: [String] = []
    
    override func viewDidAppear(_ animated: Bool) {
        ColorFunc()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lang = sharedPref.string(forKey: "LANG") ?? "0"
        email_user = sharedPref.string(forKey: "EMAIL") ?? "0"
        if(lang == "ms"){
            changeLanguage(str: "ms")
            
        }else{
            changeLanguage(str: "en")
            
        }
        Tabbar.delegate = self

        AboutSellerView.delegate = self
        AboutSellerView.dataSource = self
        
        SellerName.text! = SELLLERNAME
        SellerLocation.text! = SELLERLOCATION
        SellerImage.layer.cornerRadius = SellerImage.frame.width / 2
        SellerImage.layer.masksToBounds = true
        SellerImage.setImageWith(URL(string: SELLERIMAGE)!)
        
        SellerView.layer.cornerRadius = 10
        DetailView.layer.cornerRadius = 10
        
        ViewList()
        getSold()
        
        ButtonChatSeller.isUserInteractionEnabled = true
        let Chat_Click = UITapGestureRecognizer(target: self, action: #selector(onChatClick(sender:)))
        ButtonChatSeller.addGestureRecognizer(Chat_Click)
    }
    
    func changeLanguage(str: String){
        Tabbar.items?[0].title = "Home".localized(lang: str)
        Tabbar.items?[1].title = "Notification".localized(lang: str)
        Tabbar.items?[2].title = "Me".localized(lang: str)

        ProductLabel.text = "Products".localized(lang: str)
        SoldLabel.text = "Sold".localized(lang: str)
    }
    
    func ColorFunc(){
        let colorViewOne = UIColor(hexString: "#FC4A1A").cgColor
        let colorViewTwo = UIColor(hexString: "#F7B733").cgColor
        
        let ViewGradient = CAGradientLayer()
        ViewGradient.frame = self.view.bounds
        ViewGradient.colors = [colorViewOne, colorViewTwo]
        ViewGradient.startPoint = CGPoint(x: 0, y: 0.5)
        ViewGradient.endPoint = CGPoint(x: 1, y: 0.5)
        ViewGradient.cornerRadius = 16
        self.view.layer.insertSublayer(ViewGradient, at: 0)
        
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
    
    @objc func onChatClick(sender: Any){
        let parameters: Parameters=[
            "id": SELLERID1
        ]
        
        Alamofire.request(URL_READ, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        let user = jsonData.value(forKey: "read") as! NSArray
                        
                        let name = user.value(forKey: "name") as! [String]
                        let email = user.value(forKey: "email") as! [String]
                        
                        let index2 = email[0].firstIndex(of: "@") ?? email[0].endIndex
                        let newEmail2 = email[0][..<index2]
                        
                        let vc = ChatViewController()
                        vc.title = name[0]
                        vc.navigationItem.largeTitleDisplayMode = .never
                        vc.chatWith = String(newEmail2)
                        vc.chatName = name[0]
                        vc.emailUser = self.email_user
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }else{
                    print("FAILED")
                }
                
        }
    }
 
    @IBAction func ButtonWhatsapp(_ sender: Any) {
        let urlWhats = "whatsapp://send?phone=" + "+6" + SELLERPHONE
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed){
            if let whatsappURL = URL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL){
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(whatsappURL)
                    }
                }
                else {
                    print("Install Whatsapp")
                }
            }
        }
    }
    
    func getSold(){
        let parameters: Parameters=[
            "seller_id": SELLERID1,
        ]
        
        Alamofire.request(URL_READ_SELLER, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        let user = jsonData.value(forKey: "read") as! NSArray
                        
                        let ItemID = user.value(forKey: "id") as! [String]
                        self.SOLD = ItemID
                        self.Sold.text! = String(self.SOLD.count)
                        
                    }
                }else{
                    print("FAILED")
                }
                
        }
    }
    
    func ViewList(){
        let parameters: Parameters=[
            "user_id": SELLERID1,
        ]
        
        Alamofire.request(URL_READALL_SELLER, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        let user = jsonData.value(forKey: "read") as! NSArray
                        
                        let ItemID = user.value(forKey: "id") as! [String]
                        let Seller_ID = user.value(forKey: "user_id") as! [String]
                        let Main_Cate = user.value(forKey: "main_category") as! [String]
                        let Sub_Cate = user.value(forKey: "sub_category") as! [String]
                        let Ad_Detail = user.value(forKey: "ad_detail") as! [String]
                        let brand_mat = user.value(forKey: "brand_material") as! [String]
                        let inner_mat = user.value(forKey: "inner_material") as! [String]
                        let stock = user.value(forKey: "stock") as! [String]
                        let description = user.value(forKey: "description") as! [String]
                        let rating = user.value(forKey: "rating") as! [String]
                        let Price = user.value(forKey: "price") as! [String]
                        let Photo = user.value(forKey: "photo") as! [String]
                        let Division = user.value(forKey: "division") as! [String]
                        let District = user.value(forKey: "district") as! [String]
                        
                        self.ITEMID = ItemID
                        self.SELLERID = Seller_ID
                        self.MAINCATE = Main_Cate
                        self.SUBCATE = Sub_Cate
                        self.ADDETAIL = Ad_Detail
                        self.BRAND = brand_mat
                        self.INNER = inner_mat
                        self.STOCK = stock
                        self.DESC = description
                        self.PRICE = Price
                        self.PHOTO = Photo
                        self.RATING = rating
                        self.DIVISION = Division
                        self.DISTRICT = District
                        
                        self.Products.text! = String(self.ITEMID.count)
                        
                        self.AboutSellerView.reloadData()
                    }
                }else{
                    print("FAILED")
                }
                
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ITEMID.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AboutSellerCollectionViewCell", for: indexPath) as! AboutSellerCollectionViewCell
        
        let NEWIm = self.PHOTO[indexPath.row].addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        
        if let n = NumberFormatter().number(from: self.RATING[indexPath.row]) {
            let f = CGFloat(truncating: n)
            cell.Rating.value = f
        }
        cell.ItemImage.setImageWith(URL(string: NEWIm!)!)
        cell.ItemName.text! = self.ADDETAIL[indexPath.row]
        cell.ItemPrice.text! = "MYR" + self.PRICE[indexPath.row]
        cell.ItemLocation.text! = self.DISTRICT[indexPath.row]
        cell.ButtonView.layer.cornerRadius = 10
        
        cell.layer.borderWidth = 0.2
        cell.layer.cornerRadius = 5
        
        if(lang == "ms"){
                   cell.ButtonView.setTitle("VIEW".localized(lang: "ms"), for: .normal)
               }else{
                   cell.ButtonView.setTitle("VIEW".localized(lang: "en"), for: .normal)
               }

        let colorViewOne = UIColor(hexString: "#FC4A1A").cgColor
        let colorViewTwo = UIColor(hexString: "#F7B733").cgColor
        
        let ViewGradient = CAGradientLayer()
        ViewGradient.frame = cell.ButtonView.bounds
        ViewGradient.colors = [colorViewOne, colorViewTwo]
        ViewGradient.startPoint = CGPoint(x: 0, y: 0.5)
        ViewGradient.endPoint = CGPoint(x: 1, y: 0.5)
        ViewGradient.cornerRadius = 10
        cell.ButtonView.layer.insertSublayer(ViewGradient, at: 0)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = collectionView.bounds
        let screenWidth = screenSize.width
        let cellSquareSize: CGFloat = screenWidth / 2.0
        return CGSize(width: cellSquareSize, height: 286);
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0.0, right: 0.0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
       return 0.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
       return 0.0
    }
    
    func onViewClick(cell: AboutSellerCollectionViewCell) {
        guard let indexPath = self.AboutSellerView.indexPath(for: cell) else{
            return
        }
        
        let viewProduct = self.storyboard!.instantiateViewController(identifier: "ViewProductViewController") as! ViewProductViewController
        viewProduct.USERID = UserID
        viewProduct.ItemID = self.ITEMID[indexPath.row]
        viewProduct.SELLERID = self.SELLERID[indexPath.row]
        viewProduct.MAINCATE = self.MAINCATE[indexPath.row]
        viewProduct.SUBCATE = self.SUBCATE[indexPath.row]
        viewProduct.ADDETAIL = self.ADDETAIL[indexPath.row]
        viewProduct.BRAND = self.BRAND[indexPath.row]
        viewProduct.INNER = self.INNER[indexPath.row]
        viewProduct.STOCK = self.STOCK[indexPath.row]
        viewProduct.DESC = self.DESC[indexPath.row]
        viewProduct.PRICE = self.PRICE[indexPath.row]
        viewProduct.PHOTO = self.PHOTO[indexPath.row]
        viewProduct.DIVISION = self.DIVISION[indexPath.row]
        viewProduct.DISTRICT = self.DISTRICT[indexPath.row]
        if let navigator = self.navigationController {
            navigator.pushViewController(viewProduct, animated: true)
        }
    }
    
    func onAddToFav(cell: AboutSellerCollectionViewCell) {
        guard let indexPath = self.AboutSellerView.indexPath(for: cell) else{
                    return
                }
                
                let parameters: Parameters=[
                    "seller_id": self.SELLERID[indexPath.row],
                    "item_id": self.ITEMID[indexPath.row],
                    "customer_id": UserID,
                    "main_category": self.MAINCATE[indexPath.row],
                    "sub_category": self.SUBCATE[indexPath.row],
                    "ad_detail": self.ADDETAIL[indexPath.row],
                    "brand_material":self.BRAND[indexPath.row],
                    "inner_material": self.INNER[indexPath.row],
                    "stock": self.STOCK[indexPath.row],
                    "description": self.DESC[indexPath.row],
                    "price": self.PRICE[indexPath.row],
                    "rating": self.RATING[indexPath.row],
                    "division": self.DIVISION[indexPath.row],
                    "district": self.DISTRICT[indexPath.row],
                    "photo": self.PHOTO[indexPath.row]
                ]
                
                //Sending http post request
                Alamofire.request(URL_ADD_FAV, method: .post, parameters: parameters).responseJSON
                    {
                        response in
                        if let result = response.result.value {
                            let jsonData = result as! NSDictionary
                            print(jsonData.value(forKey: "message")!)
                            self.spinner.indicatorView = JGProgressHUDSuccessIndicatorView()
                            if(self.lang == "ms"){
                                self.spinner.textLabel.text = "Added to My Likes".localized(lang: "ms")
                                
                            }else{
                                self.spinner.textLabel.text = "Add to My Likes".localized(lang: "en")
                               
                            }
                            self.spinner.show(in: self.view)
                            self.spinner.dismiss(afterDelay: 2.0)
                        }
                }
    }
    
    func onAddToCart(cell: AboutSellerCollectionViewCell) {
        guard let indexPath = self.AboutSellerView.indexPath(for: cell) else{
                    return
                }
                
                let parameters: Parameters=[
                    "seller_id": self.SELLERID[indexPath.row],
                    "item_id": self.ITEMID[indexPath.row],
                    "customer_id": UserID,
                    "main_category": self.MAINCATE[indexPath.row],
                    "sub_category": self.SUBCATE[indexPath.row],
                    "ad_detail": self.ADDETAIL[indexPath.row],
                    "price": self.PRICE[indexPath.row],
                    "quantity": "1",
                    "division": self.DIVISION[indexPath.row],
                    "district": self.DISTRICT[indexPath.row],
                    "photo": self.PHOTO[indexPath.row]
                ]
                
                //Sending http post request
                Alamofire.request(URL_ADD_CART, method: .post, parameters: parameters).responseJSON
                    {
                        response in
                        //printing response
        //                print(response)
                        
                        //getting the json value from the server
                        if let result = response.result.value {
                            
                            //converting it as NSDictionary
                            let jsonData = result as! NSDictionary
                            print(jsonData.value(forKey: "message")!)
                            self.spinner.indicatorView = JGProgressHUDSuccessIndicatorView()
                            if(self.lang == "ms"){
                                self.spinner.textLabel.text = "Added to Cart".localized(lang: "ms")
                                
                            }else{
                                self.spinner.textLabel.text = "Added to Cart".localized(lang: "en")
                               
                            }

                            self.spinner.show(in: self.view)
                            self.spinner.dismiss(afterDelay: 2.0)
                        }
                }
    }
}
