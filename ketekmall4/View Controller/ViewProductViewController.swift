//
//  ViewProductViewController.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 30/08/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit
import Alamofire
import AFNetworking
import SDWebImage
import AARatingBar
import JGProgressHUD

class ViewProductViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, FromSameShopDelegate, UITabBarDelegate, UICollectionViewDelegateFlowLayout {

    let sharedPref = UserDefaults.standard
    var lang: String = ""

    private let spinner = JGProgressHUD(style: .dark)
    
    @IBOutlet weak var ItemImage: UIImageView!
    @IBOutlet weak var ItemName: UILabel!
    @IBOutlet weak var ItemPrice: UILabel!
    @IBOutlet weak var Sold: UILabel!
    @IBOutlet weak var ShippingInfo: UILabel!
    @IBOutlet weak var MoreDetails: UILabel!
    @IBOutlet weak var FromSameShopLabel: UILabel!
    @IBOutlet weak var SoldLabel: UILabel!
    
    @IBOutlet weak var SellerImage: UIImageView!
    @IBOutlet weak var SellerName: UILabel!
    @IBOutlet weak var SellerDivision: UILabel!
    @IBOutlet weak var WhatsappButton: UIImageView!
    @IBOutlet weak var ViewButton: UIButton!
    @IBOutlet weak var Rating: AARatingBar!
    @IBOutlet weak var BaseRating: AARatingBar!
    
    @IBOutlet weak var ReviewImage: UIImageView!
    @IBOutlet weak var ReviewName: UILabel!
    @IBOutlet weak var Review: UILabel!
    @IBOutlet weak var ViewReview: UILabel!
    @IBOutlet weak var ButtonAddCart: UIButton!
    
    @IBOutlet weak var ViewSameShop: UILabel!
    @IBOutlet weak var SameShopView: UICollectionView!
    @IBOutlet weak var Tabbar: UITabBar!
    
    
    @IBOutlet weak var ShippingRight: UIImageView!
    @IBOutlet weak var MoreRight: UIImageView!
    
    var viewController1: UIViewController?
    
    
    let URL_ADD_CART = "https://ketekmall.com/ketekmall/add_to_cart.php"
    let URL_READ_SELLER = "https://ketekmall.com/ketekmall/read_order_done_seller.php"
    let URL_READ_REVIEW = "https://ketekmall.com/ketekmall/read_review.php"
    let URL_READ_DELIVERY = "https://ketekmall.com/ketekmall/read_delivery_single.php"
    let URL_READ = "https://ketekmall.com/ketekmall/read_detail.php"
    let URL_EDIT_RATING = "https://ketekmall.com/ketekmall/edit_detail_rating.php"
    let URL_EDIT_SOLD = "https://ketekmall.com/ketekmall/edit_detail_sold.php"
    let URL_READALL_SELLER = "https://ketekmall.com/ketekmall/readall_seller.php"
    let MAIN_PHOTO = "https://ketekmall.com/ketekmall/profile_image/main_photo.png"
    
    var ItemID: String = ""
    var SELLERID: String = ""
    var MAINCATE: String = ""
    var SUBCATE: String = ""
    var ADDETAIL: String = ""
    var BRAND: String = ""
    var INNER: String = ""
    var STOCK: String = ""
    var DESC: String = ""
    var PRICE: String = ""
    var DIVISION: String = ""
    var DISTRICT: String = ""
    var PHOTO: String = ""
    var USERID: String = ""
    var SOLD: String = ""
    
    var ITEMIMAGE: [String] = []
    var ITEMNAME: [String] = []
    var ITEMPLACE: [String] = []
    var ITEMPRICE: [String] = []
    var SELLERID_SAMESHOP: [String] = []
    var MAINCATE_SAMESHOP: [String] = []
    var SUBCATE_SAMESHOP: [String] = []
    var BRAND_SAMESHOP: [String] = []
    var INNER_SAMESHOP: [String] = []
    var STOCK_SAMESHOP: [String] = []
    var DESC_SAMESHOP: [String] = []
    var MAXORDER_SAMESHOP: [String] = []
    var DIVISION_SAMESHOP: [String] = []
    var RATING_SAMESHOP: [String] = []
    var ITEMID_SAMESHOP: [String] = []
    var ADDETAIL_SAMESHOP: [String] = []
    var PRICE_SAMESHOP: [String] = []
    var PHOTO_SAMESHOP: [String] = []
    var DISTRICT_SAMESHOP: [String] = []
    
