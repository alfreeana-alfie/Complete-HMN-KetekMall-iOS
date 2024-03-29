
import UIKit
import Alamofire
import AFNetworking
import JGProgressHUD

class MyLikesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, MyLikesDelegate, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var MyLikesView: UICollectionView!
    
    var userID: String = ""
    
    
    private let spinner = JGProgressHUD(style: .dark)
    
    let URL_READ = "https://ketekmall.com/ketekmall/readfav.php"
    let URL_DELETE = "https://ketekmall.com/ketekmall/delete_fav.php"
    let MAIN_PHOTO = "https://ketekmall.com/ketekmall/profile_image/main_photo.png"
    
    var ItemID: [String] = []
    var ad_Detail: [String] = []
    var price: [String] = []
    var location: [String] = []
    var ItemPhoto: [String] = []
    var RATING: [String] = []
    
    let sharedPref = UserDefaults.standard
    var lang: String = ""
    
//    override func viewDidAppear(_ animated: Bool) {
//        Colorfunc()
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        lang = sharedPref.string(forKey: "LANG") ?? "0"

        MyLikesView.delegate = self
        MyLikesView.dataSource = self
        
        navigationItem.title = "My Likes"
        
        spinner.show(in: self.view)
        let parameters: Parameters=[
            "customer_id": userID,
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
                        let ID = user.value(forKey: "id") as! [String]
                        let AdDetail = user.value(forKey: "ad_detail") as! [String]
                        let Price = user.value(forKey: "price") as! [String]
                        let Location = user.value(forKey: "district") as! [String]
                        let rating = user.value(forKey: "rating") as! [String]
                        let Photo = user.value(forKey: "photo") as! [String]
                        
                        self.ItemID = ID
                        self.ad_Detail = AdDetail
                        self.price = Price
                        self.location = Location
                        self.ItemPhoto = Photo
                        self.RATING = rating
                        
//                        print(Photo)
                        self.MyLikesView.reloadData()
                        
                    }
                }
        }
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
        return ad_Detail.count
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
        let NEWIm = self.ItemPhoto[indexPath.row].addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        
        cell.ItemImage.setImageWith(URL(string: NEWIm!)!)
        cell.ItemName.text! = self.ad_Detail[indexPath.row]
        cell.ItemPrice.text! = "MYR" + self.price[indexPath.row]
        cell.ItemLocation.text! = self.location[indexPath.row]
        
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
        
        let colorViewOne = UIColor(hexString: "#FC4A1A").cgColor
        let colorViewTwo = UIColor(hexString: "#F7B733").cgColor
        
        let ViewGradient = CAGradientLayer()
        ViewGradient.frame = cell.BtnView.bounds
        ViewGradient.colors = [colorViewOne, colorViewTwo]
        ViewGradient.startPoint = CGPoint(x: 0, y: 0.5)
        ViewGradient.endPoint = CGPoint(x: 1, y: 0.5)
        ViewGradient.cornerRadius = 5
        cell.BtnView.layer.insertSublayer(ViewGradient, at: 0)
        
        let colorReject1 = UIColor(hexString: "#FC4A1A").cgColor
        let colorReject2 = UIColor(hexString: "#F7B733").cgColor
        
        let RejectGradient = CAGradientLayer()
        RejectGradient.frame = cell.BtnRemove.bounds
        RejectGradient.colors = [colorReject1, colorReject2]
        RejectGradient.startPoint = CGPoint(x: 0, y: 0.5)
        RejectGradient.endPoint = CGPoint(x: 1, y: 0.5)
        RejectGradient.cornerRadius = 5
        cell.BtnRemove.layer.insertSublayer(RejectGradient, at: 0)
        
        return cell
    }
    
    func btnVIEW(cell: MyLikesCollectionViewCell) {
        guard let indexPath = self.MyLikesView.indexPath(for: cell) else{
            return
        }
        
        let ViewProduct = self.storyboard!.instantiateViewController(withIdentifier: "ViewProductViewController") as! ViewProductViewController
        let ID = self.ItemID[indexPath.row]
        ViewProduct.ItemID = ID
        if let navigator = self.navigationController {
            navigator.pushViewController(ViewProduct, animated: true)
        }
    }
    
    func btnRemove(cell: MyLikesCollectionViewCell) {
        if(lang == "ms"){
            let refreshAlert = UIAlertController(title: "Remove".localized(lang: "ms"), message: "Are you sure?".localized(lang: "ms"), preferredStyle: UIAlertController.Style.alert)
            refreshAlert.addAction(UIAlertAction(title: "Yes".localized(lang: "ms"), style: .default, handler: { (action: UIAlertAction!) in
                
                guard let indexPath = self.MyLikesView.indexPath(for: cell) else{
                    return
                }
                
                let ID = self.ItemID[indexPath.row]
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
                                        self.spinner.indicatorView = JGProgressHUDSuccessIndicatorView()
                                    
                                        
                                        if(self.lang == "ms"){
                                            self.spinner.textLabel.text = "Successfully Remove".localized(lang: "ms")
                                            
                                        }else{
                                            self.spinner.textLabel.text = "Successfully Remove".localized(lang: "en")
                                           
                                        }
                                        self.spinner.show(in: self.view)
                                        self.spinner.dismiss(afterDelay: 4.0)
                                        self.ad_Detail.remove(at: indexPath.row)
                                        self.location.remove(at: indexPath.row)
                                        self.RATING.remove(at: indexPath.row)
                                        self.ItemPhoto.remove(at: indexPath.row)
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
            let refreshAlert = UIAlertController(title: "Remove".localized(lang: "en"), message: "Are you sure?".localized(lang: "en"), preferredStyle: UIAlertController.Style.alert)
            refreshAlert.addAction(UIAlertAction(title: "Yes".localized(lang: "en"), style: .default, handler: { (action: UIAlertAction!) in
                
                guard let indexPath = self.MyLikesView.indexPath(for: cell) else{
                    return
                }
                
                let ID = self.ItemID[indexPath.row]
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
                                        self.spinner.indicatorView = JGProgressHUDSuccessIndicatorView()
                                    
                                        
                                        if(self.lang == "ms"){
                                            self.spinner.textLabel.text = "Successfully Remove".localized(lang: "ms")
                                            
                                        }else{
                                            self.spinner.textLabel.text = "Successfully Remove".localized(lang: "en")
                                           
                                        }
                                        self.spinner.show(in: self.view)
                                        self.spinner.dismiss(afterDelay: 4.0)
                                        self.ad_Detail.remove(at: indexPath.row)
                                        self.location.remove(at: indexPath.row)
                                        self.RATING.remove(at: indexPath.row)
                                        self.ItemPhoto.remove(at: indexPath.row)
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
