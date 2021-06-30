
import UIKit
import Alamofire
import AARatingBar
import JGProgressHUD

class CategoryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, CategoryDelegate, UISearchBarDelegate, UITabBarDelegate, UICollectionViewDelegateFlowLayout {
    
    let URL_ADD_FAV = "https://ketekmall.com/ketekmall/add_to_fav.php"
    let URL_ADD_CART = "https://ketekmall.com/ketekmall/add_to_cart.php"
    let URL_READ_CART = "https://ketekmall.com/ketekmall/readcart_single.php"
    
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
    var POSTCODE: [String] = []
    var WEIGHT: [String] = []
    
    var arr = [Any]()
    
    var UserID: String = ""
    var URL_READ: String = ""
    var URL_SEARCH: String = ""
    var URL_FILTER_DISTRICT: String = ""
    var URL_FILTER_DIVISION: String = ""
    var URL_FILTER_SEARCH_DIVISION: String = ""
    var URL_PRICE_UP_READALL: String = ""
    var URL_PRICE_DOWN: String = ""
    
    var DivisionFilter: String = ""
    var DistricFilter: String = ""

    var SELLERID1: String = ""
    var MAINCATE1: String = ""
    var SUBCATE1: String = ""
    var BRAND1: String = ""
    var INNER1: String = ""
    var STOCK1: String = ""
    var DESC1: String = ""
    var MAXORDER1: String = ""
    var DIVISION1: String = ""
    var RATING1: String = ""
    var ITEMID1: String = ""
    var ADDETAIL1: String = ""
    var PRICE1: String = ""
    var PHOTO1: String = ""
    var DISTRICT1: String = ""
    var POSTCODE1: String = ""
    var WEIGHT1: String = ""
    
    let sharedPref = UserDefaults.standard
    var lang: String = ""
    
    var CheckPage: Bool = true
    
    @IBOutlet weak var SearchBar: UISearchBar!
    @IBOutlet weak var Tabbar: UITabBar!
    @IBOutlet weak var ButtonFilter: UIButton!
    @IBOutlet weak var ButtonPriceUp: UIButton!
    @IBOutlet weak var ButtonPriceDown: UIButton!
    @IBOutlet weak var CategoryView: UICollectionView!
    
    @IBAction func Filter(_ sender: Any) {
        let filter = self.storyboard!.instantiateViewController(withIdentifier: "FilterViewController") as! FilterViewController
        filter.DivisionFilter = DivisionFilter
//        filter.DistricFilter = DistricFilter
        filter.URL_READ = URL_READ
        filter.URL_FILTER_DIVISION = URL_FILTER_DIVISION
        filter.URL_FILTER_DISTRICT = URL_FILTER_DISTRICT
        filter.URL_SEARCH = URL_SEARCH
        filter.URL_FILTER_SEARCH_DIVISION = URL_FILTER_SEARCH_DIVISION
        if let navigator = self.navigationController {
            navigator.pushViewController(filter, animated: true)
        }
    }
    
