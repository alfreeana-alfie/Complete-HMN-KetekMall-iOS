
import UIKit
import Alamofire
import AFNetworking
import SDWebImage
import AARatingBar
import JGProgressHUD
import ImageSlideshow

class ViewProductViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITabBarDelegate, UICollectionViewDelegateFlowLayout, FromSameShopDelegate {
    
    func onAddToCart2(cell: FromSameShopCollectionViewCell) {
        if(USERID == "0"){
            let addProduct = self.storyboard!.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            if let navigator = self.navigationController {
                navigator.pushViewController(addProduct, animated: true)
            }
        }else{
            let spinner = JGProgressHUD(style: .dark)
            guard let indexPath = self.SameShopView.indexPath(for: cell) else{
                return
            }

            if(POSTCODE_SAMESHOP[indexPath.row].contains("0")){
                POSTCODE_SAMESHOP[indexPath.row] = "93050"
            }

            if(WEIGHT_SAMESHOP[indexPath.row].contains("0.00")){
                WEIGHT_SAMESHOP[indexPath.row] = "1.00"
            }
            
            let parameters: Parameters=[
                "seller_id": SELLERID,
                "item_id": ITEMID_SAMESHOP[indexPath.row],
                "customer_id": USERID,
                "main_category": MAINCATE_SAMESHOP[indexPath.row],
                "sub_category": SUBCATE_SAMESHOP[indexPath.row],
                "ad_detail": ADDETAIL_SAMESHOP[indexPath.row],
                "price": PRICE_SAMESHOP[indexPath.row],
                "quantity": "1",
                "division": DIVISION_SAMESHOP[indexPath.row],
                "postcode": POSTCODE_SAMESHOP[indexPath.row],
                "district": DISTRICT_SAMESHOP[indexPath.row],
                "photo": PHOTO_SAMESHOP[indexPath.row],
                "weight": WEIGHT_SAMESHOP[indexPath.row]
            ]
            
            if(SELLERID == USERID){
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

    let sharedPref = UserDefaults.standard
    var lang: String = ""
    var email_user: String = ""

//    private let spinner = JGProgressHUD(style: .dark)
    
    @IBOutlet weak var ButtonChat: UIImageView!
    @IBOutlet weak var ItemImage: UIImageView!
    @IBOutlet weak var ItemName: UILabel!
    @IBOutlet weak var ItemPrice: UILabel!
    @IBOutlet weak var Sold: UILabel!
//    @IBOutlet weak var ShippingInfo: UILabel!
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
    
    
//    @IBOutlet weak var ShippingRight: UIImageView!
    @IBOutlet weak var MoreRight: UIButton!
    @IBOutlet weak var ReviewView: UIView!
    @IBOutlet weak var NoReviewLabel: UILabel!
    
    @IBOutlet weak var Carousel: ImageSlideshow!
    
    var viewController1: UIViewController?
    let pageIndicator = UIPageControl()
    
    let URL_ADD_CART = "https://ketekmall.com/ketekmall/add_to_cart.php"
    let URL_READ_SELLER = "https://ketekmall.com/ketekmall/read_order_done_seller.php"
    let URL_READ_REVIEW = "https://ketekmall.com/ketekmall/read_review.php"
    let URL_READ_DELIVERY = "https://ketekmall.com/ketekmall/read_delivery_single.php"
    let URL_READ = "https://ketekmall.com/ketekmall/read_detail.php"
    let URL_EDIT_RATING = "https://ketekmall.com/ketekmall/edit_detail_rating.php"
    let URL_EDIT_SOLD = "https://ketekmall.com/ketekmall/edit_detail_sold.php"
    let URL_READALL_SELLER = "https://ketekmall.com/ketekmall/readall_seller.php"
    let MAIN_PHOTO = "https://ketekmall.com/ketekmall/profile_image/main_photo.png"
    let URL_READ_PHOTO = "https://ketekmall.com/ketekmall/products_img/read_photo.php"
    let URL_READ_CART = "https://ketekmall.com/ketekmall/readcart_single.php"
    let URL_READ_CART_TWO = "https://ketekmall.com/ketekmall/readcart_single_ios.php"

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
    var POSTCODE: String = ""
    var WEIGHT: String = ""
    
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
    var POSTCODE_SAMESHOP: [String] = []
    var WEIGHT_SAMESHOP: [String] = []
    
    
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
    
    override func viewDidAppear(_ animated: Bool) {
//        ColorFunc()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NoReviewLabel.isHidden = true
        lang = sharedPref.string(forKey: "LANG") ?? "0"
        email_user = sharedPref.string(forKey: "EMAIL") ?? "0"
        
        print("POSTCODE: \(USERID)")
        
        if(lang == "ms"){
            changeLanguage(str: "ms")
            
        }else{
            changeLanguage(str: "en")
            
        }
        Tabbar.delegate = self
        
        SameShopView.delegate = self
        SameShopView.dataSource = self
        
        
        ViewButton.layer.cornerRadius = 10
        ViewButton.layer.borderWidth = 1
        if #available(iOS 13.0, *) {
            ViewButton.layer.borderColor = CGColor(srgbRed: 1.000, green: 0.765, blue: 0.000, alpha: 1.000)
        } else {
            // Fallback on earlier versions
        }
        SellerImage.layer.cornerRadius = SellerImage.frame.width / 2
        SellerImage.layer.masksToBounds = true
        ButtonAddCart.layer.cornerRadius = 40
        ButtonAddCart.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        let NEWIm = PHOTO.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        
        ItemImage.setImageWith(URL(string: NEWIm!)!)
        
        
        ItemName.text! = ADDETAIL
        ItemPrice.text! = "MYR" + PRICE
        
        self.pageIndicator.currentPageIndicatorTintColor = UIColor.darkGray
        self.pageIndicator.pageIndicatorTintColor = UIColor.lightGray
        self.Carousel.pageIndicator = self.pageIndicator
        
        ViewPhoto()

        
        ButtonChat.isUserInteractionEnabled = true
//        ShippingInfo.isUserInteractionEnabled = true
//        ShippingRight.isUserInteractionEnabled = true
        MoreDetails.isUserInteractionEnabled = true
        MoreRight.isUserInteractionEnabled = true
        ViewReview.isUserInteractionEnabled = true
        ViewSameShop.isUserInteractionEnabled = true
        WhatsappButton.isUserInteractionEnabled = true
        
        
        let Chat_Click = UITapGestureRecognizer(target: self, action: #selector(onChatClick(sender:)))
        _ = UITapGestureRecognizer(target: self, action: #selector(onShippingInfoClick(sender:)))
        let MoreDetails_Click = UITapGestureRecognizer(target: self, action: #selector(onMoreDetailsClick(sender:)))
        
        let ViewReview_Click = UITapGestureRecognizer(target: self, action: #selector(onViewReview(sender:)))
        let ViewSameShop_Click = UITapGestureRecognizer(target: self, action: #selector(onFromSameShopClick(sender:)))
        
        let Whatsapp_Click = UITapGestureRecognizer(target: self, action: #selector(openWhatsapp(sender:)))
        
//        ShippingInfo.addGestureRecognizer(ShippingInfo_Click)
        MoreDetails.addGestureRecognizer(MoreDetails_Click)
//        ShippingRight.addGestureRecognizer(ShippingInfo_Click)
        MoreRight.addGestureRecognizer(MoreDetails_Click)
        ViewReview.addGestureRecognizer(ViewReview_Click)
        ViewSameShop.addGestureRecognizer(ViewSameShop_Click)
        WhatsappButton.addGestureRecognizer(Whatsapp_Click)
        ButtonChat.addGestureRecognizer(Chat_Click)
        
        getSellerDetails()
        getReview()
        getSold()
        SameShopList()
    }
    
    func changeLanguage(str: String){
        SoldLabel.text = "Sold".localized(lang: str)
//        ShippingInfo.text = "Shipping Information".localized(lang: str)
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
            if(USERID == "0"){
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
        let colorViewOne = UIColor(hexString: "#FC4A1A").cgColor
        let colorViewTwo = UIColor(hexString: "#F7B733").cgColor
        
        let ViewGradient = CAGradientLayer()
        ViewGradient.frame = self.view.bounds
        ViewGradient.colors = [colorViewOne, colorViewTwo]
        ViewGradient.startPoint = CGPoint(x: 0, y: 0.5)
        ViewGradient.endPoint = CGPoint(x: 1, y: 0.5)
        ViewGradient.cornerRadius = 16
        self.view.layer.insertSublayer(ViewGradient, at: 0)
        
        let colorAddCartOne = UIColor(hexString: "#AA076B").cgColor
        let colorAddCartTwo = UIColor(hexString: "#61045F").cgColor
        
        let AddCartGradient = CAGradientLayer()
        AddCartGradient.frame = self.view.bounds
        AddCartGradient.colors = [colorAddCartOne, colorAddCartTwo]
        AddCartGradient.startPoint = CGPoint(x: 0, y: 0.5)
        AddCartGradient.endPoint = CGPoint(x: 1, y: 0.5)
        AddCartGradient.cornerRadius = 5
        self.view.layer.insertSublayer(AddCartGradient, at: 0)
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
                            
                            self.ReviewName.isHidden = true
                            self.Review.isHidden = true
                            self.ReviewImage.isHidden = true
                            self.Rating.isHidden = true
                            self.ViewReview.isHidden = true
                            self.NoReviewLabel.isHidden = false
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
        let spinner = JGProgressHUD(style: .dark)

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
                        spinner.dismiss(afterDelay: 3.0)
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
                        
                        let PostCode = user.value(forKey: "postcode") as! [String]
                        let Weight = user.value(forKey: "weight") as! [String]
                        
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
                        
                        self.POSTCODE_SAMESHOP = PostCode
                        self.WEIGHT_SAMESHOP = Weight
                        self.SameShopView.reloadData()
                    }
                }
        }
    }
    
    @objc func onChatClick(sender: Any){
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
    
    @objc func onShippingInfoClick(sender: Any){
        
        let click = self.storyboard!.instantiateViewController(withIdentifier: "ShippingInfoViewController") as! ShippingInfoViewController
        click.ITEMID = ItemID
        if let navigator = self.navigationController {
            navigator.pushViewController(click, animated: true)
        }
    }
    
    @objc func onMoreDetailsClick(sender: Any){
        
        let click = self.storyboard!.instantiateViewController(withIdentifier: "MoreDetailsViewController") as! MoreDetailsViewController
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
        let click = self.storyboard!.instantiateViewController(withIdentifier: "AboutSellerViewController") as! AboutSellerViewController
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
        let click = self.storyboard!.instantiateViewController(withIdentifier: "ViewReviewViewController") as! ViewReviewViewController
        click.ITEMID = ItemID
        if let navigator = self.navigationController {
            navigator.pushViewController(click, animated: true)
        }
    }
    
    @objc func onFromSameShopClick(sender: Any){
        let click = self.storyboard!.instantiateViewController(withIdentifier: "AboutSellerViewController") as! AboutSellerViewController
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
        let urlWhats = "whatsapp://send?phone=" + "+60" + SELLERPHONE
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
    
    func ViewPhoto(){
        var ImageKing = [KingfisherSource]()
        let parameters: Parameters=[
            "ad_detail": ADDETAIL
        ]
        
        Alamofire.request(URL_READ_PHOTO, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value as? Dictionary<String, Any>{
                    if let list = result["read"] as? [Dictionary<String, Any>]{
                        if(list.count == 0){
                            self.ItemImage.isHidden = false
                        }else{
                            self.ItemImage.isHidden = true
                            for i in list{
                                let photo = i["filepath"] as! String
                                
                                let NEWIm = photo.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
                                
                                let image = KingfisherSource(urlString: NEWIm!)
                                ImageKing.append(image!)
                            }
                            self.Carousel.setImageInputs(ImageKing)
                            self.Carousel.contentScaleMode = .scaleAspectFill
                        }
                        
                    }
                }
                
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ITEMID_SAMESHOP.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FromSameShopCollectionViewCell", for: indexPath) as! FromSameShopCollectionViewCell
        
        if(lang == "ms"){
            cell.ButtonView.setTitle("ADD TO CART".localized(lang: "ms"), for: .normal)
        }else{
            cell.ButtonView.setTitle("ADD TO CART".localized(lang: "en"), for: .normal)
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
        cell.layer.cornerRadius = 5
        
        let colorViewOne = UIColor(hexString: "#FC4A1A").cgColor
        let colorViewTwo = UIColor(hexString: "#F7B733").cgColor

        let ViewGradient = CAGradientLayer()
        ViewGradient.frame = cell.ButtonView.bounds
        ViewGradient.colors = [colorViewOne, colorViewTwo]
        ViewGradient.startPoint = CGPoint(x: 0, y: 0.5)
        ViewGradient.endPoint = CGPoint(x: 1, y: 0.5)
        ViewGradient.cornerRadius = 16
        cell.ButtonView.layer.insertSublayer(ViewGradient, at: 0)
        
        cell.delegate = self
        return cell
    }
    
    func onViewClick(cell: FromSameShopCollectionViewCell) {
        guard let indexPath = self.SameShopView.indexPath(for: cell) else{
            return
        }
        
        let viewProduct = self.storyboard!.instantiateViewController(withIdentifier: "ViewProductViewController") as! ViewProductViewController
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
        viewProduct.POSTCODE = self.POSTCODE_SAMESHOP[indexPath.row]
        viewProduct.WEIGHT = self.WEIGHT_SAMESHOP[indexPath.row]
        
        
        if let navigator = self.navigationController {
            navigator.pushViewController(viewProduct, animated: true)
        }
    }
    
    @IBAction func AddToCart(_ sender: Any) {
        if(USERID == "0"){
            let addProduct = self.storyboard!.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            if let navigator = self.navigationController {
                navigator.pushViewController(addProduct, animated: true)
            }
        }else{
            let spinner = JGProgressHUD(style: .dark)

                if(POSTCODE.contains("0")){
                    POSTCODE = "93050"
                }
                
                if(WEIGHT.contains("0.00")){
                    WEIGHT = "1.00"
                }
                
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
                    "postcode": POSTCODE,
                    "district": DISTRICT,
                    "photo": PHOTO,
                    "weight": WEIGHT
                ]
                
                if(SELLERID == USERID){
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
        
    
}
