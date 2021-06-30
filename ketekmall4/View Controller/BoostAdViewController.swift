import UIKit
import Alamofire
import JGProgressHUD

class BoostAdViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, BoostAdDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var BoostView: UICollectionView!
    
    
    private let spinner = JGProgressHUD(style: .dark)
    var userID: String = ""
    
    let URL_READ = "https://ketekmall.com/ketekmall/read_products_boost.php";
    let URL_CANCEL = "https://ketekmall.com/ketekmall/edit_boost_ad_cancel.php";
    
    var ad_Detail: [String] = []
    var Item_Photo: [String] = []
    var item_price: [String] = []
    var item_shocking: [String] = []
    var item_id: [String] = []
    
    let sharedPref = UserDefaults.standard
    var lang: String = ""
    
    override func viewDidAppear(_ animated: Bool) {
//        CfolorFunc()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        BoostView.delegate = self
        BoostView.dataSource = self
        self.hideKeyboardWhenTappedAround()
                
        //Looks for single or multiple taps.
         let tap = UITapGestureRecognizer(target: self, action: #selector(CategoryViewController.dismissKeyboard))

        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false

        view.addGestureRecognizer(tap)

        navigationItem.title = "Boost Ad"
        let parameters: Parameters=[
            "user_id": userID,
        ]
        
        spinner.show(in: self.view)
        //Sending http post request
        Alamofire.request(URL_READ, method: .post, parameters: parameters).responseJSON
            {
                response in
                //printing response
//                print(response)
                
                //getting the json value from the server
                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        self.spinner.dismiss(afterDelay: 3.0)
                        let user = jsonData.value(forKey: "read") as! NSArray
                        
                        let ID = user.value(forKey: "id") as! [String]
                        let AdDetail = user.value(forKey: "ad_detail") as! [String]
                        let Price = user.value(forKey: "price") as! [String]
                        let Photo = user.value(forKey: "photo") as! [String]
                        let ShockingSale = user.value(forKey: "shocking_sale") as! [String]
                        
                        self.Item_Photo = Photo
                        self.item_id = ID
                        self.ad_Detail = AdDetail
                        self.item_price = Price
                        self.item_shocking = ShockingSale
                        
                        self.BoostView.reloadData()
                    }
                }
        }
    }
    
    @objc override func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
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
            let cellSquareSize: CGFloat = screenWidth
            let cellSquareHeight: CGFloat = 106
            return CGSize(width: cellSquareSize, height: cellSquareHeight);
        }
           
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0.0, right: 0.0)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 2.0
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 2.0
        }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BoostAdCollectionViewCell", for: indexPath) as! BoostAdCollectionViewCell
        
        if !self.Item_Photo[indexPath.row].contains("%20"){
            let NEWIm = self.Item_Photo[indexPath.row].addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
            
            cell.ItemImage.setImageWith(URL(string: NEWIm!)!)
        }else{
            cell.ItemImage.setImageWith(URL(string: self.Item_Photo[indexPath.row])!)
        }
        
        
        cell.ButtonCancel.layer.cornerRadius = 5
        cell.AdDetail.text! = ad_Detail[indexPath.row]
        cell.Price.text! = item_price[indexPath.row]
        let shockingStat = item_shocking[indexPath.row]
        if(shockingStat == "1"){
            cell.ShockingSale.text! = "Approved"
            cell.ShockingSale.textColor = .green
        }else{
            cell.ShockingSale.text! = "Pending Request"
            cell.ShockingSale.textColor = .red
        }
        
        if(lang == "ms"){
            cell.ButtonCancel.setTitle("Cancel".localized(lang: "ms"), for: .normal)
        }else{
            cell.ButtonCancel.setTitle("Cancel".localized(lang: "en"), for: .normal)
        }
        
        //Button Accept
            let color1 = UIColor(hexString: "#FC4A1A").cgColor
            let color2 = UIColor(hexString: "#F7B733").cgColor
            
            let ReceivedGradient = CAGradientLayer()
        ReceivedGradient.frame = cell.ButtonCancel.bounds
            ReceivedGradient.colors = [color1, color2]
            ReceivedGradient.startPoint = CGPoint(x: 0, y: 0.5)
            ReceivedGradient.endPoint = CGPoint(x: 1, y: 0.5)
            ReceivedGradient.cornerRadius = 5
                cell.ButtonCancel.layer.insertSublayer(ReceivedGradient, at: 0)
        
        cell.delegate = self
        return cell
    }
    
    func btnCANCEL(cell: BoostAdCollectionViewCell) {
        spinner.show(in: self.view)
        guard let indexPath = self.BoostView.indexPath(for: cell) else{
            return
        }
        
        let ID = self.item_id[indexPath.row]
        let parameters: Parameters=[
                    "id": ID,
                ]
                
                //Sending http post request
                Alamofire.request(URL_CANCEL, method: .post, parameters: parameters).responseJSON
                    {
                        response in
                        if let result = response.result.value{
                            let jsonData = result as! NSDictionary
                            
                            if((jsonData.value(forKey: "success") as! NSString).boolValue){
                                self.spinner.indicatorView = JGProgressHUDSuccessIndicatorView()
                                self.spinner.textLabel.text = "Success"
                                self.spinner.show(in: self.view)
                                self.spinner.dismiss(afterDelay: 3.0)
                                self.BoostView.deleteItems(at: [indexPath])
                            }
                        }else{
                            self.spinner.indicatorView = JGProgressHUDErrorIndicatorView()
                            self.spinner.textLabel.text = "Failed"
                            self.spinner.show(in: self.view)
                            self.spinner.dismiss(afterDelay: 3.0)
                        }
                }
    }
}
