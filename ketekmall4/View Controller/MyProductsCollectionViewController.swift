
import UIKit
import Alamofire
import SDWebImage
import JGProgressHUD

class MyProductsCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, MyProductDelegate, UICollectionViewDelegateFlowLayout {
    
    
    private let spinner = JGProgressHUD(style: .dark)
    
    var userID: String = ""
    let URL_READ = "https://ketekmall.com/ketekmall/readuser.php";
    let URL_REMOVE = "https://ketekmall.com/ketekmall/delete_item.php";
    let URL_EDIT_BOOST = "https://ketekmall.com/ketekmall/edit_boost_ad.php";
    
    @IBOutlet var productView: UICollectionView!
    
    var category = ["Cake and pastries", "Process food", "Handicraft", "Retail and Wholesale", "Agriculture", "Service", "Health and Beauty", "home and living", "Fashion Accessories", "Sarawak - Based Product"]
    
    var ad_Detail: [String] = []
    var price: [String] = []
    var location: [String] = []
    var ItemPhoto: [String] = []
    var ItemID: [String] = []
    
    var MAINCATE: [String] = []
    var SUBCATE: [String] = []
    var BRAND: [String] = []
    var INNER: [String] = []
    var STOCK: [String] = []
    var DESC: [String] = []
    var MAXORDER: [String] = []
    var DIVISION: [String] = []
    var RATING: [String] = []
    var DELIVERY_STATUS: [String] = []
    
    var POSTCODE: [String] = []
    var WEIGHT: [String] = []
    
    let sharedPref = UserDefaults.standard
    var lang: String = ""
    
