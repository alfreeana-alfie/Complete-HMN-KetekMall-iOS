import UIKit
import Alamofire
import JGProgressHUD
import FirebaseInstanceID

class CheckoutViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITabBarDelegate, UICollectionViewDelegateFlowLayout, CheckoutDelegate {
    func onSelfClick(cell: CheckoutCollectionViewCell) {
        guard let indexPath = self.CartView.indexPath(for: cell) else{
            return
        }
        
        var newPrice: Double = 0.00
        let newWeight = Double(self.WEIGHT[indexPath.row])!
        let delivery_charge = newWeight * ceil(Double(self.DELIVERYPRICE[indexPath.row])!)
        newPrice = delivery_charge - delivery_charge
        
        cell.DeliveryPrice.text! = "RM" + String(format: "%.2f", newPrice)
        cell.ButtonSelfPickUp.isHidden = true
        
        var newGrandTotal: Double = 0.00
        let grandText: String = self.GrandTotal2.text!
        let grandDouble: Double = Double(grandText)!
        
        newGrandTotal = grandDouble
        newGrandTotal -= delivery_charge
        
        print(String(format: "%.2f", delivery_charge))
        print(String(format: "%.2f", newGrandTotal))
//        print(String(format: "%.2f", newGrandTotal))
        self.GrandTotal.text! = "RM" + String(format: "%.2f", newGrandTotal)
        self.GrandTotal2.text! = String(format: "%.2f", newGrandTotal)
//
        
    }
    
    private let spinner = JGProgressHUD(style: .dark)
    
    @IBOutlet weak var NamePhone: UILabel!
    @IBOutlet weak var Address: UITextView!
    @IBOutlet weak var GrandTotal: UILabel!
    @IBOutlet weak var GrandTotal2: UILabel!
    @IBOutlet weak var CartView: UICollectionView!
    @IBOutlet weak var Tabbar: UITabBar!
    @IBOutlet weak var ButtonPlaceOrder: UIButton!
    @IBOutlet weak var TotalLabel: UILabel!
    @IBOutlet weak var DeliveryAddressLabel: UILabel!
    @IBOutlet weak var ChangeDeliveryLabel: UILabel!
    @IBOutlet weak var GrandTotalView: UIView!
    
    var viewController1: UIViewController?
    
    //Delivery Part
    var userID: String = ""
    var NEWADDR: String = ""
    var DeliveryID: String = ""
    var DeliveryDivision: String = ""
    var DeliveryDistrict: String = ""
    var DeliveryDays: String = ""
    var DeliveryPrice: String = ""
    
    var id: String = ""
    var addetail: String = ""
    var price: String = ""
    var maincate: String = ""
    var subcate: String = ""
    var division: String = ""
    var district: String = ""
    
    var photo: String = ""
    var sellerid: String = ""
    var itemid: String = ""
    var quantity: String = ""
    var name: String = ""
    var phone_no: String = ""
    var addr01: String = ""
    var addr02: String = ""
    var divsionu: String = ""
    var postcode: String = ""
    var PaymentRefNo: String = ""
    var SharedEmail: String = ""
    
    var ID: [String] = []
    var ITEMID: [String] = []
    var MAINCATE: [String] = []
    var SUBCATE: [String] = []
    var ADDETAIL: [String] = []
    var PRICE: [String] = []
    var DIVISION: [String] = []
    var DISTRICT: [String] = []
    var PHOTO: [String] = []
    var SELLERID: [String] = []
    var QUANTITY: [String] = []
    var POSTCODE_P: [String] = []
    var WEIGHT: [String] = []
    
    var PRODUCTDESCRIPTION: [String] = []
    
    var DELIVERYDIVISION: [String] = []
    var DELIVERYDISTRICT: [String] = []
    var DELIVERYPRICE: [String] = []
    var DELIVERYDAYS: [String] = []
    var DELIVERYDATE: [String] = []
    var DELIVERYID: [String] = []
    
    var NAME: [String] = []
    var PHONE_NO: [String] = []
    var EMAIL: [String] = []
    var ADDR01: [String] = []
    var ADDR02: [String] = []
    var DIVISIONU: [String] = []
    var POSTCODE: [String] = []
    var GRANDTOTAL: String = ""
    var strGrandTotal: Double = 0.00
//    var GRANDTOTAL: [String] = []
    