    var viewController1: UIViewController?
    
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
            if(UserID == "0"){
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(CategoryViewController.back(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
        
        lang = sharedPref.string(forKey: "LANG") ?? "0"
        
        if(lang == "ms"){
            changeLanguage(str: "ms")
            
        }else{
            changeLanguage(str: "en")
        }
        
        SearchBar.delegate = self
        
        CategoryView.delegate = self
        CategoryView.dataSource = self
        
        Tabbar.delegate = self
        
        ButtonPriceUp.isHidden = true
        
        if(DivisionFilter.isEmpty && DistricFilter.isEmpty){
            ViewList()
        }else if(!DivisionFilter.isEmpty && DistricFilter.isEmpty){
            Filter_Division()
        }else if(!DivisionFilter.isEmpty && !DistricFilter.isEmpty){
            Filter_District()
        }
        self.hideKeyboardWhenTappedAround()
    }
    
    @objc override func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @objc func back(sender: UIBarButtonItem){
        if(CheckPage == true){
            let myRating = self.storyboard!.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            if let navigator = self.navigationController {
                navigator.pushViewController(myRating, animated: true)
            }
        }else{
            let myRating = self.storyboard!.instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
            if let navigator = self.navigationController {
                navigator.pushViewController(myRating, animated: true)
            }
        }
        
    }
    
    func changeLanguage(str: String){
        SearchBar.placeholder = "Search Here".localized(lang: str)
        Tabbar.items?[0].title = "Home".localized(lang: str)
        Tabbar.items?[1].title = "Notification".localized(lang: str)
        Tabbar.items?[2].title = "Me".localized(lang: str)
        
        ButtonPriceUp.setTitle("PRICE".localized(lang: str), for: .normal)
        ButtonPriceDown.setTitle("PRICE".localized(lang: str), for: .normal)
        ButtonFilter.setTitle("FILTER".localized(lang: str), for: .normal)
    }
    
    func onAddToFav(cell: CategoryCollectionViewCell) {
        if(UserID == "0"){
            let addProduct = self.storyboard!.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            if let navigator = self.navigationController {
                navigator.pushViewController(addProduct, animated: true)
            }
        }else{
            let spinner = JGProgressHUD(style: .dark)
            guard let indexPath = self.CategoryView.indexPath(for: cell) else{
                return
            }
            spinner.show(in: self.view)
            
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
                "photo": self.PHOTO[indexPath.row],
                "postcode": self.POSTCODE[indexPath.row],
                "weight": self.WEIGHT[indexPath.row]
            ]
            
            if(self.SELLERID[indexPath.row] == UserID){
                spinner.indicatorView = JGProgressHUDSuccessIndicatorView()
                if(self.lang == "ms"){
                    spinner.textLabel.text = "Sorry, cannot add your own item".localized(lang: "ms")
                    
                }else{
                    spinner.textLabel.text = "Sorry, cannot add your own item".localized(lang: "en")
                    
                }
                
                spinner.show(in: self.view)
                spinner.dismiss(afterDelay: 2.0)
            }else{
                Alamofire.request(URL_ADD_FAV, method: .post, parameters: parameters).responseJSON
                    {
                        response in
                        if let result = response.result.value {
                            let jsonData = result as! NSDictionary
                            print(jsonData.value(forKey: "message")!)
                           spinner.indicatorView = JGProgressHUDSuccessIndicatorView()
                            if(self.lang == "ms"){
                                spinner.textLabel.text = "Added to My Likes".localized(lang: "ms")
                                
                            }else{
                                spinner.textLabel.text = "Add to My Likes".localized(lang: "en")
                                
                            }
                            
                           spinner.show(in: self.view)
                           spinner.dismiss(afterDelay: 2.0)
                            
                        }
                }
            }
        }
        
        
    }
    
    func onAddToCart(cell: CategoryCollectionViewCell) {
        if(UserID == "0"){
            let addProduct = self.storyboard!.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            if let navigator = self.navigationController {
                navigator.pushViewController(addProduct, animated: true)
            }
        }else{
            let spinner = JGProgressHUD(style: .dark)
            guard let indexPath = self.CategoryView.indexPath(for: cell) else{
                return
            }

            if(POSTCODE[indexPath.row].contains("0")){
                POSTCODE[indexPath.row] = "93050"
            }
            
            if(WEIGHT[indexPath.row].contains("0.00")){
                WEIGHT[indexPath.row] = "1.00"
            }
            
            let parameters: Parameters=[
                "seller_id": SELLERID[indexPath.row],
                "item_id": ITEMID[indexPath.row],
                "customer_id": UserID,
                "main_category": MAINCATE[indexPath.row],
                "sub_category": SUBCATE[indexPath.row],
                "ad_detail": ADDETAIL[indexPath.row],
                "price": PRICE[indexPath.row],
                "quantity": "1",
                "division": DIVISION[indexPath.row],
                "postcode": POSTCODE[indexPath.row],
                "district": DISTRICT[indexPath.row],
                "photo": PHOTO[indexPath.row],
                "weight": WEIGHT[indexPath.row]
            ]
            
            if(SELLERID[indexPath.row] == UserID){
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ITEMID.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
        
        if !self.PHOTO[indexPath.row].contains("%20"){
            let NEWIm = self.PHOTO[indexPath.row].addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
            
            cell.ItemImage.setImageWith(URL(string: NEWIm!)!)
        }else{
            cell.ItemImage.setImageWith(URL(string: self.PHOTO[indexPath.row])!)
        }
        if let n = NumberFormatter().number(from: self.RATING[indexPath.row]) {
            let f = CGFloat(truncating: n)
            cell.Rating.value = f
        }
        cell.ItemName.text! = self.ADDETAIL[indexPath.row]
        cell.Price.text! = "RM" + self.PRICE[indexPath.row]
        cell.District.text! = self.DISTRICT[indexPath.row]
        
        cell.layer.cornerRadius = 5
        cell.layer.borderWidth = 0.2
        
        if(lang == "ms"){
            cell.ButtonView.setTitle("ADD TO CART".localized(lang: "ms"), for: .normal)
        }else{
            cell.ButtonView.setTitle("ADD TO CART".localized(lang: "en"), for: .normal)
        }
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = collectionView.bounds
        let screenWidth = screenSize.width
        let cellSquareSize: CGFloat = screenWidth / 2.0
        return CGSize(width: cellSquareSize, height: 238);
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
    
    @objc func onViewClick(cell: CategoryCollectionViewCell) {
        guard let indexPath = self.CategoryView.indexPath(for: cell) else{
            return
        }
        
        let viewProduct = self.storyboard!.instantiateViewController(withIdentifier: "ViewProductViewController") as! ViewProductViewController
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
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(DivisionFilter.isEmpty){
            Search(SearchValue: searchText)
            
        }else{
            Search(SearchValue: searchText, Division: DivisionFilter)
        }
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text! = ""
    }
    
    func Search(SearchValue: String, Division: String){
        let spinner = JGProgressHUD(style: .dark)
        spinner.show(in: self.view)
        let parameters: Parameters=[
            "ad_detail": SearchValue,
            "division": Division
        ]
        
        Alamofire.request(URL_FILTER_SEARCH_DIVISION, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        spinner.dismiss(afterDelay: 3.0)
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
                        let PostCode = user.value(forKey: "postcode") as? [String] ?? ["93050"]
                        let Weight = user.value(forKey: "weight") as? [String] ?? ["1.00"]
                        
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
                        self.POSTCODE = PostCode
                        self.WEIGHT = Weight
                        
                        self.CategoryView.reloadData()
                    }
                }
        }
    }
    
    func Search(SearchValue: String){
        let spinner = JGProgressHUD(style: .dark)
        spinner.show(in: self.view)
        let parameters: Parameters=[
            "ad_detail": SearchValue
        ]
        
        Alamofire.request(URL_SEARCH, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        spinner.dismiss(afterDelay: 3.0)
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
                        let PostCode = user.value(forKey: "postcode") as? [String] ?? ["93050"]
                        let Weight = user.value(forKey: "weight") as? [String] ?? ["1.00"]
                        
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
                        self.POSTCODE = PostCode
                        self.WEIGHT = Weight

                        self.CategoryView.reloadData()
                        
                    }
                }
        }
    }
    