    override func viewDidAppear(_ animated: Bool) {
//        ColorFunc()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.productView.delegate = self
        self.productView.dataSource = self
        
        
        navigationItem.title = "My Products"
        spinner.show(in: self.view)
        let parameters: Parameters=[
            "user_id": userID,
        ]
        
        //Sending http post request
        Alamofire.request(URL_READ, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        self.spinner.dismiss(afterDelay: 3.0)
                        let user = jsonData.value(forKey: "read") as! NSArray
                        
                        let userID = user.value(forKey: "user_id") as! [String]
                        let AdDetail = user.value(forKey: "ad_detail") as! [String]
                        let Price = user.value(forKey: "price") as! [String]
                        let Location = user.value(forKey: "district") as! [String]
                        let Photo = user.value(forKey: "photo") as! [String]
                        let ID = user.value(forKey: "id") as! [String]
                        
                        let Main_Cate = user.value(forKey: "main_category") as! [String]
                        let Sub_Cate = user.value(forKey: "sub_category") as! [String]
                        //                        let Ad_Detail = user.value(forKey: "ad_detail") as! [String]
                        let brand_mat = user.value(forKey: "brand_material") as! [String]
                        let inner_mat = user.value(forKey: "inner_material") as! [String]
                        let stock = user.value(forKey: "stock") as! [String]
                        let description = user.value(forKey: "description") as! [String]
                        let max_order = user.value(forKey: "max_order") as! [String]
                        let rating = user.value(forKey: "rating") as! [String]
                        let delivery_status = user.value(forKey: "is_approved") as! [String]
                                                
                        let Division = user.value(forKey: "division") as! [String]
                        let PostCode = user.value(forKey: "postcode") as! [String]
                        let Weight = user.value(forKey: "weight") as! [String]
                        
                        self.ItemID = ID
                        self.ad_Detail = AdDetail
                        self.price = Price
                        self.location = Location
                        self.ItemPhoto = Photo
                        self.MAINCATE = Main_Cate
                        self.SUBCATE = Sub_Cate
                        self.MAXORDER = max_order
                        self.BRAND = brand_mat
                        self.INNER = inner_mat
                        self.STOCK = stock
                        self.DESC = description
                        self.DIVISION = Division
                        self.RATING = rating
                        self.DELIVERY_STATUS = delivery_status
                        self.POSTCODE = PostCode
                        self.WEIGHT = Weight

                        self.productView.reloadData()
                        
                    }
                }
        }
        
    }
    
    func ColorFunc(){
        let color1 = UIColor(hexString: "#FC4A1A").cgColor
                   let color2 = UIColor(hexString: "#F7B733").cgColor
                   
                   let ReceivedGradient = CAGradientLayer()
        ReceivedGradient.frame = self.view.bounds
                   ReceivedGradient.colors = [color1, color2]
                   ReceivedGradient.startPoint = CGPoint(x: 0, y: 0.5)
                   ReceivedGradient.endPoint = CGPoint(x: 1, y: 0.5)
                   ReceivedGradient.cornerRadius = 5
        self.view.layer.insertSublayer(ReceivedGradient, at: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ad_Detail.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let screenSize = collectionView.bounds
            let screenWidth = screenSize.width
    //        let screenHeight = screenSize.height
            let cellSquareSize: CGFloat = screenWidth / 2
            let cellSquareHeight: CGFloat = 420
            return CGSize(width: cellSquareSize, height: cellSquareHeight);
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyProductsCollectionViewCell", for: indexPath) as! MyProductsCollectionViewCell
        
        let NEWIm = self.ItemPhoto[indexPath.row].addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        
        cell.ItemImage.setImageWith(URL(string: NEWIm!)!)
        
        cell.ItemName.text! = self.ad_Detail[indexPath.row]
        cell.ItemPrice.text! = "MYR" + self.price[indexPath.row]
        cell.ItemLocation.text! = self.location[indexPath.row]
        
        if(self.DELIVERY_STATUS[indexPath.row] == "0"){
            cell.Btn_Boost.isHidden = true
            cell.NoDeliveryLabel.isHidden = false
            cell.PendingHeight.constant = 30
            cell.Btn_BoostHeight.constant = 0
        }else{
            cell.Btn_Boost.isHidden = false
            cell.NoDeliveryLabel.isHidden = true
            cell.PendingHeight.constant = 0
        }
        cell.Btn_Edit.layer.cornerRadius = 5
        cell.Btn_Boost.layer.cornerRadius = 5
        cell.Btn_Cancel.layer.cornerRadius = 5
        if let n = NumberFormatter().number(from: self.RATING[indexPath.row]) {
            let f = CGFloat(truncating: n)
            cell.Rating.value = f
        }
        
        if(lang == "ms"){
            cell.Btn_Edit.setTitle("Edit".localized(lang: "ms"), for: .normal)
            cell.Btn_Cancel.setTitle("Delete".localized(lang: "ms"), for: .normal)
            
        }else{
            cell.Btn_Edit.setTitle("Edit".localized(lang: "en"), for: .normal)
            cell.Btn_Cancel.setTitle("Delete".localized(lang: "en"), for: .normal)
        }

        cell.layer.cornerRadius = 5
        cell.layer.borderWidth = 0.3
        
            //Button Accept
            let color1 = UIColor(hexString: "#FC4A1A").cgColor
            let color2 = UIColor(hexString: "#F7B733").cgColor
            
            let ReceivedGradient = CAGradientLayer()
        ReceivedGradient.frame = cell.Btn_Edit.bounds
            ReceivedGradient.colors = [color1, color2]
            ReceivedGradient.startPoint = CGPoint(x: 0, y: 0.5)
            ReceivedGradient.endPoint = CGPoint(x: 1, y: 0.5)
            ReceivedGradient.cornerRadius = 5
                cell.Btn_Edit.layer.insertSublayer(ReceivedGradient, at: 0)
            
            //Button Cancel
            let color3 = UIColor(hexString: "#FC4A1A").cgColor
            let color4 = UIColor(hexString: "#F7B733").cgColor
            
            let CancelGradient = CAGradientLayer()
        CancelGradient.frame = cell.Btn_Cancel.bounds
            CancelGradient.colors = [color3, color4]
            CancelGradient.startPoint = CGPoint(x: 0, y: 0.5)
            CancelGradient.endPoint = CGPoint(x: 1, y: 0.5)
            CancelGradient.cornerRadius = 5
        cell.Btn_Cancel.layer.insertSublayer(CancelGradient, at: 0)
        
            //Button Accept
            let color5 = UIColor(hexString: "#FC4A1A").cgColor
            let color6 = UIColor(hexString: "#F7B733").cgColor
            
            let BoostGradient = CAGradientLayer()
        BoostGradient.frame = cell.Btn_Boost.bounds
            BoostGradient.colors = [color5, color6]
            BoostGradient.startPoint = CGPoint(x: 0, y: 0.5)
            BoostGradient.endPoint = CGPoint(x: 1, y: 0.5)
            BoostGradient.cornerRadius = 5
        cell.Btn_Boost.layer.insertSublayer(BoostGradient, at: 0)
            
            //Button Cancel
            let color7 = UIColor(hexString: "#ED213A").cgColor
            let color8 = UIColor(hexString: "#93291E").cgColor
            
            let NoDeliveryGradient = CAGradientLayer()
        NoDeliveryGradient.frame = cell.NoDeliveryLabel.bounds
            NoDeliveryGradient.colors = [color7, color8]
            NoDeliveryGradient.startPoint = CGPoint(x: 0, y: 0.5)
            NoDeliveryGradient.endPoint = CGPoint(x: 1, y: 0.5)
            NoDeliveryGradient.cornerRadius = 5
        cell.NoDeliveryLabel.layer.insertSublayer(NoDeliveryGradient, at: 0)
       
        
        cell.delegate = self
        return cell
    }
    
    func btnRemove(cell: MyProductsCollectionViewCell) {
        if(lang == "ms"){
            let refreshAlert = UIAlertController(title: "Delete".localized(lang: "ms"), message: "Are you sure?".localized(lang: "ms"), preferredStyle: UIAlertController.Style.alert)
            refreshAlert.addAction(UIAlertAction(title: "Yes".localized(lang: "ms"), style: .default, handler: { (action: UIAlertAction!) in
                guard let indexPath = self.productView.indexPath(for: cell) else{
                    return
                }
                
                let ID = self.ItemID[indexPath.row]
                let parameters: Parameters=[
                    "id": ID,
                ]
                
                //Sending http post request
                Alamofire.request(self.URL_REMOVE, method: .post, parameters: parameters).responseJSON
                    {
                        response in
                        if let result = response.result.value{
                            let jsonData = result as! NSDictionary
                            
                            if((jsonData.value(forKey: "success") as! NSString).boolValue){
                                self.ItemPhoto.remove(at: indexPath.row)
                                self.ad_Detail.remove(at: indexPath.row)
                                self.price.remove(at: indexPath.row)
                                self.location.remove(at: indexPath.row)
                                self.RATING.remove(at: indexPath.row)
                                self.productView.deleteItems(at: [indexPath])
                            }
                        }
                }
                return
            }))
            
            refreshAlert.addAction(UIAlertAction(title: "Cancel".localized(lang: "ms"), style: .default, handler: { (action: UIAlertAction!) in
                return
            }))
            present(refreshAlert, animated: true, completion: nil)
        }else{
            let refreshAlert = UIAlertController(title: "Delete".localized(lang: "en"), message: "Are you sure?".localized(lang: "en"), preferredStyle: UIAlertController.Style.alert)
            refreshAlert.addAction(UIAlertAction(title: "Yes".localized(lang: "en"), style: .default, handler: { (action: UIAlertAction!) in
                guard let indexPath = self.productView.indexPath(for: cell) else{
                    return
                }
                
                let ID = self.ItemID[indexPath.row]
                let parameters: Parameters=[
                    "id": ID,
                ]
                
                //Sending http post request
                Alamofire.request(self.URL_REMOVE, method: .post, parameters: parameters).responseJSON
                    {
                        response in
                        if let result = response.result.value{
                            let jsonData = result as! NSDictionary
                            
                            if((jsonData.value(forKey: "success") as! NSString).boolValue){
                                self.ItemPhoto.remove(at: indexPath.row)
                                self.ad_Detail.remove(at: indexPath.row)
                                self.price.remove(at: indexPath.row)
                                self.location.remove(at: indexPath.row)
                                self.RATING.remove(at: indexPath.row)
                                self.productView.deleteItems(at: [indexPath])
                            }
                        }
                }
                return
            }))
            
            refreshAlert.addAction(UIAlertAction(title: "Cancel".localized(lang: "en"), style: .default, handler: { (action: UIAlertAction!) in
                return
            }))
            present(refreshAlert, animated: true, completion: nil)
        }
    }
    
    func btnEdit(cell: MyProductsCollectionViewCell) {
        guard let indexPath = self.productView.indexPath(for: cell) else{
            return
        }
        
        let ProductView = self.storyboard!.instantiateViewController(withIdentifier: "EditProductViewController") as! EditProductViewController
        //        let ID = self.ItemID[indexPath.row]
        ProductView.USERID = userID
        ProductView.ITEMID = self.ItemID[indexPath.row]
        ProductView.ADDETAIL = self.ad_Detail[indexPath.row]
        ProductView.MAINCATE = self.MAINCATE[indexPath.row]
        ProductView.SUBCATE = self.SUBCATE[indexPath.row]
        ProductView.PRICE = self.price[indexPath.row]
        ProductView.BRAND = self.BRAND[indexPath.row]
        ProductView.INNER = self.INNER[indexPath.row]
        ProductView.STOCK = self.STOCK[indexPath.row]
        ProductView.DESC = self.DESC[indexPath.row]
        ProductView.DIVISION = self.DIVISION[indexPath.row]
        ProductView.DISTRICT = self.location[indexPath.row]
        ProductView.PHOTO = self.ItemPhoto[indexPath.row]
        ProductView.MAXORDER = self.MAXORDER[indexPath.row]
        ProductView.POSTCODE = self.POSTCODE[indexPath.row]
        ProductView.WEIGHT = self.WEIGHT[indexPath.row]
        if let navigator = self.navigationController {
            navigator.pushViewController(ProductView, animated: true)
        }
    }
    
    func btnBoost(cell: MyProductsCollectionViewCell) {
        guard let indexPath = self.productView.indexPath(for: cell) else{
            return
        }
        
        let ID = self.ItemID[indexPath.row]
        let parameters: Parameters=[
            "id": ID,
            "user_id": userID,
        ]
        
        //Sending http post request
        Alamofire.request(URL_EDIT_BOOST, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        self.spinner.indicatorView = JGProgressHUDSuccessIndicatorView()
                        if(self.lang == "ms"){
                            self.spinner.textLabel.text = "Added to Boost".localized(lang: "ms")
                            
                        }else{
                            self.spinner.textLabel.text = "Added to Boost"
                           
                        }
                        self.spinner.show(in: self.view)
                        self.spinner.dismiss(afterDelay: 2.0)
                    }else{
                        self.spinner.indicatorView = JGProgressHUDErrorIndicatorView()
                        self.spinner.textLabel.text = "Failed"
                        self.spinner.show(in: self.view)
                        self.spinner.dismiss(afterDelay: 2.0)
                    }
                }
        }
        
    }
}