    var ITEMID_DEL: [String] = []
    var USERID_DEL: [String] = []
    var DIVISION_DEL: [String] = []
    var DAYS_DEL: [String] = []
    var PRICE_DEL: [String] = []
    var DEL_ID: [String] = []
    var RATINGCOUNT: [String] = []
    
    var SELLERIMAGE: String = ""
    var SELLERNAME: String = ""
    var SELLERLOCATION: String = ""
    var SELLERPHONE: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lang = sharedPref.string(forKey: "LANG") ?? "0"
        if(lang == "ms"){
            changeLanguage(str: "ms")
            
        }else{
            changeLanguage(str: "en")
            
        }
        Tabbar.delegate = self
        
        SameShopView.delegate = self
        SameShopView.dataSource = self
        
        ViewButton.layer.cornerRadius = 5
        SellerImage.layer.cornerRadius = SellerImage.frame.width / 2
        SellerImage.layer.masksToBounds = true
        ButtonAddCart.layer.cornerRadius = 20
        ButtonAddCart.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        let NEWIm = PHOTO.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        
        ItemImage.setImageWith(URL(string: NEWIm!)!)
        ItemName.text! = ADDETAIL
        ItemPrice.text! = "MYR" + PRICE
        
        
        ShippingInfo.isUserInteractionEnabled = true
        ShippingRight.isUserInteractionEnabled = true
        MoreDetails.isUserInteractionEnabled = true
        MoreRight.isUserInteractionEnabled = true
        ViewReview.isUserInteractionEnabled = true
        ViewSameShop.isUserInteractionEnabled = true
        WhatsappButton.isUserInteractionEnabled = true
        
        
        