    func Filter_Division(){
        let spinner = JGProgressHUD(style: .dark)
        spinner.show(in: self.view)
        let parameters: Parameters=[
            "division": DivisionFilter
        ]
        
        Alamofire.request(URL_FILTER_DIVISION, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        spinner.dismiss(afterDelay: 3.0)
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
                        let PostCode = user.value(forKey: "postcode") as? [String] ?? ["93050"]
                         let Weight = user.value(forKey: "weight") as? [String] ?? ["1.00"]
                        
                        
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
                        self.POSTCODE = PostCode
                         self.WEIGHT = Weight

                        self.CategoryView.reloadData()
                    }
                }
        }
    }
    
    func Filter_District(){
        let spinner = JGProgressHUD(style: .dark)
        spinner.show(in: self.view)
        let parameters: Parameters=[
            "division": DivisionFilter,
            "district": DistricFilter
        ]
        
        Alamofire.request(URL_FILTER_DISTRICT, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        spinner.dismiss(afterDelay: 3.0)
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
                        let PostCode = user.value(forKey: "postcode") as? [String] ?? ["93050"]
                        let Weight = user.value(forKey: "weight") as? [String] ?? ["1.00"]

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
                        self.POSTCODE = PostCode
                         self.WEIGHT = Weight

                        self.CategoryView.reloadData()
                    }
                }
        }
    }
    
    func ViewList(){
        let spinner = JGProgressHUD(style: .dark)
        spinner.show(in: self.view)
        Alamofire.request(URL_READ, method: .post).responseJSON
            {
                response in
                if let result = response.result.value as? Dictionary<String,Any>{
                    if let list = result["read"] as? [Dictionary<String,Any>]{
                        spinner.dismiss(afterDelay: 3.0)
                        for i in list{
                            self.ITEMID1 = i["id"] as! String
                            self.ADDETAIL1 = i["ad_detail"] as! String
                            self.PHOTO1 = i["photo"] as! String
                            self.PRICE1 = i["price"] as! String
                            self.MAINCATE1 = i["main_category"] as! String
                            self.SUBCATE1 = i["sub_category"] as! String
                            self.DIVISION1 = i["division"] as! String
                            self.DISTRICT1 = i["district"] as! String
                            self.BRAND1 = i["brand_material"] as! String
                            self.INNER1 = i["inner_material"] as! String
                            self.STOCK1 = i["stock"] as! String
                            self.DESC1 = i["description"] as! String
                            self.SELLERID1 = i["user_id"] as! String
                            self.RATING1 = i["rating"] as! String
                            self.POSTCODE1 = i["postcode"] as? String ?? "93050"
                            self.WEIGHT1 = i["weight"] as? String ?? "1.00"
                            
                            self.SELLERID.append(self.SELLERID1)
                            self.ITEMID.append(self.ITEMID1)
                            self.ADDETAIL.append(self.ADDETAIL1)
                            self.MAINCATE.append(self.MAINCATE1)
                            self.SUBCATE.append(self.SUBCATE1)
                            self.BRAND.append(self.BRAND1)
                            self.INNER.append(self.INNER1)
                            self.STOCK.append(self.STOCK1)
                            self.DESC.append(self.DESC1)
                            self.DIVISION.append(self.DIVISION1)
                            self.DISTRICT.append(self.DISTRICT1)
                            self.RATING.append(self.RATING1)
                            self.PHOTO.append(self.PHOTO1)
                            self.PRICE.append(self.PRICE1)
                            self.POSTCODE.append(self.POSTCODE1)
                            self.WEIGHT.append(self.WEIGHT1)
                            
                            self.CategoryView.reloadData()
                        }
                    }
                    
                }
        }
    }
    
    @IBAction func PriceUp(_ sender: Any) {
        let spinner = JGProgressHUD(style: .dark)
        ButtonPriceDown.isHidden = false
        ButtonPriceUp.isHidden = true
        
        spinner.show(in: self.view)
        self.ITEMID.removeAll()
        self.SELLERID.removeAll()
        self.ADDETAIL.removeAll()
        self.MAINCATE.removeAll()
        self.SUBCATE.removeAll()
        self.BRAND.removeAll()
        self.INNER.removeAll()
        self.STOCK.removeAll()
        self.DESC.removeAll()
        self.PRICE.removeAll()
        self.PHOTO.removeAll()
        self.DIVISION.removeAll()
        self.DISTRICT.removeAll()
        self.POSTCODE.removeAll()
        self.WEIGHT.removeAll()
        
        Alamofire.request(URL_PRICE_UP_READALL, method: .post).responseJSON
            {
                response in
                if let result = response.result.value as? Dictionary<String,Any>{
                    if let list = result["read"] as? [Dictionary<String,Any>]{
                        spinner.dismiss(afterDelay: 3.0)
                        for i in list{
                            self.ITEMID1 = i["id"] as! String
                            self.ADDETAIL1 = i["ad_detail"] as! String
                            self.PHOTO1 = i["photo"] as! String
                            self.PRICE1 = i["price"] as! String
                            self.MAINCATE1 = i["main_category"] as! String
                            self.SUBCATE1 = i["sub_category"] as! String
                            self.DIVISION1 = i["division"] as! String
                            self.DISTRICT1 = i["district"] as! String
                            self.BRAND1 = i["brand_material"] as! String
                            self.INNER1 = i["inner_material"] as! String
                            self.STOCK1 = i["stock"] as! String
                            self.DESC1 = i["description"] as! String
                            self.SELLERID1 = i["user_id"] as! String
                            self.RATING1 = i["rating"] as! String
                            self.POSTCODE1 = i["postcode"] as? String ?? "93050"
                            self.WEIGHT1 = i["weight"] as? String ?? "1.00"
                            
                            self.SELLERID.append(self.SELLERID1)
                            self.ITEMID.append(self.ITEMID1)
                            self.ADDETAIL.append(self.ADDETAIL1)
                            self.MAINCATE.append(self.MAINCATE1)
                            self.SUBCATE.append(self.SUBCATE1)
                            self.BRAND.append(self.BRAND1)
                            self.INNER.append(self.INNER1)
                            self.STOCK.append(self.STOCK1)
                            self.DESC.append(self.DESC1)
                            self.DIVISION.append(self.DIVISION1)
                            self.DISTRICT.append(self.DISTRICT1)
                            self.RATING.append(self.RATING1)
                            self.PHOTO.append(self.PHOTO1)
                            self.PRICE.append(self.PRICE1)
                            self.POSTCODE.append(self.POSTCODE1)
                            self.WEIGHT.append(self.WEIGHT1)
                            
                            self.CategoryView.reloadData()
                        }
                    }
                    
                }
        }
    }
    
    @IBAction func PriceDown(_ sender: Any) {
        let spinner = JGProgressHUD(style: .dark)
        spinner.show(in: self.view)
        ButtonPriceDown.isHidden = true
        ButtonPriceUp.isHidden = false
        
        self.ITEMID.removeAll()
        self.SELLERID.removeAll()
        self.ADDETAIL.removeAll()
        self.MAINCATE.removeAll()
        self.SUBCATE.removeAll()
        self.BRAND.removeAll()
        self.INNER.removeAll()
        self.STOCK.removeAll()
        self.DESC.removeAll()
        self.PRICE.removeAll()
        self.PHOTO.removeAll()
        self.DIVISION.removeAll()
        self.DISTRICT.removeAll()
        self.POSTCODE.removeAll()
        self.WEIGHT.removeAll()
        
        //        print(self.ADDETAIL.count)
        Alamofire.request(URL_PRICE_DOWN, method: .post).responseJSON
            {
                response in
                if let result = response.result.value as? Dictionary<String,Any>{
                    if let list = result["read"] as? [Dictionary<String,Any>]{
                        spinner.dismiss(afterDelay: 3.0)
                        for i in list{
                            self.ITEMID1 = i["id"] as! String
                            self.ADDETAIL1 = i["ad_detail"] as! String
                            self.PHOTO1 = i["photo"] as! String
                            self.PRICE1 = i["price"] as! String
                            self.MAINCATE1 = i["main_category"] as! String
                            self.SUBCATE1 = i["sub_category"] as! String
                            self.DIVISION1 = i["division"] as! String
                            self.DISTRICT1 = i["district"] as! String
                            self.BRAND1 = i["brand_material"] as! String
                            self.INNER1 = i["inner_material"] as! String
                            self.STOCK1 = i["stock"] as! String
                            self.DESC1 = i["description"] as! String
                            self.SELLERID1 = i["user_id"] as! String
                            self.RATING1 = i["rating"] as! String
                            self.POSTCODE1 = i["postcode"] as? String ?? "93050"
                            self.WEIGHT1 = i["weight"] as? String ?? "1.00"
                            
                            self.SELLERID.append(self.SELLERID1)
                            self.ITEMID.append(self.ITEMID1)
                            self.ADDETAIL.append(self.ADDETAIL1)
                            self.MAINCATE.append(self.MAINCATE1)
                            self.SUBCATE.append(self.SUBCATE1)
                            self.BRAND.append(self.BRAND1)
                            self.INNER.append(self.INNER1)
                            self.STOCK.append(self.STOCK1)
                            self.DESC.append(self.DESC1)
                            self.DIVISION.append(self.DIVISION1)
                            self.DISTRICT.append(self.DISTRICT1)
                            self.RATING.append(self.RATING1)
                            self.PHOTO.append(self.PHOTO1)
                            self.PRICE.append(self.PRICE1)
                            self.POSTCODE.append(self.POSTCODE1)
                            self.WEIGHT.append(self.WEIGHT1)
                            
                            self.CategoryView.reloadData()
                        }
                    }
                    
                }
        }
    }
}


