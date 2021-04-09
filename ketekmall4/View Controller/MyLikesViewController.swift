
import UIKit
import Alamofire
import AFNetworking
import JGProgressHUD

class MyLikesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, MyLikesDelegate, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var MyLikesView: UICollectionView!
    
    var userID: String = ""
    
    let URL_READ = "https://ketekmall.com/ketekmall/readfav.php"
    let URL_DELETE = "https://ketekmall.com/ketekmall/delete_fav.php"
    let MAIN_PHOTO = "https://ketekmall.com/ketekmall/profile_image/main_photo.png"
    
    let sharedPref = UserDefaults.standard
    var lang: String = ""
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lang = sharedPref.string(forKey: "LANG") ?? "0"
//        userID = sharedPref.string(forKey: "USERID") ?? "0"
        print("\(userID)")

        MyLikesView.delegate = self
        MyLikesView.dataSource = self
        
        navigationItem.title = "My Likes"
        
        ViewList()
        self.hideKeyboardWhenTappedAround()
    }
    
    func ViewList(){
        let spinner = JGProgressHUD(style: .dark)
        spinner.show(in: self.view)
        let parameters: Parameters=[
            "customer_id": userID,
        ]
        Alamofire.request(URL_READ, method: .post, parameters: parameters).responseJSON
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
                            self.SELLERID1 = i["seller_id"] as! String
                            self.RATING1 = i["rating"] as! String
                            self.POSTCODE1 = i["postcode"] as! String
                            self.WEIGHT1 = i["weight"] as! String

                            self.SELLERID.append(self.SELLERID1)
                            self.ITEMID.append(self.ITEMID1)
                            self.ADDETAIL.append(self.ADDETAIL1)
                            self.MAINCATE.append(self.MAINCATE1)
                            self.SUBCATE.append(self.MAINCATE1)
                            self.BRAND.append(self.BRAND1)
                            self.INNER.append(self.BRAND1)
                            self.STOCK.append(self.STOCK1)
                            self.DESC.append(self.DESC1)
                            self.DIVISION.append(self.DIVISION1)
                            self.DISTRICT.append(self.DISTRICT1)
                            self.RATING.append(self.RATING1)
                            self.PHOTO.append(self.PHOTO1)
                            self.PRICE.append(self.PRICE1)
                            self.POSTCODE.append(self.POSTCODE1)
                            self.WEIGHT.append(self.WEIGHT1)

                            self.MyLikesView.reloadData()
                        }
                    }

                }
        }
    }
 
    @objc override func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }


    func Colorfunc(){
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.ITEMID.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = collectionView.bounds
        let screenWidth = screenSize.width
//        let screenHeight = screenSize.height
        let cellSquareSize: CGFloat = screenWidth / 2.0
        let cellSquareHeight: CGFloat = 286
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyLikesCollectionViewCell", for: indexPath) as! MyLikesCollectionViewCell
        if !self.PHOTO[indexPath.row].contains("%20"){
            print("contain whitespace \(self.PHOTO[indexPath.row].trimmingCharacters(in: .whitespaces))")
            let NEWIm = self.PHOTO[indexPath.row].addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
            
            cell.ItemImage.setImageWith(URL(string: NEWIm!)!)
        }else{
            print("contain whitespace")
            
            cell.ItemImage.setImageWith(URL(string: self.PHOTO[indexPath.row])!)
        }
        
        cell.ItemName.text! = self.ADDETAIL[indexPath.row]
        cell.ItemPrice.text! = "RM" + self.PRICE[indexPath.row]
        cell.ItemLocation.text! = self.DISTRICT[indexPath.row]
        
        cell.BtnView.layer.cornerRadius = 5
        cell.BtnRemove.layer.cornerRadius = 5
        
        if(self.lang == "ms"){
            cell.BtnView.setTitle("VIEW".localized(lang: "ms"), for: .normal)
            cell.BtnRemove.setTitle("REMOVE".localized(lang: "ms"), for: .normal)

        }else{
            cell.BtnView.setTitle("VIEW".localized(lang: "en"), for: .normal)
            cell.BtnRemove.setTitle("REMOVE".localized(lang: "en"), for: .normal)
        }
        
        if let n = NumberFormatter().number(from: self.RATING[indexPath.row]) {
            let f = CGFloat(truncating: n)
            cell.RatingBar.value = f
        }
        
        cell.layer.borderWidth = 0.3
        cell.layer.cornerRadius = 5
        cell.delegate = self
        return cell
    }
    
    func btnVIEW(cell: MyLikesCollectionViewCell) {
        guard let indexPath = self.MyLikesView.indexPath(for: cell) else{
            return
        }
        
        let viewProduct = self.storyboard!.instantiateViewController(withIdentifier: "ViewProductViewController") as! ViewProductViewController
        viewProduct.USERID = userID
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
    
    func btnRemove(cell: MyLikesCollectionViewCell) {
        let spinner = JGProgressHUD(style: .dark)
        if(lang == "ms"){
            let refreshAlert = UIAlertController(title: "Remove".localized(lang: "ms"), message: "Are you sure?".localized(lang: "ms"), preferredStyle: UIAlertController.Style.alert)
            refreshAlert.addAction(UIAlertAction(title: "Yes".localized(lang: "ms"), style: .default, handler: { (action: UIAlertAction!) in
                
                guard let indexPath = self.MyLikesView.indexPath(for: cell) else{
                    return
                }
                
                let ID = self.ITEMID[indexPath.row]
                print("\(ID)")
                self.ADDETAIL.remove(at: indexPath.row)
                self.DISTRICT.remove(at: indexPath.row)
                self.RATING.remove(at: indexPath.row)
                self.PHOTO.remove(at: indexPath.row)
                self.MyLikesView.deleteItems(at: [indexPath])
                let parameters: Parameters=[
                            "id": ID,
                        ]

                        //Sending http post request
                Alamofire.request(self.URL_DELETE, method: .post, parameters: parameters).responseJSON
                            {
                                response in
                                if let result = response.result.value{
                                    let jsonData = result as! NSDictionary

                                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                                        print("SUCCESS")
                                        spinner.indicatorView = JGProgressHUDSuccessIndicatorView()


                                        if(self.lang == "ms"){
                                            spinner.textLabel.text = "Successfully Remove".localized(lang: "ms")

                                        }else{
                                            spinner.textLabel.text = "Successfully Remove".localized(lang: "en")

                                        }
                                        spinner.show(in: self.view)
                                        spinner.dismiss(afterDelay: 4.0)
                                        self.ITEMID.remove(at: indexPath.row)
                                        self.ADDETAIL.remove(at: indexPath.row)
                                        self.DISTRICT.remove(at: indexPath.row)
                                        self.RATING.remove(at: indexPath.row)
                                        self.PHOTO.remove(at: indexPath.row)
                                        self.MyLikesView.deleteItems(at: [indexPath])
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
            let spinner = JGProgressHUD(style: .dark)
            let refreshAlert = UIAlertController(title: "Remove".localized(lang: "en"), message: "Are you sure?".localized(lang: "en"), preferredStyle: UIAlertController.Style.alert)
            refreshAlert.addAction(UIAlertAction(title: "Yes".localized(lang: "en"), style: .default, handler: { (action: UIAlertAction!) in
                
                guard let indexPath = self.MyLikesView.indexPath(for: cell) else{
                    return
                }
                
                let ID = self.ITEMID[indexPath.row]
                let parameters: Parameters=[
                            "id": ID,
                        ]
                        
                        //Sending http post request
                Alamofire.request(self.URL_DELETE, method: .post, parameters: parameters).responseJSON
                            {
                                response in
                                if let result = response.result.value{
                                    let jsonData = result as! NSDictionary
                                    
                                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                                        print("SUCCESS")
                                        spinner.indicatorView = JGProgressHUDSuccessIndicatorView()
                                    
                                        
                                        if(self.lang == "ms"){
                                            spinner.textLabel.text = "Successfully Remove".localized(lang: "ms")
                                            
                                        }else{
                                            spinner.textLabel.text = "Successfully Remove".localized(lang: "en")
                                           
                                        }
                                        spinner.show(in: self.view)
                                        spinner.dismiss(afterDelay: 4.0)
                                        self.ITEMID.remove(at: indexPath.row)
                                        self.ADDETAIL.remove(at: indexPath.row)
                                        self.DISTRICT.remove(at: indexPath.row)
                                        self.RATING.remove(at: indexPath.row)
                                        self.PHOTO.remove(at: indexPath.row)
                                        self.MyLikesView.deleteItems(at: [indexPath])
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
}