        let ShippingInfo_Click = UITapGestureRecognizer(target: self, action: #selector(onShippingInfoClick(sender:)))
        let MoreDetails_Click = UITapGestureRecognizer(target: self, action: #selector(onMoreDetailsClick(sender:)))
        
        let ViewReview_Click = UITapGestureRecognizer(target: self, action: #selector(onViewReview(sender:)))
        let ViewSameShop_Click = UITapGestureRecognizer(target: self, action: #selector(onFromSameShopClick(sender:)))
        
        let Whatsapp_Click = UITapGestureRecognizer(target: self, action: #selector(openWhatsapp(sender:)))
        
        ShippingInfo.addGestureRecognizer(ShippingInfo_Click)
        MoreDetails.addGestureRecognizer(MoreDetails_Click)
        ShippingRight.addGestureRecognizer(ShippingInfo_Click)
        MoreRight.addGestureRecognizer(MoreDetails_Click)
        ViewReview.addGestureRecognizer(ViewReview_Click)
        ViewSameShop.addGestureRecognizer(ViewSameShop_Click)
        WhatsappButton.addGestureRecognizer(Whatsapp_Click)
        
        getSellerDetails()
        getReview()
        getSold()
        SameShopList()
    }
    
    func changeLanguage(str: String){
        SoldLabel.text = "Sold".localized(lang: str)
        ShippingInfo.text = "Shipping Information".localized(lang: str)
        MoreDetails.text = "More Details".localized(lang: str)
        ViewReview.text = "View".localized(lang: str)
        FromSameShopLabel.text = "From the Same Shop".localized(lang: str)
        ViewSameShop.text = "View".localized(lang: str)
        ButtonAddCart.setTitle("Add to Cart".localized(lang: str), for: .normal)
        
        
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
    
    func getSellerDetails(){
        let parameters: Parameters=[
            "id": SELLERID
        ]
        
        Alamofire.request(URL_READ, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        let user = jsonData.value(forKey: "read") as! NSArray
                        
                        let name = user.value(forKey: "name") as! [String]
                        let district = user.value(forKey: "division") as! [String]
                        let Photo = user.value(forKey: "photo") as! [String]
                        let Phone = user.value(forKey: "phone_no") as! [String]
                        
                        self.SELLERPHONE = Phone[0]
                        self.SELLERIMAGE = Photo[0]
                        self.SELLERNAME = name[0]
                        self.SELLERLOCATION = district[0]
                        
                        self.SellerName.text = name[0]
                        self.SellerDivision.text! = district[0]
                        self.SellerImage.setImageWith(URL(string: Photo[0])!)
                    }
                }else{
                    print("FAILED")
                }
                
        }
    }
    
    func getReview(){
        let parameters: Parameters=[
            "item_id": ItemID
        ]
        
        Alamofire.request(URL_READ_REVIEW, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        let user = jsonData.value(forKey: "read") as! NSArray
                        
                        if(user.count == 0 ){
                            self.ReviewName.text? = "Customer Name"
                            self.Review.text? = "Review"
                            self.ReviewImage.setImageWith(URL(string: self.MAIN_PHOTO)!)
                            
                            self.Rating.value = 0
                            
                            self.BaseRating.value = 0
                        }else{
                            let name = user.value(forKey: "customer_name") as! [String]
                            let review = user.value(forKey: "review") as! [String]
                            let rating = user.value(forKey: "rating") as! [String]
                            
                            if let n = NumberFormatter().number(from: rating[0]) {
                                let f = CGFloat(truncating: n)
                                self.Rating.value = f
                            }
                            self.ReviewName.text? = name[0]
                            self.Review.text? = review[0]
                            self.ReviewImage.setImageWith(URL(string: self.MAIN_PHOTO)!)
                            
                            self.RATINGCOUNT = rating
                            var Rate: Double = 0.00
                            var NewRate: Double = 0.00
                            
                            for i in rating {
                                Rate += Double(i) ?? .nan
                                
                            }
                            NewRate = Rate / Double(user.count)
                            
                            if let n = NumberFormatter().number(from: String(format: "%.2f",NewRate)) {
                                let f = CGFloat(truncating: n)
                                self.BaseRating.value = f
                            }
                            //                        print("rate: " + String(format: "%.2f",NewRate))
                            
                            self.EditRating(ItemID: self.ItemID, RatingCount: String(format: "%.2f",NewRate))
                        }
                    }
                }else{
                    print("REVIEW FAILED")
                }
                
        }
    }
    
    func getSold(){
        spinner.show(in: self.view)
        let parameters: Parameters=[
            "seller_id": SELLERID,
            "ad_detail": ADDETAIL,
        ]
        
        Alamofire.request(URL_READ_SELLER, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        self.spinner.dismiss(afterDelay: 3.0)
                        let user = jsonData.value(forKey: "read") as! NSArray
                        
                        let ID = user.value(forKey: "id") as! [String]
                        
                        
                        self.SOLD = String(ID.count)
                        self.EditSold(ItemID: self.ItemID, SoldCount: self.SOLD)
                        
                        self.Sold.text! = self.SOLD
                    }
                }else{
                    print("FAILED")
                }
                
        }
    }
    
    func EditSold(ItemID: String, SoldCount: String){
        let parameters: Parameters=[
            "id": ItemID,
            "sold": SoldCount,
        ]
        
        Alamofire.request(URL_EDIT_SOLD, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value{
                    _ = result as! NSDictionary
                    print("SUCCESS")
                }else{
                    print("FAILED")
                }
                
        }
    }
    
    func EditRating(ItemID: String, RatingCount: String){
        let parameters: Parameters=[
            "id": ItemID,
            "rating": RatingCount,
        ]
        
        Alamofire.request(URL_EDIT_RATING, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value{
                    _ = result as! NSDictionary
                    print("SUCCESS")
                }else{
                    print("FAILED")
                }
                
        }
    }
    
    func SameShopList(){
        let parameters: Parameters=[
            "user_id": SELLERID
        ]
        
        Alamofire.request(URL_READALL_SELLER, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        let user = jsonData.value(forKey: "read") as! NSArray
                        
                        let ItemID = user.value(forKey: "id") as! [String]
                        //                                        let Seller_ID = user.value(forKey: "user_id") as! [String]
                        let Main_Cate = user.value(forKey: "main_category") as! [String]
                        let Sub_Cate = user.value(forKey: "sub_category") as! [String]
                        let Ad_Detail = user.value(forKey: "ad_detail") as! [String]
                        let brand_mat = user.value(forKey: "brand_material") as! [String]
                        let inner_mat = user.value(forKey: "inner_material") as! [String]
                        let stock = user.value(forKey: "stock") as! [String]
                        let description = user.value(forKey: "description") as! [String]
                        //                        let max_order = user.value(forKey: "max_order") as! [String]
                        let rating = user.value(forKey: "rating") as! [String]
                        let Price = user.value(forKey: "price") as! [String]
                        let Photo = user.value(forKey: "photo") as! [String]
                        let Division = user.value(forKey: "division") as! [String]
                        let District = user.value(forKey: "district") as! [String]
                        
                        self.ITEMID_SAMESHOP = ItemID
                        //                                        self.SELLERID_SAMESHOP = Seller_ID
                        self.MAINCATE_SAMESHOP = Main_Cate
                        self.SUBCATE_SAMESHOP = Sub_Cate
                        self.ADDETAIL_SAMESHOP = Ad_Detail
                        self.BRAND_SAMESHOP = brand_mat
                        self.INNER_SAMESHOP = inner_mat
                        self.STOCK_SAMESHOP = stock
                        self.DESC_SAMESHOP = description
                        self.PRICE_SAMESHOP = Price
                        //                        self.MAXORDER = max_order
                        self.PHOTO_SAMESHOP = Photo
                        self.RATING_SAMESHOP = rating
                        self.DIVISION_SAMESHOP = Division
                        self.DISTRICT_SAMESHOP = District
                        
                        self.SameShopView.reloadData()
                    }
                }
        }
    }
    
    @objc func onShippingInfoClick(sender: Any){
        
        let click = self.storyboard!.instantiateViewController(identifier: "ShippingInfoViewController") as! ShippingInfoViewController
        click.ITEMID = ItemID
        if let navigator = self.navigationController {
            navigator.pushViewController(click, animated: true)
        }
    }
    
    @objc func onMoreDetailsClick(sender: Any){
        
        let click = self.storyboard!.instantiateViewController(identifier: "MoreDetailsViewController") as! MoreDetailsViewController
        click.BRAND = BRAND
        click.INNER = INNER
        click.STOCK = STOCK
        click.DISTRICT = DISTRICT
        click.DIVISION = DIVISION
        click.DESC = DESC
        if let navigator = self.navigationController {
            navigator.pushViewController(click, animated: true)
        }
    }
    
    @IBAction func onAboutSellerClick(_ sender: Any){        
        let click = self.storyboard!.instantiateViewController(identifier: "AboutSellerViewController") as! AboutSellerViewController
        click.UserID = USERID
        click.SELLERID1 = SELLERID
        click.SELLLERNAME = SELLERNAME
        click.SELLERIMAGE = SELLERIMAGE
        click.SELLERLOCATION = SELLERLOCATION
        click.SELLERPHONE = SELLERPHONE
        if let navigator = self.navigationController {
            navigator.pushViewController(click, animated: true)
        }
    }
    
    @objc func onViewReview(sender: Any){
        let click = self.storyboard!.instantiateViewController(identifier: "ViewReviewViewController") as! ViewReviewViewController
        click.ITEMID = ItemID
        if let navigator = self.navigationController {
            navigator.pushViewController(click, animated: true)
        }
    }
    
    @objc func onFromSameShopClick(sender: Any){
        let click = self.storyboard!.instantiateViewController(identifier: "AboutSellerViewController") as! AboutSellerViewController
        click.UserID = USERID
        click.SELLERID1 = SELLERID
        click.SELLLERNAME = SELLERNAME
        click.SELLERIMAGE = SELLERIMAGE
        click.SELLERLOCATION = SELLERLOCATION
        click.SELLERPHONE = SELLERPHONE
        if let navigator = self.navigationController {
            navigator.pushViewController(click, animated: true)
        }
    }
    
    @objc func openWhatsapp(sender: Any){
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ITEMID_SAMESHOP.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = collectionView.bounds
        let screenHeight = screenSize.height
        return CGSize(width: 146, height: screenHeight);
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
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FromSameShopCollectionViewCell", for: indexPath) as! FromSameShopCollectionViewCell
        
        if(lang == "ms"){
            cell.ButtonView.setTitle("VIEW".localized(lang: "ms"), for: .normal)
        }else{
            cell.ButtonView.setTitle("VIEW".localized(lang: "en"), for: .normal)
        }

        
        if let n = NumberFormatter().number(from: self.RATING_SAMESHOP[indexPath.row]) {
                    let f = CGFloat(truncating: n)
                    cell.Rating.value = f
                }

        let NEWIm = self.PHOTO_SAMESHOP[indexPath.row].addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
                
        cell.ItemImage.setImageWith(URL(string: NEWIm!)!)
        cell.ItemName.text! = self.ADDETAIL_SAMESHOP[indexPath.row]
        cell.ItemPrice.text! = self.PRICE_SAMESHOP[indexPath.row]
        cell.ButtonView.layer.cornerRadius = 5
        return cell
    }
    
    func onViewClick(cell: FromSameShopCollectionViewCell) {
        guard let indexPath = self.SameShopView.indexPath(for: cell) else{
            return
        }
        
        let viewProduct = self.storyboard!.instantiateViewController(identifier: "ViewProductViewController") as! ViewProductViewController
        viewProduct.USERID = USERID
        viewProduct.ItemID = self.ITEMID_SAMESHOP[indexPath.row]
        viewProduct.SELLERID = self.SELLERID
        viewProduct.MAINCATE = self.MAINCATE_SAMESHOP[indexPath.row]
        viewProduct.SUBCATE = self.SUBCATE_SAMESHOP[indexPath.row]
        viewProduct.ADDETAIL = self.ADDETAIL_SAMESHOP[indexPath.row]
        viewProduct.BRAND = self.BRAND_SAMESHOP[indexPath.row]
        viewProduct.INNER = self.INNER_SAMESHOP[indexPath.row]
        viewProduct.STOCK = self.STOCK_SAMESHOP[indexPath.row]
        viewProduct.DESC = self.DESC_SAMESHOP[indexPath.row]
        viewProduct.PRICE = self.PRICE_SAMESHOP[indexPath.row]
        viewProduct.PHOTO = self.PHOTO_SAMESHOP[indexPath.row]
        viewProduct.DIVISION = self.DIVISION_SAMESHOP[indexPath.row]
        viewProduct.DISTRICT = self.DISTRICT_SAMESHOP[indexPath.row]
        if let navigator = self.navigationController {
            navigator.pushViewController(viewProduct, animated: true)
        }
    }
    
    @IBAction func AddToCart(_ sender: Any) {
        
        let parameters: Parameters=[
            "seller_id": SELLERID,
            "item_id": ItemID,
            "customer_id": USERID,
            "main_category": MAINCATE,
            "sub_category": SUBCATE,
            "ad_detail": ADDETAIL,
            "price": PRICE,
            "quantity": "1",
            "division": DIVISION,
            "district": DISTRICT,
            "photo": PHOTO
        ]
        
        //Sending http post request
        Alamofire.request(URL_ADD_CART, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value {
                    let jsonData = result as! NSDictionary
                    self.spinner.indicatorView = JGProgressHUDSuccessIndicatorView()
                    self.spinner.textLabel.text = "Added to Cart"
                    if(self.lang == "ms"){
                        self.spinner.textLabel.text = "Added to Cart".localized(lang: "ms")
                        
                    }else{
                        self.spinner.textLabel.text = "Added to Cart"
                       
                    }

                    self.spinner.show(in: self.view)
                    self.spinner.dismiss(afterDelay: 4.0)
                    print(jsonData.value(forKey: "message")!)
                    
                }
        }
    }
    
}