    let URL_READ = "https://ketekmall.com/ketekmall/read_detail.php"
    let URL_READ_DELIVERY = "https://ketekmall.com/ketekmall/read_delivery_single_delivery.php"
    let URL_READ_DELIVERY2 = "https://ketekmall.com/ketekmall/read_detail_delivery_single.php"
    let URL_CART = "https://ketekmall.com/ketekmall/getCartTempCustomer.php"
    let URL_CHECKOUT = "https://ketekmall.com/ketekmall/add_to_checkout.php"
    let URL_SEND_EMAILBUYER = "https://ketekmall.com/ketekmall/sendEmail_buyer.php"
    let URL_SEND_EMAILSELLER = "https://ketekmall.com/ketekmall/sendEmail_seller.php"
    let URL_DELETE = "https://ketekmall.com/ketekmall/delete_cart_temp_user.php"
    let URL_USER = "https://click-1595830894120.firebaseio.com/users.json"
    
    let API_POSTCODE = "http://stagingsds.pos.com.my/apigateway/as2corporate/api/poslajudomesticbypostcode/v1";
    let serverKey_POSTCODE = "a1g2cmM2VmowNm00N1lZekFmTGR0MldpRHhKaFRHSks=";
    
    var PostCodefrom: String = "96000";
    var PostCodeTo: String = "93050";
    var Weight: String = "2";
    
    let API_PREACCEPTANCE = "https://apis.pos.com.my/apigateway/as2corporate/api/poslajubypostcodedomestic/v1"
    let serverKey_PREACCEPTANCE = "N1hHVHJFRW95cjRkQ0NyR3dialdrZUF4NGxaNm9Na1U="
    
    let URL_GET_PLAYERID = "https://ketekmall.com/ketekmall/getPlayerID.php"
    let URL_NOTI = "https://ketekmall.com/ketekmall/onesignal_noti.php"
    
    let sharedPref = UserDefaults.standard
    var lang: String = ""
    
    let sender = PushNotificationSender()
    var tokenUser: String = ""
    
    override func viewDidAppear(_ animated: Bool) {
        ColorFunc()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
//        DeleteOrder()
    }
    
    @objc override func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        lang = sharedPref.string(forKey: "LANG") ?? "0"
        SharedEmail = sharedPref.string(forKey: "EMAIL") ?? "0"
        
        PaymentRefNo = String.random()
        
        print("\(PaymentRefNo)")
        if(lang == "ms"){
            changeLanguage(str: "ms")
            
        }else{
            changeLanguage(str: "en")
            
        }
        Tabbar.delegate = self
        CartView.delegate = self
        CartView.dataSource = self
        
        GrandTotal2.isHidden = true
        ChangeDeliveryLabel.isHidden = true
        ButtonPlaceOrder.isHidden = false
        ButtonPlaceOrder.layer.cornerRadius = 7
        
        spinner.show(in: self.view)
        
        ReadCart()
        self.hideKeyboardWhenTappedAround()
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
        
        let colorPlaceOrderOne = UIColor(hexString: "#FC4A1A").cgColor
        let colorPlaceOrderTwo = UIColor(hexString: "#F7B733").cgColor
        
        let PlaceOrderGradient = CAGradientLayer()
        PlaceOrderGradient.frame = ButtonPlaceOrder.bounds
        PlaceOrderGradient.colors = [colorPlaceOrderOne, colorPlaceOrderTwo]
        PlaceOrderGradient.startPoint = CGPoint(x: 0, y: 0.5)
        PlaceOrderGradient.endPoint = CGPoint(x: 1, y: 0.5)
        PlaceOrderGradient.cornerRadius = 7
        ButtonPlaceOrder.layer.insertSublayer(PlaceOrderGradient, at: 0)
      
       
    }
    
    func ReadCart(){
        let parameters: Parameters=[
            "customer_id": userID
        ]
        
        Alamofire.request(URL_CART, method: .post, parameters: parameters).responseJSON
            {
                response in
                var strGrand: Double = 0.00
                var strGrand2: Double = 0.00
                var strCharges: Double = 0.00
                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        let user = jsonData.value(forKey: "read") as! NSArray
                        
                        self.ID = user.value(forKey: "id") as! [String]
                        self.MAINCATE = user.value(forKey: "main_category") as! [String]
                        self.SUBCATE = user.value(forKey: "sub_category") as! [String]
                        self.ADDETAIL = user.value(forKey: "ad_detail") as! [String]
                        self.PRICE = user.value(forKey: "price") as! [String]
                        self.DIVISION = user.value(forKey: "division") as! [String]
                        self.DISTRICT = user.value(forKey: "district") as! [String]
                        self.ITEMID = user.value(forKey: "item_id") as! [String]
                        self.QUANTITY = user.value(forKey: "quantity") as! [String]
                        self.PHOTO = user.value(forKey: "photo") as! [String]
                        self.SELLERID = user.value(forKey: "seller_id") as! [String]
                        self.POSTCODE_P = user.value(forKey: "postcode") as! [String]
                        self.WEIGHT = user.value(forKey: "weight") as! [String]
                        
                        
                        
                        print("\(self.DISTRICT)")
                        
                        let parameters: Parameters=[
                            "id": self.userID,
                        ]
                        Alamofire.request(self.URL_READ, method: .post, parameters: parameters).responseJSON
                            {
                                response in
                                if let result = response.result.value{
                                    let jsonData = result as! NSDictionary
                                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                                        
                                        let user = jsonData.value(forKey: "read") as! NSArray
                                        self.NAME = user.value(forKey: "name") as! [String]
                                        self.PHONE_NO = user.value(forKey: "phone_no") as! [String]
                                        self.EMAIL = user.value(forKey: "email") as! [String]
                                        self.ADDR01 = user.value(forKey: "address_01") as! [String]
                                        self.ADDR02 = user.value(forKey: "address_02") as! [String]
                                        self.DIVISIONU = user.value(forKey: "division") as! [String]
                                        self.POSTCODE = user.value(forKey: "postcode") as! [String]
                                        
                                        if(self.ADDR01[0] == "" && self.ADDR02[0] == "" && self.DIVISIONU[0] == "" && self.POSTCODE[0] == ""){
                                            self.divsionu = self.DIVISIONU[0]
                                        
                                            self.NamePhone.text! = self.NAME[0] + " | " + self.PHONE_NO[0]
                                            self.NEWADDR =  "No Address SET"
                                            self.DIVISIONU[0] = "No Address SET"
                                            self.POSTCODE[0].append("93050")
                                            self.Address.text! = self.NEWADDR
                                        }else{
                                            self.divsionu = self.DIVISIONU[0]
                                            self.NamePhone.text! = self.NAME[0] + " | " + self.PHONE_NO[0]
                                            self.NEWADDR =  self.ADDR01[0] + " " + self.ADDR02[0] + "\n" + self.DIVISIONU[0] + " " + self.POSTCODE[0]
                                            self.Address.text! = self.NEWADDR
                                        }
                                        
                                        for i in 0..<self.ID.count{
                                            let product_details = self.ADDETAIL[i] + " x" + self.QUANTITY[i]
                                            
                                            self.PRODUCTDESCRIPTION.append(product_details)
                                            
                                            strCharges = Double(Int(self.QUANTITY[i])!) * Double(self.WEIGHT[i])!
                                            
                                            let NEW_URL_PARTONE = self.API_PREACCEPTANCE + "?postcodeFrom=" + self.POSTCODE_P[i];
                                            let NEW_URL =  NEW_URL_PARTONE + "&postcodeTo=" + self.POSTCODE[0] + "&Weight=" + String(format: "%.2f", strCharges);
                                            
                                            let headers = [ "X-User-Key" : self.serverKey_PREACCEPTANCE ]
                                            
                                            let configuration = URLSessionConfiguration.default
                                            configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
                                            
                                            Alamofire.request(NEW_URL, method: .get, encoding: URLEncoding.httpBody, headers: headers).responseJSON
                                                {
                                                    response in
                                                    if let result = response.result.value {
                                                        print("SUCCESS")
                                                        let details = result as! NSArray
                                                        
                                                        let totalAmount = details.value(forKey: "totalAmount") as! [String]
                                                        
                                                        
                                                        print("JSON: \(totalAmount)")
                                                        
                                                        self.DELIVERYPRICE.append(contentsOf: totalAmount)
                                                        
                                                        strGrand += (Double(self.PRICE[i])! * Double(Int(self.QUANTITY[i])!))
                                                        
                                                        let indexPrice = i
                                                        
                                                        
                                                        if indexPrice < self.DELIVERYPRICE.count{
                                                            let newWeight: Double = Double(self.WEIGHT[i])!
                                                            let strDel: Double = newWeight * ceil(Double(self.DELIVERYPRICE[i])!)
                                                            
                                                            strGrand2 += strDel
                                                            self.strGrandTotal = strGrand + strGrand2
                                                            
                                                            self.GRANDTOTAL.append(String(format: "%.2f", self.strGrandTotal))
                                                            
                                                            self.GrandTotal.text! = "RM" + String(format: "%.2f", self.strGrandTotal)
                                                            
                                                            self.GrandTotal2.text! = String(format: "%.2f", self.strGrandTotal)
                                                            
//                                                            self.GRANDTOTAL.append(String(format: "%.2f", strGrandTotal))
//                                                            print("JSON: \(String(format: "%.2f", self.strGrandTotal))")
                                                        }
                                                        self.ButtonPlaceOrder.isHidden = false
                                                        self.TotalLabel.isHidden = false
                                                        self.GrandTotal.isHidden = false
                                                        self.spinner.dismiss(afterDelay: 3.0)
                                                        self.CartView.reloadData()
                                                    }
                                            }
                                        }
                                    }else{
                                        print("Invalid")
                                    }
                                }
                        }
                    }
                }
        }
    }
    
    func changeLanguage(str: String){
        TotalLabel.text = "Total".localized(lang: str)
        DeliveryAddressLabel.text = "Delivery Address".localized(lang: str)
        ButtonPlaceOrder.setTitle("Place Order".localized(lang: str), for: .normal)
        Tabbar.items?[0].title = "Home".localized(lang: str)
        Tabbar.items?[1].title = "Notification".localized(lang: str)
        Tabbar.items?[2].title = "Me".localized(lang: str)
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem){
        switch item.tag {
        case 1:
            DeleteOrder()
            navigationController?.setNavigationBarHidden(true, animated: false)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            viewController1 = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            if let navigator = self.navigationController {
                navigator.pushViewController(viewController1!, animated: true)
            }
            break
            
        case 2:
            DeleteOrder()
            navigationController?.setNavigationBarHidden(true, animated: false)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            viewController1 = storyboard.instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
            if let navigator = self.navigationController {
                navigator.pushViewController(viewController1!, animated: true)
            }
            break
            
        case 3:
            DeleteOrder()
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
    
    func DeleteOrder(){
        let parameters: Parameters=[
            "customer_id": userID,
            
        ]
        Alamofire.request(URL_DELETE, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value {
                    let jsonData = result as! NSDictionary
                    print(jsonData.value(forKey: "message")!)
                }else{
                    print("FAILED")
                }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = collectionView.bounds
        let screenWidth = screenSize.width
        let cellSquareSize: CGFloat = screenWidth
        return CGSize(width: cellSquareSize, height: 230);
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.DELIVERYPRICE.count
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CheckoutCollectionViewCell", for: indexPath) as! CheckoutCollectionViewCell
        cell.delegate = self
        
        cell.ButtonSelfPickUp.layer.cornerRadius = 7
        cell.ButtonSelfPickUp.isHidden = true
        cell.ButtonSelfPickUp.layer.borderWidth = 1
        if #available(iOS 13.0, *) {
            cell.ButtonSelfPickUp.layer.borderColor = CGColor(srgbRed: 1.000, green: 0.765, blue: 0.000, alpha: 1.000)
        } else {
            // Fallback on earlier versions
            
        }
        if(self.DIVISIONU[0] == DIVISION[indexPath.row]){
            cell.ButtonSelfPickUp.isHidden = false
        }else{
            cell.ButtonSelfPickUp.isHidden = true
        }
        
        if !self.PHOTO[indexPath.row].contains("%20"){
            let NEWIm = self.PHOTO[indexPath.row].addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
            
            cell.ItemImage.setImageWith(URL(string: NEWIm!)!)
        }else{
            cell.ItemImage.setImageWith(URL(string: self.PHOTO[indexPath.row])!)
        }
        let newWeight = Double(self.WEIGHT[indexPath.row])!
        let NewDeliveryPrice = newWeight * ceil(Double(self.DELIVERYPRICE[indexPath.row])!)
                
        cell.OrderID.text! = "KM" + self.ID[indexPath.row]
        cell.ItemName.text! = self.ADDETAIL[indexPath.row]
        
        cell.ItemPrice.text! = "RM" + self.PRICE[indexPath.row]
        cell.Quantity.text! = "x" + self.QUANTITY[indexPath.row]
        cell.DeliveryPrice.text! = "RM" + String(format: "%.2f", NewDeliveryPrice)
//        if(self.DELIVERYPRICE[indexPath.row] == "Not Supported for selected area"){
//            cell.DeliveryPrice.text! = self.DELIVERYPRICE[indexPath.row]
//        }else{
//            cell.DeliveryPrice.text! = "RM" + self.DELIVERYPRICE[indexPath.row]
//        }
        cell.Division.text! = self.DIVISION[indexPath.row] + " to " + self.DIVISIONU[0]
        return cell
    }
    
    @IBAction func GotoEditAddress(_ sender: Any) {
        let boostAd = self.storyboard!.instantiateViewController(withIdentifier: "AccountSettingsViewController") as! AccountSettingsViewController
        boostAd.userID = userID
        if let navigator = self.navigationController {
            navigator.pushViewController(boostAd, animated: true)
        }
    }
    
    func WarningCheck(){
        if(lang == "ms"){
            let refreshAlert = UIAlertController(title: "Transaction".localized(lang: "ms"), message: "Please make sure all the details is correct before you can proceed to the transaction.".localized(lang: "ms"), preferredStyle: UIAlertController.Style.alert)
            refreshAlert.addAction(UIAlertAction(title: "Proceed".localized(lang: "ms"), style: .default, handler: { (action: UIAlertAction!) in
                if(self.GrandTotal2.text! == "MYR0.00"){
                    let refreshAlertWarning = UIAlertController(title: "Warning".localized(lang: "ms"), message: "Oops, It seems Product/User Postcode is incorrect. Please check all the details before proceed.".localized(lang: "ms"), preferredStyle: UIAlertController.Style.alert)
                    refreshAlertWarning.addAction(UIAlertAction(title: "Continue".localized(lang: "ms"), style: .default, handler: { (action: UIAlertAction!) in
                        return
                    }))
                    self.present(refreshAlertWarning, animated: true, completion: nil)
                }else{
                    let date = Date()
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd"
                    let resultDate = formatter.string(from: date)
                    print("\(resultDate)")

                    self.spinner.show(in: self.view)
                    for i in 0..<self.SELLERID.count{
                        let parameters: Parameters=[
                            "seller_id": self.SELLERID[i],
                            "customer_id": self.userID,
                            "ad_detail": self.ADDETAIL[i],
                            "main_category":self.MAINCATE[i],
                            "sub_category": self.MAINCATE[i],
                            "price": self.PRICE[i],
                            "division": self.divsionu,
                            "postcode": self.postcode,
                            "district": self.divsionu,
                            "seller_division": self.DIVISION[i],
                            "seller_postcode": self.POSTCODE_P[i],
                            "seller_district": self.DISTRICT[i],
                            "photo": self.PHOTO[i],
                            "item_id": self.ITEMID[i],
                            "quantity": self.QUANTITY[i],
                            "delivery_price": self.DELIVERYPRICE[i],
                            "delivery_date": resultDate,
                            "delivery_addr": self.NEWADDR,
                            "weight": self.WEIGHT[i],
                            "refno": self.PaymentRefNo
                        ]
                        Alamofire.request(self.URL_CHECKOUT, method: .post, parameters: parameters).responseJSON
                            {
                                response in
                                if let result = response.result.value {
                                    self.spinner.dismiss(afterDelay: 3.0)
                                    _ = result as! NSDictionary
            //                        print(jsonData.value(forKey: "message")!)
                                    
                                    self.getSellerDetails()
                                    self.getUserDetails()
                                    
                                    let Price01 = (Double(self.PRICE[i])! * Double(self.QUANTITY[i])!)
                                    let Price02 = Price01 + ceil(Double(self.DELIVERYPRICE[i])!)
                                    
                                    let TotalPrice = String(format: "%.2f", Price02)
                                    
                                    self.GetPlayerData(UserID: self.userID)
                                    self.GetPlayerData(UserID: self.SELLERID[i])
                                    
//                                    self.sendEmailBuyer02(Email: self.SharedEmail, ItemID: self.ITEMID[i], ProductName: self.ADDETAIL[i], Price: self.PRICE[i], DeliveryPrice: self.DELIVERYPRICE[i], Quantity: self.QUANTITY[i], Total: TotalPrice)
                                    print("CHECKOUT SUCCESS")
                                }
                                else{
                                    print("CHECKOUT FAILED")
                                }
                        }
                    }
                    
                    let myBuying = self.storyboard!.instantiateViewController(withIdentifier: "AfterPlaceOrderViewController") as! AfterPlaceOrderViewController
                    myBuying.userID = self.userID
                    if let navigator = self.navigationController {
                        navigator.pushViewController(myBuying, animated: true)
                    }
                    
                    let vc = DetailViewController()
                    
                    vc.UserName = self.NAME[0]
                    vc.UserEmail = self.EMAIL[0]
                    vc.UserContact = self.PHONE_NO[0]
                    vc.RefNo = self.PaymentRefNo
                    vc.ProdDesc = productDesc
                    vc.Amount = self.GrandTotal2.text!
                    
                    if let navigator = self.navigationController {
                        navigator.pushViewController(vc, animated: true)
                    }
                }
                return
            }))
            refreshAlert.addAction(UIAlertAction(title: "Cancel".localized(lang: "ms"), style: .default, handler: { (action: UIAlertAction!) in
                return
            }))
            present(refreshAlert, animated: true, completion: nil)
        }else{
            let refreshAlert = UIAlertController(title: "Transaction".localized(lang: "en"), message: "Please make sure all the details is correct before you can proceed to the transaction.".localized(lang: "en"), preferredStyle: UIAlertController.Style.alert)
            refreshAlert.addAction(UIAlertAction(title: "Proceed".localized(lang: "en"), style: .default, handler: { (action: UIAlertAction!) in
                if(self.GrandTotal2.text! == "MYR0.00"){
                    let refreshAlertWarning = UIAlertController(title: "Warning".localized(lang: "en"), message: "Oops, It seems Product/User Postcode is incorrect. Please check all the details before proceed.".localized(lang: "en"), preferredStyle: UIAlertController.Style.alert)
                    refreshAlertWarning.addAction(UIAlertAction(title: "Continue".localized(lang: "en"), style: .default, handler: { (action: UIAlertAction!) in
                        return
                    }))
                    self.present(refreshAlertWarning, animated: true, completion: nil)
                }else{
                    let date = Date()
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd"
                    let resultDate = formatter.string(from: date)
                    print("\(resultDate)")

                    self.spinner.show(in: self.view)
                    for i in 0..<self.SELLERID.count{
                        let parameters: Parameters=[
                            "seller_id": self.SELLERID[i],
                            "customer_id": self.userID,
                            "ad_detail": self.ADDETAIL[i],
                            "main_category":self.MAINCATE[i],
                            "sub_category": self.MAINCATE[i],
                            "price": self.PRICE[i],
                            "division": self.divsionu,
                            "postcode": self.postcode,
                            "district": self.divsionu,
                            "seller_division": self.DIVISION[i],
                            "seller_postcode": self.POSTCODE_P[i],
                            "seller_district": self.DISTRICT[i],
                            "photo": self.PHOTO[i],
                            "item_id": self.ITEMID[i],
                            "quantity": self.QUANTITY[i],
                            "delivery_price": self.DELIVERYPRICE[i],
                            "delivery_date": resultDate,
                            "delivery_addr": self.NEWADDR,
                            "weight": self.WEIGHT[i],
                            "refno": self.PaymentRefNo
                        ]
                        Alamofire.request(self.URL_CHECKOUT, method: .post, parameters: parameters).responseJSON
                            {
                                response in
                                if let result = response.result.value {
                                    self.spinner.dismiss(afterDelay: 3.0)
                                    _ = result as! NSDictionary
            //                        print(jsonData.value(forKey: "message")!)
                                    
                                    self.getSellerDetails()
                                    self.getUserDetails()
                                    
                                    self.GetPlayerData(UserID: self.userID)

                                    self.GetPlayerData(UserID: self.SELLERID[i])
                                    
                                    self.sendEmailBuyer02(Email: self.SharedEmail, ItemID: self.ITEMID[i], ProductName: self.ADDETAIL[i], Price: self.PRICE[i], DeliveryPrice: self.DELIVERYPRICE[i], Quantity: self.QUANTITY[i], Total: self.GrandTotal2.text!)
                                    print("CHECKOUT SUCCESS")
                                    
                                }
                                else{
                                    print("CHECKOUT FAILED")
                                }
                        }
                    }
                    
                    let productDesc = self.PRODUCTDESCRIPTION.joined(separator: ", ")
                    
                    
                    let myBuying = self.storyboard!.instantiateViewController(withIdentifier: "AfterPlaceOrderViewController") as! AfterPlaceOrderViewController
                    myBuying.userID = self.userID
                    if let navigator = self.navigationController {
                        navigator.pushViewController(myBuying, animated: true)
                    }
                    
                    let vc = DetailViewController()
                    
                    vc.UserName = self.NAME[0]
                    vc.UserEmail = self.EMAIL[0]
                    vc.UserContact = self.PHONE_NO[0]
                    vc.RefNo = self.PaymentRefNo
                    vc.ProdDesc = productDesc
                    vc.Amount = self.GrandTotal2.text!
                    
                    if let navigator = self.navigationController {
                        navigator.pushViewController(vc, animated: true)
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
    
    @IBAction func PlaceOrder(_ sender: Any) {
        WarningCheck()
    }
    
    let URL_SEND_EMAIL_BUYER_02 = "https://ketekmall.com/ketekmall/sendEmail_buyer_two.php"
    
    func sendEmailBuyer02(Email: String, ItemID: String, ProductName: String, Price: String, DeliveryPrice: String, Quantity: String, Total: String) {
        let parameters: Parameters=[
            "email": Email,
            "id": ItemID,
            "ad_detail": ProductName,
            "price": Price,
            "delivery_price": DeliveryPrice,
            "quantity": Quantity,
            "total": Total
        ]
        
        Alamofire.request(URL_SEND_EMAIL_BUYER_02, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value{
                    _ = result as! NSDictionary
                    print("SENT")
                }else{
                    print("FAILED")
                }
        }
    }
    
    func getSellerDetails(){
        for i in 0..<self.SELLERID.count{
            let parameters: Parameters=[
                "id": SELLERID[i],
            ]
            Alamofire.request(URL_READ, method: .post, parameters: parameters).responseJSON
                {
                    response in
                    if let result = response.result.value{
                        let jsonData = result as! NSDictionary
                        
                        if((jsonData.value(forKey: "success") as! NSString).boolValue){
                            let user = jsonData.value(forKey: "read") as! NSArray
                            let SellerName = user.value(forKey: "name") as! [String]
                            let SellerEmail = user.value(forKey: "email") as! [String]
                            self.sendEmail(Email: SellerEmail[0])
                        }
                    }
            }
        }
        
    }
    
    func sendEmail(Email: String){
        let parameters: Parameters=[
            "email": Email
        ]
        
        Alamofire.request(URL_SEND_EMAILSELLER, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value{
                    _ = result as! NSDictionary
                    print("SENT")
                }else{
                    print("FAILED")
                }
        }
    }
    
    func getUserDetails(){
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
                        _ = user.value(forKey: "email") as! [String]
                        
//                        self.sendEmailBuyer(Email: email[0])
                        
                        
                    }
                }else{
                    print("FAILED")
                }
                
        }
    }
    
    func OneSignalNoti(PlayerID: String, Name: String){
        let parameters: Parameters=[
            "PlayerID": PlayerID,
            "Name": Name,
            "Words": "New order has been placed! Check My Buying for information."
        ]
        
        Alamofire.request(URL_NOTI, method: .post, parameters: parameters).responseJSON
            {
                response in
            if response.result.value != nil{
                    print("ONESIGNAL SUCCESS")
                }else{
                    print("FAILED")
                }
                
        }
    }
    
    func GetPlayerData(UserID: String){
        let parameters: Parameters=[
            "UserID": UserID
        ]
        
        Alamofire.request(URL_GET_PLAYERID, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        let user = jsonData.value(forKey: "read") as! NSArray
                        
                        let PlayerID = user.value(forKey: "PlayerID") as! [String]
                        let Name = user.value(forKey: "Name") as! [String]
                        _ = user.value(forKey: "UserID") as! [String]
                        
                        self.OneSignalNoti(PlayerID: PlayerID[0], Name: Name[0])
                    }
                }else{
                    print("FAILED")
                }
                
        }
    }
}
