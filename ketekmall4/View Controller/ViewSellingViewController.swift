
import UIKit
import Alamofire
import JGProgressHUD
import PDFKit
import WebKit

class ViewSellingViewController: UIViewController,URLSessionDownloadDelegate{

    private let spinner = JGProgressHUD(style: .dark)
    @IBOutlet weak var OrderID: UILabel!
    @IBOutlet weak var ItemImage: UIImageView!
    @IBOutlet weak var Item_Name: UILabel!
    @IBOutlet weak var Item_Price: UILabel!
    @IBOutlet weak var Date_Order: UILabel!
    @IBOutlet weak var Ship_Place: UILabel!
    @IBOutlet weak var Status: UILabel!
    @IBOutlet weak var Quantity: UILabel!
    
    @IBOutlet weak var Customer_Name: UILabel!
    @IBOutlet weak var Customer_Address: UITextView!
    @IBOutlet weak var Customer_Phone: UILabel!
    
    @IBOutlet weak var ButtonShare: UIButton!
    @IBOutlet weak var TrackingNo: UITextField!
    @IBOutlet weak var ButtonSubmit: UIButton!
    @IBOutlet weak var ButtonDownload: UIButton!
    
    @IBOutlet weak var PosLabel: UILabel!
    
    
    let URL_READ_CUSTOMER = "https://ketekmall.com/ketekmall/read_detail.php"
    let URL_EDIT = "https://ketekmall.com/ketekmall/edit_tracking_no.php"
    let URL_SEND = "https://ketekmall.com/ketekmall/sendEmail_product_reject.php"
    let URL_GET_PLAYERID = "https://ketekmall.com/ketekmall/getPlayerID.php"
    let URL_NOTI = "https://ketekmall.com/ketekmall/onesignal_noti.php"
    let URL_createConnote = "https://ketekmall.com/ketekmall/createConnote.php"
    let URL_getConnote = "https://ketekmall.com/ketekmall/getConnote.php"
    let URL_editTrackingNo = "https://ketekmall.com/ketekmall/editTrackingNo.php"

    
    var ItemID = ""
    var USERID: String = ""
    var CUSTOMERID: String = ""
    var ORDERID: String = ""
    var ITEMIMAGE: String = ""
    var ITEMNAME: String = ""
    var ITEMPRICE: String = ""
    var DATEORDER: String = ""
    var SHIPPLACED: String = ""
    var STATUS: String = ""
    var QUANTITY: String = ""
    var ORDER_DATE: String = ""
    var WEIGHT: String = ""
    var POSTCODE: String = ""
    var AMOUNT: String = ""
    var TRACKINGNO: String = ""
    
    let sharedPref = UserDefaults.standard
    var user: String = ""
    var lang: String = ""

    @IBOutlet weak var Ordered: UILabel!
    @IBOutlet weak var Pending: UILabel!
    @IBOutlet weak var Shipped: UILabel!
    @IBOutlet weak var Received: UILabel!
    
    @IBOutlet weak var Ordered_Black: UIImageView!
    @IBOutlet weak var Pending_Black: UIImageView!
    @IBOutlet weak var Shipped_Black: UIImageView!
    @IBOutlet weak var Received_Black: UIImageView!
    
    @IBOutlet weak var Ordered_Green: UIImageView!
    @IBOutlet weak var Pending_Green: UIImageView!
    @IBOutlet weak var Shipped_Green: UIImageView!
    @IBOutlet weak var Received_Green: UIImageView!
    
    @IBOutlet weak var Finished: UILabel!
    @IBOutlet weak var FinishedHeight: NSLayoutConstraint!
    
    @IBOutlet weak var PosLabelHeight: NSLayoutConstraint!
    
    @IBOutlet weak var DeliveryView: UIView!
    
    
    var CONNOTENO: String = ""
    var CONNOTEDATE: String = ""
    var PRODUCTCODE: String = ""
    var SENDERNAME: String = ""
    var SENDERPHONE: String = ""
    var SENDERPOSTCODE: String = ""
    var RECIPIENTACCOUNTNO: String = ""
    var RECIPIENTNAME: String = ""
    var RECIPIENTADDRESS01: String = ""
    var RECIPIENTADDRESS02: String = ""
    var RECIPIENTPOSTCODE: String = ""
    var RECIPIENTCITY: String = ""
    var RECIPIENTSTATE: String = ""
    var RECIPIENTPHONE: String = ""
    var RECIPIENTEMAIL: String = ""
    var WEIGHTCONNOTE: String = ""
    var TYPE: String = ""

    
    
    var pdfView = PDFView()
        var pdfURL: URL!
    
    override func viewDidAppear(_ animated: Bool) {
        ColorFunc()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print(ItemID)
        
        lang = sharedPref.string(forKey: "LANG") ?? "0"
        user = sharedPref.string(forKey: "USERID") ?? "0"
        if(lang == "ms"){
            changeLanguage(str: "ms")
            
        }else{
            changeLanguage(str: "en")
            
        }
        let NEWIm = ITEMIMAGE.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        
        ItemImage.setImageWith(URL(string: NEWIm!)!)
        OrderID.text! = "KM" + ORDERID
        Item_Name.text! = ITEMNAME
        Item_Price.text! = "RM" + ITEMPRICE
        Date_Order.text! = "Order Placed on " + DATEORDER
        Ship_Place.text! = "Shipped out to " + SHIPPLACED
        Status.text! = STATUS
        Quantity.text! = "x" + QUANTITY
        TrackingNo.text! = TRACKINGNO
        
        ButtonShare.layer.cornerRadius = 5
        ButtonSubmit.layer.cornerRadius = 5
        
        if(STATUS == "Ordered"){
            Ordered.textColor = .green
            Ordered_Black.isHidden = true
            Ordered_Green.isHidden = false
            
//            Pending.textColor = .green
            Pending_Black.isHidden = false
            Pending_Green.isHidden = true
            
//            Shipped.textColor = .green
            Shipped_Black.isHidden = false
            Shipped_Green.isHidden = true
            
//            Received.textColor = .green
            Received_Black.isHidden = false
            Received_Green.isHidden = true
            
            Finished.isHidden = true
            FinishedHeight.constant = 0
        }else if(STATUS == "Pending"){
            Ordered.textColor = .green
            Ordered_Black.isHidden = true
            Ordered_Green.isHidden = false
            
            Pending.textColor = .green
            Pending_Black.isHidden = true
            Pending_Green.isHidden = false
            
//            Shipped.textColor = .green
            Shipped_Black.isHidden = false
            Shipped_Green.isHidden = true
            
//            Received.textColor = .green
            Received_Black.isHidden = false
            Received_Green.isHidden = true
            
            Finished.isHidden = true
            FinishedHeight.constant = 0
        }else if(STATUS == "Shipped"){
            Ordered.textColor = .green
            Ordered_Black.isHidden = true
            Ordered_Green.isHidden = false
            
            Pending.textColor = .green
            Pending_Black.isHidden = true
            Pending_Green.isHidden = false
            
            Shipped.textColor = .green
            Shipped_Black.isHidden = true
            Shipped_Green.isHidden = false
            
//            Received.textColor = .green
            Received_Black.isHidden = false
            Received_Green.isHidden = true
            
            Finished.isHidden = true
            FinishedHeight.constant = 0
        }else if(STATUS == "Received"){
            Ordered.textColor = .green
            Ordered_Black.isHidden = true
            Ordered_Green.isHidden = false
            
            Pending.textColor = .green
            Pending_Black.isHidden = true
            Pending_Green.isHidden = false
            
            Shipped.textColor = .green
            Shipped_Black.isHidden = true
            Shipped_Green.isHidden = false
            
            Received.textColor = .green
            Received_Black.isHidden = true
            Received_Green.isHidden = false
            
            Finished.isHidden = false
            
        }else if(STATUS == "Rejected"){
            
            Ordered_Black.isHidden = false
            Ordered_Green.isHidden = true
            
            
            Pending_Black.isHidden = false
            Pending_Green.isHidden = true
            
            
            Shipped_Black.isHidden = false
            Shipped_Green.isHidden = true
            
            
            Received_Black.isHidden = false
            Received_Green.isHidden = true
            
            Finished.backgroundColor = .red
            Finished.text = "REJECT"
            
            PosLabel.isHidden = true
            PosLabelHeight.constant = 0
//            TrackingHeight.constant = 0
            ButtonShare.isHidden = true
            ButtonDownload.isHidden = true
            
            TrackingNo.isHidden = true
            ButtonSubmit.isHidden = true
            DeliveryView.isHidden = true
        }else if(STATUS == "Cancelled"){
            
            Ordered_Black.isHidden = false
            Ordered_Green.isHidden = true
            
            
            Pending_Black.isHidden = false
            Pending_Green.isHidden = true
            
            
            Shipped_Black.isHidden = false
            Shipped_Green.isHidden = true
            
            
            Received_Black.isHidden = false
            Received_Green.isHidden = true
            
            Finished.backgroundColor = .red
            Finished.text = "CANCEL"
            
            PosLabel.isHidden = true
            PosLabelHeight.constant = 0
//            TrackingHeight.constant = 0
            ButtonShare.isHidden = true
            ButtonDownload.isHidden = true
            TrackingNo.isHidden = true
            ButtonSubmit.isHidden = true
            DeliveryView.isHidden = true
//            SubmitHeight.constant = 0
        }
        
        
        getUserDetails()
        self.hideKeyboardWhenTappedAround()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil);
    }
    
    override func viewDidLayoutSubviews() {
            pdfView.frame = view.frame
        }

    func ColorFunc(){
        //Button Accept
        let color1 = UIColor(hexString: "#FC4A1A").cgColor
        let color2 = UIColor(hexString: "#F7B733").cgColor
        
        let ReceivedGradient = CAGradientLayer()
        ReceivedGradient.frame = ButtonShare.bounds
        ReceivedGradient.colors = [color1, color2]
        ReceivedGradient.startPoint = CGPoint(x: 0, y: 0.5)
        ReceivedGradient.endPoint = CGPoint(x: 1, y: 0.5)
        ReceivedGradient.cornerRadius = 5
        ButtonShare.layer.insertSublayer(ReceivedGradient, at: 0)
        
        let DownloadGradient = CAGradientLayer()
        DownloadGradient.frame = ButtonDownload.bounds
        DownloadGradient.colors = [color1, color2]
        DownloadGradient.startPoint = CGPoint(x: 0, y: 0.5)
        DownloadGradient.endPoint = CGPoint(x: 1, y: 0.5)
        DownloadGradient.cornerRadius = 5
        ButtonDownload.layer.insertSublayer(DownloadGradient, at: 0)
        
        //Button Cancel
        let color3 = UIColor(hexString: "#FC4A1A").cgColor
        let color4 = UIColor(hexString: "#F7B733").cgColor
        
        let CancelGradient = CAGradientLayer()
        CancelGradient.frame = ButtonSubmit.bounds
        CancelGradient.colors = [color3, color4]
        CancelGradient.startPoint = CGPoint(x: 0, y: 0.5)
        CancelGradient.endPoint = CGPoint(x: 1, y: 0.5)
        CancelGradient.cornerRadius = 5
        ButtonSubmit.layer.insertSublayer(CancelGradient, at: 0)
    }
    
    func changeLanguage(str: String){
        PosLabel.text = "Delivery Settings".localized(lang: str)
        ButtonShare.titleLabel!.text = "Share".localized(lang: str)
        ButtonDownload.titleLabel!.text = "Download".localized(lang: str)
        ButtonSubmit.titleLabel!.text = "Submit".localized(lang: str)
    }
    
    func getUserDetails(){
        spinner.show(in: self.view)
        let parameters: Parameters=[
            "id": CUSTOMERID
        ]
        
        Alamofire.request(URL_READ_CUSTOMER, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        self.spinner.dismiss(afterDelay: 3.0)
                        let user = jsonData.value(forKey: "read") as! NSArray
                        
                        let name = user.value(forKey: "name") as! [String]
                        let email = user.value(forKey: "email") as! [String]
                        let district = user.value(forKey: "division") as! [String]
                        let Phone = user.value(forKey: "phone_no") as! [String]
                        
                        self.Customer_Name.text = name[0]
                        self.Customer_Address.text! = district[0]
                        self.Customer_Phone.text! = Phone[0]
                        
                        self.sendEmail(Email: email[0], OrderID: self.ORDERID)
                    }
                }else{
                    print("FAILED")
                }
                
        }
    }
    
    //MARK: PosLajeGetData
    func PosLajuGetData(customerID: String, OrderID: String, subscriptionCode: String, AccountNo: String){
        let parameters: Parameters=[
            "id": user
        ]
        
        Alamofire.request(URL_READ_CUSTOMER, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        let user = jsonData.value(forKey: "read") as! NSArray
                        
                        let SellerName = user.value(forKey: "name") as! [String]
                        let SellerEmail = user.value(forKey: "email") as! [String]
                        let SellerAddress01 = user.value(forKey: "address_01") as! [String]
                        let SellerAddress02 = user.value(forKey: "address_02") as! [String]
                        let SellerDivision = user.value(forKey: "division") as! [String]
                        let SellerPostCode = user.value(forKey: "postcode") as! [String]
                        let SellerPhoneNo = user.value(forKey: "phone_no") as! [String]
                        
                        let parameters: Parameters=[
                            "id": self.CUSTOMERID
                        ]
                        
                        Alamofire.request(self.URL_READ_CUSTOMER, method: .post, parameters: parameters).responseJSON
                            {
                                response in
                                if let result = response.result.value{
                                    let jsonData = result as! NSDictionary
                                    
                                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                                        let user = jsonData.value(forKey: "read") as! NSArray
                                        
                                        let ReceiverName = user.value(forKey: "name") as! [String]
                                        let ReceiverEmail = user.value(forKey: "email") as! [String]
                                        let ReceiverAddress01 = user.value(forKey: "division") as! [String]
                                        let ReceiverAddress02 = user.value(forKey: "phone_no") as! [String]
                                        let ReceiverDivision = user.value(forKey: "division") as! [String]
                                        let ReceiverPostCode = user.value(forKey: "postcode") as! [String]
                                        let ReceiverPhoneNo = user.value(forKey: "phone_no") as! [String]
                                        
                                        let SellerFullAddress01 = "\(SellerAddress01[0]), \(SellerAddress02[0])"
                                        let SellerFullAddress02 = "\(SellerPostCode[0])  \(SellerDivision[0])"
                                        let SellerFullAddress = SellerFullAddress01 + "," + SellerFullAddress02
                                        
                                        let ReceiverFullAddress01 = "\(ReceiverAddress01[0]), \(ReceiverAddress02[0])"
                                        let ReceiverFullAddress02 = "\(ReceiverPostCode[0]) \(ReceiverDivision[0])"
                                        let ReceiverFullAddress = ReceiverFullAddress01 + "," + ReceiverFullAddress02
                                        
                                        self.RoutingCode(Origin: SellerPostCode[0],Destination: ReceiverPostCode[0], OrderID: self.ORDERID, subscriptionCode: subscriptionCode, AccountNo: AccountNo, SellerName: SellerName[0], SellerPhone: SellerPhoneNo[0], SellerAddress: SellerFullAddress, PickupLocationID: self.ORDERID + SellerPostCode[0], ContactPerson: SellerPhoneNo[0], PickupAddress: SellerFullAddress, PostCode: SellerPostCode[0], TotalQuantityToPickup: self.QUANTITY, Weight: self.WEIGHT, Amount: self.AMOUNT, ReceiverName: ReceiverName[0], ReceiverAddress: ReceiverFullAddress, ReceiverPostCode: ReceiverPostCode[0], ReceiverPhone: ReceiverPhoneNo[0], PickupDistrict: SellerAddress02[0], PickupProvince: SellerDivision[0], PickupEmail: SellerEmail[0], ReceiverFirstName: ReceiverName[0], ReceiverLastName: ReceiverName[0], ReceiverDistrict: ReceiverAddress02[0], ReceiverProvince: ReceiverAddress02[0], ReceiverCity: ReceiverDivision[0], ReceiverAddress01: ReceiverAddress01[0], ReceiverAddress02: ReceiverAddress02[0], ReceiverEmail: ReceiverEmail[0])
                                    }
                                }else{
                                    print("FAILED")
                                }
                                
                        }
                    }
                }else{
                    print("FAILED")
                }
                
        }
    }
    
    func PosLajuGetData02(customerID: String, OrderID: String, subscriptionCode: String, AccountNo: String){
        let parameters: Parameters=[
            "id": user
        ]
        
        Alamofire.request(URL_READ_CUSTOMER, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        let user = jsonData.value(forKey: "read") as! NSArray
                        
                        let SellerName = user.value(forKey: "name") as! [String]
                        let SellerEmail = user.value(forKey: "email") as! [String]
                        let SellerAddress01 = user.value(forKey: "address_01") as! [String]
                        let SellerAddress02 = user.value(forKey: "address_02") as! [String]
                        let SellerDivision = user.value(forKey: "division") as! [String]
                        let SellerPostCode = user.value(forKey: "postcode") as! [String]
                        let SellerPhoneNo = user.value(forKey: "phone_no") as! [String]
                        
                        let parameters: Parameters=[
                            "id": self.CUSTOMERID
                        ]
                        
                        Alamofire.request(self.URL_READ_CUSTOMER, method: .post, parameters: parameters).responseJSON
                            {
                                response in
                                if let result = response.result.value{
                                    let jsonData = result as! NSDictionary
                                    
                                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                                        let user = jsonData.value(forKey: "read") as! NSArray
                                        
                                        let ReceiverName = user.value(forKey: "name") as! [String]
                                        let ReceiverEmail = user.value(forKey: "email") as! [String]
                                        let ReceiverAddress01 = user.value(forKey: "division") as! [String]
                                        let ReceiverAddress02 = user.value(forKey: "phone_no") as! [String]
                                        let ReceiverDivision = user.value(forKey: "division") as! [String]
                                        let ReceiverPostCode = user.value(forKey: "postcode") as! [String]
                                        let ReceiverPhoneNo = user.value(forKey: "phone_no") as! [String]
                                        
                                        let SellerFullAddress01 = "\(SellerAddress01[0]), \(SellerAddress02[0])"
                                        let SellerFullAddress02 = "\(SellerPostCode[0])  \(SellerDivision[0])"
                                        let SellerFullAddress = SellerFullAddress01 + "," + SellerFullAddress02
                                        
                                        let ReceiverFullAddress01 = "\(ReceiverAddress01[0]), \(ReceiverAddress02[0])"
                                        let ReceiverFullAddress02 = "\(ReceiverPostCode[0]) \(ReceiverDivision[0])"
                                        let ReceiverFullAddress = ReceiverFullAddress01 + "," + ReceiverFullAddress02
                                        
                                        self.RoutingCode02(Origin: SellerPostCode[0],Destination: ReceiverPostCode[0], OrderID: self.ORDERID, subscriptionCode: subscriptionCode, AccountNo: AccountNo, SellerName: SellerName[0], SellerPhone: SellerPhoneNo[0], SellerAddress: SellerFullAddress, PickupLocationID: self.ORDERID + SellerPostCode[0], ContactPerson: SellerPhoneNo[0], PickupAddress: SellerFullAddress, PostCode: SellerPostCode[0], TotalQuantityToPickup: self.QUANTITY, Weight: self.WEIGHT, Amount: self.AMOUNT, ReceiverName: ReceiverName[0], ReceiverAddress: ReceiverFullAddress, ReceiverPostCode: ReceiverPostCode[0], ReceiverPhone: ReceiverPhoneNo[0], PickupDistrict: SellerAddress02[0], PickupProvince: SellerDivision[0], PickupEmail: SellerEmail[0], ReceiverFirstName: ReceiverName[0], ReceiverLastName: ReceiverName[0], ReceiverDistrict: ReceiverAddress02[0], ReceiverProvince: ReceiverAddress02[0], ReceiverCity: ReceiverDivision[0], ReceiverAddress01: ReceiverAddress01[0], ReceiverAddress02: ReceiverAddress02[0], ReceiverEmail: ReceiverEmail[0])
                                    }
                                }else{
                                    print("FAILED")
                                }
                                
                        }
                    }
                }else{
                    print("FAILED")
                }
                
        }
    }
    
    //MARK: Routing Code
    let HTTP_RoutingCode = "https://apis.pos.com.my/apigateway/as01/api/routingcode/v1";
    let serverKey_RoutingCode = "aWFGekJBMXUyRFFmTmNxUEpmcXhwR0hXYnY5cWdCTmE=";
    func RoutingCode(Origin: String, Destination: String,
                     OrderID: String, subscriptionCode: String,
                     AccountNo: String, SellerName: String,
                     SellerPhone: String, SellerAddress: String,
                     PickupLocationID: String, ContactPerson: String,
                     PickupAddress: String,
                     PostCode: String, TotalQuantityToPickup: String,
                     Weight: String, Amount: String,
                     ReceiverName: String, ReceiverAddress: String,
                     ReceiverPostCode: String, ReceiverPhone: String,
                     PickupDistrict: String, PickupProvince: String,
                     PickupEmail: String, ReceiverFirstName: String,
                     ReceiverLastName: String, ReceiverDistrict: String,
                     ReceiverProvince: String, ReceiverCity: String,
                     ReceiverAddress01: String, ReceiverAddress02: String,
                     ReceiverEmail: String){
        let headers = [
            "X-User-Key": serverKey_RoutingCode,
        ]

        let configuration = URLSessionConfiguration.default
            configuration.requestCachePolicy = .reloadIgnoringLocalCacheData

        Alamofire.request(HTTP_RoutingCode + "?Origin=" + Origin + "&Destination=" + Destination, method: .get, encoding: URLEncoding.httpBody, headers: headers).responseJSON
                {
                    response in
                    if let result = response.result.value {
                        print("SUCCESS")
                        let details = result as! NSObject
                        
                        let RoutingCode = details.value(forKey: "RoutingCode") as! String
                        print("JSON: \(RoutingCode)")
                        
                        self.GenConnote(numberOfItem: TotalQuantityToPickup, OrderID: self.ORDERID, subscriptionCode: subscriptionCode, AccountNo: AccountNo, SellerName: SellerName, SellerPhone: SellerPhone, SellerAddress: SellerAddress, PickupLocationID: PickupLocationID, ContactPerson: ContactPerson, PostCode: PostCode, TotalQuantityToPickup: TotalQuantityToPickup, Weight: self.WEIGHT, Amount: self.AMOUNT, ReceiverName: ReceiverName, ReceiverAddress: ReceiverAddress, ReceiverPostCode: ReceiverPostCode, ReceiverPhone: ReceiverPhone, PickupDistrict: PickupDistrict, PickupProvince: PickupProvince, PickupEmail: PickupEmail, ReceiverFirstName: ReceiverFirstName, ReceiverLastName: ReceiverLastName, ReceiverDistrict: ReceiverDistrict, ReceiverProvince: ReceiverProvince, ReceiverCity: ReceiverCity, ReceiverAddress01: ReceiverAddress01, ReceiverAddress02: ReceiverAddress02, ReceiverEmail: ReceiverEmail, RoutingCode: RoutingCode)
                        
                    }else{
                        print("FAILED TO RECEIVE")
                    }
            }
        
    }
    
    func RoutingCode02(Origin: String, Destination: String,
                     OrderID: String, subscriptionCode: String,
                     AccountNo: String, SellerName: String,
                     SellerPhone: String, SellerAddress: String,
                     PickupLocationID: String, ContactPerson: String,
                     PickupAddress: String,
                     PostCode: String, TotalQuantityToPickup: String,
                     Weight: String, Amount: String,
                     ReceiverName: String, ReceiverAddress: String,
                     ReceiverPostCode: String, ReceiverPhone: String,
                     PickupDistrict: String, PickupProvince: String,
                     PickupEmail: String, ReceiverFirstName: String,
                     ReceiverLastName: String, ReceiverDistrict: String,
                     ReceiverProvince: String, ReceiverCity: String,
                     ReceiverAddress01: String, ReceiverAddress02: String,
                     ReceiverEmail: String){
        let headers = [
            "X-User-Key": serverKey_RoutingCode,
        ]

        let configuration = URLSessionConfiguration.default
            configuration.requestCachePolicy = .reloadIgnoringLocalCacheData

        Alamofire.request(HTTP_RoutingCode + "?Origin=" + Origin + "&Destination=" + Destination, method: .get, encoding: URLEncoding.httpBody, headers: headers).responseJSON
                {
                    response in
                    if let result = response.result.value {
                        print("SUCCESS")
                        let details = result as! NSObject
                        
                        let RoutingCode = details.value(forKey: "RoutingCode") as! String
                        print("JSON: \(RoutingCode)")
                        
                        self.GenConnote02(numberOfItem: TotalQuantityToPickup, OrderID: self.ORDERID, subscriptionCode: subscriptionCode, AccountNo: AccountNo, SellerName: SellerName, SellerPhone: SellerPhone, SellerAddress: SellerAddress, PickupLocationID: PickupLocationID, ContactPerson: ContactPerson, PostCode: PostCode, TotalQuantityToPickup: TotalQuantityToPickup, Weight: self.WEIGHT, Amount: self.AMOUNT, ReceiverName: ReceiverName, ReceiverAddress: ReceiverAddress, ReceiverPostCode: ReceiverPostCode, ReceiverPhone: ReceiverPhone, PickupDistrict: PickupDistrict, PickupProvince: PickupProvince, PickupEmail: PickupEmail, ReceiverFirstName: ReceiverFirstName, ReceiverLastName: ReceiverLastName, ReceiverDistrict: ReceiverDistrict, ReceiverProvince: ReceiverProvince, ReceiverCity: ReceiverCity, ReceiverAddress01: ReceiverAddress01, ReceiverAddress02: ReceiverAddress02, ReceiverEmail: ReceiverEmail, RoutingCode: RoutingCode)
                        
                    }else{
                        print("FAILED TO RECEIVE")
                    }
            }
        
    }
    
    //MARK: GenConnote
    let HTTP_GenConnote = "https://apis.pos.com.my/apigateway/as01/api/genconnote/v1";
    let serverKey_GenConnote = "MmpkbDI0MFpuTVpuZDRXb3J0VUk4M25ZTkY1a2NqSFU=";
    func GenConnote(numberOfItem: String,
                    OrderID: String, subscriptionCode: String,
                    AccountNo: String, SellerName: String,
                    SellerPhone: String, SellerAddress: String,
                    PickupLocationID: String, ContactPerson: String,
                    PostCode: String, TotalQuantityToPickup: String,
                    Weight: String, Amount: String,
                    ReceiverName: String, ReceiverAddress: String,
                    ReceiverPostCode: String, ReceiverPhone: String,
                    PickupDistrict: String, PickupProvince: String,
                    PickupEmail: String, ReceiverFirstName: String,
                    ReceiverLastName: String, ReceiverDistrict: String,
                    ReceiverProvince: String, ReceiverCity: String,
                    ReceiverAddress01: String, ReceiverAddress02: String,
                    ReceiverEmail: String, RoutingCode: String){
        let date01 = Date()
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        let date = df.string(from: date01)
        
        let headers = [
            "X-User-Key": serverKey_GenConnote,
        ]

        let configuration = URLSessionConfiguration.default
            configuration.requestCachePolicy = .reloadIgnoringLocalCacheData

        Alamofire.request(HTTP_GenConnote + "?numberOfItem=" + numberOfItem + "&Prefix=ERC" + "&ApplicationCode=HNM" + "&Secretid=HM@$343" + "&Orderid=" + OrderID + "&username=HMNNadhir", method: .get, encoding: URLEncoding.httpBody, headers: headers).responseJSON
                {
                    response in
                    if let result = response.result.value {
                        let details = result as! NSObject
                        
                        let Message = details.value(forKey: "Message") as! String
                        let ConnoteNo = details.value(forKey: "ConnoteNo") as! String

                        print("JSON: \(ConnoteNo)")
                        
                        if(Message.contains("Record already exist/Wrong Credential")){
                            let spinner1 = JGProgressHUD(style: .dark)
                            spinner1.show(in: self.view)
                            self.getConnoteShare(getProductCode: "KM00" + self.ORDERID, SenderAddress: SellerAddress, RecipientAddress: ReceiverAddress, RoutingCode: RoutingCode, date: date)
                            spinner1.dismiss(afterDelay: 3.0)
                        }else{
                            let spinner1 = JGProgressHUD(style: .dark)
                            spinner1.show(in: self.view)
                            self.EditTrackingNo(ConnoteNo: ConnoteNo)

                            self.CreateConnote(ConnoteNo: ConnoteNo, ConnoteDate: date, ProductCode: "KM00" + self.ORDERID, SenderName: SellerName, SenderPhone: SellerPhone, SenderPostcode: PostCode, RecipientAccountNo: AccountNo, RecipientName: ReceiverName, RecipientAddress01: ReceiverAddress01, RecipientAddress02: ReceiverAddress02, RecipientPostcode: ReceiverPostCode, RecipientCity: ReceiverCity, RecipientState: ReceiverProvince, RecipientPhone: ReceiverPhone, RecipientEmail: ReceiverEmail, Weight: self.WEIGHT)
                            
                            self.PreAcceptanceSingle(subscriptionCode: subscriptionCode, AccountNo: AccountNo, SellerName: SellerName, SellerPhone: SellerPhone, SellerAddress: SellerAddress, PickupLocationID: PickupLocationID, ContactPerson: ContactPerson, PostCode: PostCode, TotalQuantityToPickup: TotalQuantityToPickup, Weight: self.WEIGHT, ConsignmentNoteNumber: ConnoteNo, Amount: self.AMOUNT, ReceiverName: ReceiverName, ReceiverAddress: ReceiverAddress, ReceiverPostCode: ReceiverPostCode, ReceiverPhone: ReceiverPhone, PickupDistrict: PickupDistrict, PickupProvince: PickupProvince, PickupEmail: PickupEmail, ReceiverFirstName: ReceiverFirstName, ReceiverLastName: ReceiverLastName, ReceiverDistrict: ReceiverDistrict, ReceiverProvince: ReceiverProvince, ReceiverCity: ReceiverCity, ReceiverEmail: ReceiverEmail)
                            
                            self.GeneratePDF(ShipDate: date, Weight: self.WEIGHT, OrderID: self.ORDERID, SenderName: SellerName, SenderPhone: SellerPhone, SenderAddress: SellerAddress, SenderPostCode: PostCode, RecipientName: ReceiverName, RecipientPhone: ReceiverPhone, RecipientPostCode: ReceiverPostCode, RecipientAccountNO: AccountNo, RecipientAddress: ReceiverAddress, RecipientAddress01: ReceiverAddress01, RecipientAddress02: ReceiverAddress02, RecipientCity: ReceiverCity, RecipientState: ReceiverProvince, RecipientEmail: ReceiverEmail, ProductCode: self.ORDERID, Type: "Document", RoutingCode: RoutingCode, ConnoteNo: ConnoteNo, ConnoteDate: date)
                            spinner1.dismiss(afterDelay: 3.0)
                        }
                        
                        
                        
                    }else{
                        print("FAILED TO RECEIVE")
                    }
            }
    }
    
    func GenConnote02(numberOfItem: String,
                    OrderID: String, subscriptionCode: String,
                    AccountNo: String, SellerName: String,
                    SellerPhone: String, SellerAddress: String,
                    PickupLocationID: String, ContactPerson: String,
                    PostCode: String, TotalQuantityToPickup: String,
                    Weight: String, Amount: String,
                    ReceiverName: String, ReceiverAddress: String,
                    ReceiverPostCode: String, ReceiverPhone: String,
                    PickupDistrict: String, PickupProvince: String,
                    PickupEmail: String, ReceiverFirstName: String,
                    ReceiverLastName: String, ReceiverDistrict: String,
                    ReceiverProvince: String, ReceiverCity: String,
                    ReceiverAddress01: String, ReceiverAddress02: String,
                    ReceiverEmail: String, RoutingCode: String){
        let date01 = Date()
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        let date = df.string(from: date01)
        
        let headers = [
            "X-User-Key": serverKey_GenConnote,
        ]

        let configuration = URLSessionConfiguration.default
            configuration.requestCachePolicy = .reloadIgnoringLocalCacheData

        Alamofire.request(HTTP_GenConnote + "?numberOfItem=" + numberOfItem + "&Prefix=ERC" + "&ApplicationCode=HNM" + "&Secretid=HM@$343" + "&Orderid=" + OrderID + "&username=HMNNadhir", method: .get, encoding: URLEncoding.httpBody, headers: headers).responseJSON
                {
                    response in
                    if let result = response.result.value {
                        let details = result as! NSObject
                        
                        let Message = details.value(forKey: "Message") as! String
                        let ConnoteNo = details.value(forKey: "ConnoteNo") as! String

                        print("JSON: \(response)")
                        
                        if(Message.contains("Record already exist/Wrong Credential")){
                            print("JSON:01")
                            let spinner1 = JGProgressHUD(style: .dark)
                            spinner1.show(in: self.view)
                            self.getConnoteDownload(getProductCode: "KM00" + self.ORDERID, SenderAddress: SellerAddress, RecipientAddress: ReceiverAddress, RoutingCode: RoutingCode, date: date)
                            spinner1.dismiss(afterDelay: 3.0)
                        }else{
                            print("JSON:02")
                            let spinner1 = JGProgressHUD(style: .dark)
                            spinner1.show(in: self.view)
                            self.EditTrackingNo(ConnoteNo: ConnoteNo)
                            
                            self.CreateConnote(ConnoteNo: ConnoteNo, ConnoteDate: date, ProductCode: "KM00" + self.ORDERID, SenderName: SellerName, SenderPhone: SellerPhone, SenderPostcode: PostCode, RecipientAccountNo: AccountNo, RecipientName: ReceiverName, RecipientAddress01: ReceiverAddress01, RecipientAddress02: ReceiverAddress02, RecipientPostcode: ReceiverPostCode, RecipientCity: ReceiverCity, RecipientState: ReceiverProvince, RecipientPhone: ReceiverPhone, RecipientEmail: ReceiverEmail, Weight: self.WEIGHT)
                            
                            self.DownloadPDF(ShipDate: date, Weight: self.WEIGHT, OrderID: self.ORDERID, SenderName: SellerName, SenderPhone: SellerPhone, SenderAddress: SellerAddress, SenderPostCode: PostCode, RecipientName: ReceiverName, RecipientPhone: ReceiverPhone, RecipientPostCode: ReceiverPostCode, RecipientAccountNO: AccountNo, RecipientAddress: ReceiverAddress, RecipientAddress01: ReceiverAddress01, RecipientAddress02: ReceiverAddress02, RecipientCity: ReceiverCity, RecipientState: ReceiverProvince, RecipientEmail: ReceiverEmail, ProductCode: self.ORDERID, Type: "Document", RoutingCode: RoutingCode, ConnoteNo: ConnoteNo, ConnoteDate: date)
                            spinner1.dismiss(afterDelay: 3.0)
                        }
                        

                    }else{
                        print("FAILED TO RECEIVE")
                    }
            }
    }
    
    //MARK:PreAcceptanceSingle
    let API_PREACCEPTANCE = "https://apis.pos.com.my/apigateway/as2corporate/api/preacceptancessingle/v1"
    let serverKey_PREACCEPTANCE = "S0FFRHRLRXhQOVlFWVRzWjhyN0FzZnNCdmRxTElvTkI="
    func PreAcceptanceSingle(subscriptionCode: String,
                             AccountNo: String, SellerName: String,
                             SellerPhone: String, SellerAddress: String,
                             PickupLocationID: String, ContactPerson: String,
                             PostCode: String, TotalQuantityToPickup: String,
                             Weight: String, ConsignmentNoteNumber: String, Amount: String,
                             ReceiverName: String, ReceiverAddress: String,
                             ReceiverPostCode: String, ReceiverPhone: String,
                             PickupDistrict: String, PickupProvince: String,
                             PickupEmail: String, ReceiverFirstName: String,
                             ReceiverLastName: String, ReceiverDistrict: String,
                             ReceiverProvince: String, ReceiverCity: String, ReceiverEmail: String){
        let headers = [
            "X-User-Key": serverKey_PREACCEPTANCE,
            "Content-Type": "application/x-www-form-urlencoded"
        ]

        let configuration = URLSessionConfiguration.default
            configuration.requestCachePolicy = .reloadIgnoringLocalCacheData

        let Parameters = [
            "subscriptionCode": subscriptionCode,
            "requireToPickup": "FALSE",
            "requireWebHook": "FALSE",
            "accountNo": "8800546487",
            "callerName": SellerName,
            "callerPhone": SellerPhone,
            "pickupLocationID": PickupLocationID,
            "pickupLocationName": SellerAddress,
            "contactPerson": ContactPerson,
            "phoneNo": SellerPhone,
            "pickupAddress": SellerAddress,
            "ItemType": "1",
            "totalQuantityToPickup": TotalQuantityToPickup,
            "totalWeight": Weight,
            "consignmentNoteNumber": ConsignmentNoteNumber,
            "PaymentType": "2",
            "Amount": Amount,
            "readyToCollectAt": "08:00 AM",
            "closeAt": "06:00 PM",
            "receiverName": ReceiverName,
            "receiverID": CUSTOMERID,
            "receiverAddress": ReceiverAddress,
            "receiverPostCode": ReceiverPostCode,
            "receiverEmail": ReceiverEmail,
            "receiverPhone01": ReceiverPhone,
            "receiverPhone02": ReceiverPhone,
            "sellerReferenceNo": "",
            "itemDescription": "",
            "sellerOrderNo": "",
            "comments": "",
            "pickupDistrict": PickupDistrict,
            "pickupProvince": PickupProvince,
            "pickupEmail": PickupEmail,
            "pickupCountry": "MY",
            "pickupLocation": "",
            "receiverFname": ReceiverName,
            "receiverLname": ReceiverName,
            "receiverAddress2": ReceiverAddress,
            "receiverDistrict": ReceiverDistrict,
            "receiverProvince": ReceiverProvince,
            "receiverCity": ReceiverCity,
            "receiverCountry": "MY",
            "packDesc": "",
            "packVol": "",
            "packLeng": "",
            "postCode": PostCode,
            "ConsignmentNoteNumber": "ERC500599407MY",
            "packWidth": "",
            "packHeight": "",
            "packTotalitem": "",
            "orderDate": "",
            "packDeliveryType": "",
            "ShipmentName": "PosLaju",
            "pickupProv": PickupProvince,
            "deliveryProv": "",
            "postalCode": ReceiverPostCode,
            "currency": "MYR",
            "countryCode": "MY"
        ]

            Alamofire.request(API_PREACCEPTANCE, method: .post,parameters: Parameters, encoding: URLEncoding.httpBody, headers: headers).responseJSON
                {
                    response in
                    if let result = response.result.value {
                        print("JSON: \(result)")
                    }else{
                        print("Request failed with error: ",response.result.error ?? "Description not available :(")
                    }
            }
    }
    
    //MARK: Generate PDF
    func GeneratePDF(ShipDate: String, Weight: String,
                     OrderID: String, SenderName: String,
                     SenderPhone: String, SenderAddress: String,
                     SenderPostCode: String, RecipientName: String,
                     RecipientPhone: String, RecipientPostCode: String,
                     RecipientAccountNO: String, RecipientAddress: String,
                     RecipientAddress01: String, RecipientAddress02: String,
                     RecipientCity: String, RecipientState: String,
                     RecipientEmail: String, ProductCode: String,
                     Type: String, RoutingCode: String,
                     ConnoteNo: String, ConnoteDate: String){
        let pdf = self.storyboard!.instantiateViewController(withIdentifier: "PosLajuTestArea") as! PosLajuTestArea
        if let navigator = self.navigationController {
            pdf.DATE = ShipDate
            pdf.WEIGHT = Weight
            pdf.ORDERID = "KM" + ORDERID
            pdf.SELLERNAME = SenderName
            pdf.SELLERPHONE = SenderPhone
            pdf.SELLERADDRESS = SenderAddress
            pdf.POSTCODE = SenderPostCode
            pdf.RECEIVERNAME = RecipientName
            pdf.RECEIVERPHONE = RecipientPhone
            pdf.ACCOUNTNO = RecipientAccountNO
            pdf.RECEIVERADDRESS = RecipientAddress
            pdf.RECEIVERADDRESS01 = RecipientAddress01
            pdf.RECEIVERADDRESS02 = RecipientAddress02
            pdf.RECEIVERCITY = RecipientCity
            pdf.RECEIVERPROVINCE = RecipientState
            pdf.RECEIVEREMAIL = RecipientEmail
            pdf.RECEIVERPOSTCODE = RecipientPostCode
            pdf.ROUTINGCODE = RoutingCode
            pdf.CONNOTENO = ConnoteNo
            navigator.pushViewController(pdf, animated: true)
        }
    }
    
    //MARK: Download PDF
    func DownloadPDF(ShipDate: String, Weight: String,
                     OrderID: String, SenderName: String,
                     SenderPhone: String, SenderAddress: String,
                     SenderPostCode: String, RecipientName: String,
                     RecipientPhone: String, RecipientPostCode: String,
                     RecipientAccountNO: String, RecipientAddress: String,
                     RecipientAddress01: String, RecipientAddress02: String,
                     RecipientCity: String, RecipientState: String,
                     RecipientEmail: String, ProductCode: String,
                     Type: String, RoutingCode: String,
                     ConnoteNo: String, ConnoteDate: String){
        let pdf = self.storyboard!.instantiateViewController(withIdentifier: "PrintingPDF") as! PrintingPDF
        if let navigator = self.navigationController {
            pdf.DATE = ShipDate
            pdf.WEIGHT = Weight
            pdf.ORDERID = ORDERID
            pdf.SELLERNAME = SenderName
            pdf.SELLERPHONE = SenderPhone
            pdf.SELLERADDRESS = SenderAddress
            pdf.POSTCODE = SenderPostCode
            pdf.RECEIVERNAME = RecipientName
            pdf.RECEIVERPHONE = RecipientPhone
            pdf.ACCOUNTNO = RecipientAccountNO
            pdf.RECEIVERADDRESS = RecipientAddress
            pdf.RECEIVERADDRESS01 = RecipientAddress01
            pdf.RECEIVERADDRESS02 = RecipientAddress02
            pdf.RECEIVERCITY = RecipientCity
            pdf.RECEIVERPROVINCE = RecipientState
            pdf.RECEIVEREMAIL = RecipientEmail
            pdf.RECEIVERPOSTCODE = RecipientPostCode
            pdf.ROUTINGCODE = RoutingCode
            pdf.CONNOTENO = ConnoteNo
            navigator.pushViewController(pdf, animated: true)
        }
    }
    
    func sendEmail(Email: String, OrderID: String){
        let parameters: Parameters=[
            "email": Email,
            "order_id": OrderID
        ]

        Alamofire.request(URL_SEND, method: .post, parameters: parameters).responseJSON
            {
                response in
                print(response)
        }
    }

    @IBAction func Preview(_ sender: Any) {
        spinner.show(in: self.view)
        PosLajuGetData(customerID: self.CUSTOMERID, OrderID: "KM00" + self.ORDERID, subscriptionCode: "admin@ketekmall.com", AccountNo: "8800546487")
        GetPlayerData(CustomerID: self.CUSTOMERID, OrderID: self.ORDERID)
        self.spinner.dismiss(afterDelay: 3.0)
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
            print("downloadLocation:", location)
            // create destination URL with the original pdf name
            guard let url = downloadTask.originalRequest?.url else { return }
            let documentsPath = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
            let destinationURL = documentsPath.appendingPathComponent(url.lastPathComponent)
            // delete original copy
            try? FileManager.default.removeItem(at: destinationURL)
            // copy from temp to Document
            do {
                try FileManager.default.copyItem(at: location, to: destinationURL)
//                    self.pdfURL = destinationURL
            } catch let error {
                print("Copy Error: \(error.localizedDescription)")
            }
        }
    
    @IBAction func Download(_ sender: Any) {
        spinner.show(in: self.view)
        PosLajuGetData02(customerID: self.CUSTOMERID, OrderID: "KM00" + self.ORDERID, subscriptionCode: "admin@ketekmall.com", AccountNo: "8800546487")
        self.showToast(message: "Downloading...", font: .systemFont(ofSize: 12.0))
        self.spinner.dismiss(afterDelay: 3.0)
    }
    
    func EditTrackingNo(ConnoteNo: String){
        let parameters: Parameters=[
            "id": ORDERID,
            "tracking_no": ConnoteNo
        ]
        Alamofire.request(URL_editTrackingNo, method: .post, parameters: parameters).responseJSON
            {
                response in
                //printing response
                print(response)
                
                //getting the json value from the server
                if let result = response.result.value {
                    
                    //converting it as NSDictionary
                    let jsonData = result as! NSDictionary
                    print(jsonData.value(forKey: "message")!)
                    self.spinner.dismiss(afterDelay: 3.0)
                }else{
                    print("FAILED")
                    self.spinner.dismiss(afterDelay: 3.0)
                }
                
        }
    }
    
    @IBAction func Submit(_ sender: Any) {
//        print("\(TrackingNo.text!)")
        spinner.show(in: self.view)
        let parameters: Parameters=[
            "order_date": ORDER_DATE,
            "tracking_no": TrackingNo.text!
        ]
        Alamofire.request(URL_EDIT, method: .post, parameters: parameters).responseJSON
            {
                response in
                //printing response
                print(response)
                
                //getting the json value from the server
                if let result = response.result.value {
                    
                    //converting it as NSDictionary
                    let jsonData = result as! NSDictionary
                    print(jsonData.value(forKey: "message")!)
                    self.spinner.dismiss(afterDelay: 3.0)
                }else{
                    print("FAILED")
                    self.spinner.dismiss(afterDelay: 3.0)
                }
                
        }
    }
    
    func CreateConnote(ConnoteNo: String, ConnoteDate: String,
                               ProductCode: String, SenderName: String,
                               SenderPhone: String, SenderPostcode: String,
                               RecipientAccountNo: String, RecipientName: String,
                               RecipientAddress01: String, RecipientAddress02: String,
                               RecipientPostcode: String, RecipientCity: String,
                               RecipientState: String, RecipientPhone: String,
                               RecipientEmail: String, Weight: String){
        let parameters: Parameters=[
            "ConnoteNo": ConnoteNo,
            "ConnoteDate": ConnoteDate,
            "ProductCode": ProductCode,
            "SenderName": SenderName,
            "SenderPhone": SenderPhone,
            "SenderPostcode": SenderPostcode,
            "RecipientAccountNo": RecipientAccountNo,
            "RecipientName": RecipientName,
            "RecipientAddress01": RecipientAddress01,
            "RecipientAddress02": RecipientAddress02,
            "RecipientPostcode": RecipientPostcode,
            "RecipientCity": RecipientCity,
            "RecipientState": RecipientState,
            "RecipientPhone": RecipientPhone,
            "RecipientEmail": RecipientEmail,
            "Weight": Weight,
            "Type": "Document"
        ]
        Alamofire.request(URL_createConnote, method: .post, parameters: parameters).responseJSON
            {
                response in
                //printing response
                print(response)
                
                //getting the json value from the server
                if let result = response.result.value {
                    
                    //converting it as NSDictionary
                    let jsonData = result as! NSDictionary
                    print(jsonData.value(forKey: "message")!)
                    self.spinner.dismiss(afterDelay: 3.0)
                }else{
                    print("FAILED")
                    self.spinner.dismiss(afterDelay: 3.0)
                }
                
        }
    }
    
    func getConnoteDownload(getProductCode: String, SenderAddress: String,
                            RecipientAddress: String, RoutingCode: String,
                            date: String){
        print("\(getProductCode)")
        let parameters: Parameters=[
            "ProductCode": getProductCode
        ]
        Alamofire.request(URL_getConnote, method: .post, parameters: parameters).responseJSON
            {
                response in

                if let result = response.result.value{
                    let jsonData = result as! NSDictionary

                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        print("\(response)")
                        self.spinner.dismiss(afterDelay: 3.0)
                        let user = jsonData.value(forKey: "read") as! NSArray
                        let ConnoteNo = user.value(forKey: "ConnoteNo") as! [String]
                        let ConnoteDate = user.value(forKey: "ConnoteDate") as! [String]
                        let ProductCode = user.value(forKey: "ProductCode") as! [String]
                        let SenderName = user.value(forKey: "SenderName") as! [String]
                        let SenderPhone = user.value(forKey: "SenderPhone") as! [String]
                        let SenderPostcode = user.value(forKey: "SenderPostcode") as! [String]
                        let RecipientAccountNo = user.value(forKey: "RecipientAccountNo") as! [String]
                        let RecipientName = user.value(forKey: "RecipientName") as! [String]
                        let RecipientAddress01 = user.value(forKey: "RecipientAddress01") as! [String]
                        let RecipientAddress02 = user.value(forKey: "RecipientAddress02") as! [String]
                        let RecipientPostcode = user.value(forKey: "RecipientPostcode") as! [String]
                        let RecipientCity = user.value(forKey: "RecipientCity") as! [String]
                        let RecipientState = user.value(forKey: "RecipientState") as! [String]

                        let RecipientPhone = user.value(forKey: "RecipientPhone") as! [String]
                        let RecipientEmail = user.value(forKey: "RecipientEmail") as! [String]
                        let Weight = user.value(forKey: "Weight") as! [String]
                        let Type = user.value(forKey: "Type") as! [String]

                        self.CONNOTENO = ConnoteNo[0]
                        self.CONNOTEDATE = ConnoteDate[0]
                        self.PRODUCTCODE = ProductCode[0]
                        self.SENDERNAME = SenderName[0]
                        self.SENDERPHONE = SenderPhone[0]
                        self.SENDERPOSTCODE = SenderPostcode[0]
                        self.RECIPIENTACCOUNTNO = RecipientAccountNo[0]
                        self.RECIPIENTNAME = RecipientName[0]
                        self.RECIPIENTADDRESS01 = RecipientAddress01[0]
                        self.RECIPIENTADDRESS02 = RecipientAddress02[0]
                        self.RECIPIENTPOSTCODE = RecipientPostcode[0]
                        self.RECIPIENTCITY = RecipientCity[0]
                        self.RECIPIENTSTATE = RecipientState[0]
                        self.RECIPIENTPHONE = RecipientPhone[0]
                        self.RECIPIENTEMAIL = RecipientEmail[0]
                        self.WEIGHTCONNOTE = Weight[0]
                        self.TYPE = Type[0]

                        self.DownloadPDF(ShipDate: date, Weight: self.WEIGHTCONNOTE, OrderID: getProductCode, SenderName: self.SENDERNAME, SenderPhone: self.SENDERPHONE, SenderAddress: SenderAddress, SenderPostCode: self.SENDERPOSTCODE, RecipientName: self.RECIPIENTNAME, RecipientPhone: self.RECIPIENTPHONE, RecipientPostCode: self.RECIPIENTPOSTCODE, RecipientAccountNO: self.RECIPIENTACCOUNTNO, RecipientAddress: RecipientAddress, RecipientAddress01: self.RECIPIENTADDRESS01, RecipientAddress02: self.RECIPIENTADDRESS02, RecipientCity: self.RECIPIENTCITY, RecipientState: self.RECIPIENTSTATE, RecipientEmail: self.RECIPIENTEMAIL, ProductCode: self.PRODUCTCODE, Type: self.TYPE, RoutingCode: RoutingCode, ConnoteNo: ConnoteNo[0], ConnoteDate: self.CONNOTEDATE)

                    }
                }
        }
    }
    
    func getConnoteShare(getProductCode: String, SenderAddress: String,
                            RecipientAddress: String, RoutingCode: String,
                            date: String){
        let parameters: Parameters=[
            "ProductCode": getProductCode
        ]
        Alamofire.request(URL_getConnote, method: .post, parameters: parameters).responseJSON
            {
                response in

                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        self.spinner.dismiss(afterDelay: 3.0)
                        let user = jsonData.value(forKey: "read") as! NSArray
                        let ConnoteNo = user.value(forKey: "ConnoteNo") as! [String]
                        let ConnoteDate = user.value(forKey: "ConnoteDate") as! [String]
                        let ProductCode = user.value(forKey: "ProductCode") as! [String]
                        let SenderName = user.value(forKey: "SenderName") as! [String]
                        let SenderPhone = user.value(forKey: "SenderPhone") as! [String]
                        let SenderPostcode = user.value(forKey: "SenderPostcode") as! [String]
                        let RecipientAccountNo = user.value(forKey: "RecipientAccountNo") as! [String]
                        let RecipientName = user.value(forKey: "RecipientName") as! [String]
                        let RecipientAddress01 = user.value(forKey: "RecipientAddress01") as! [String]
                        let RecipientAddress02 = user.value(forKey: "RecipientAddress02") as! [String]
                        let RecipientPostcode = user.value(forKey: "RecipientPostcode") as! [String]
                        let RecipientCity = user.value(forKey: "RecipientCity") as! [String]
                        let RecipientState = user.value(forKey: "RecipientState") as! [String]
                        
                        let RecipientPhone = user.value(forKey: "RecipientPhone") as! [String]
                        let RecipientEmail = user.value(forKey: "RecipientEmail") as! [String]
                        let Weight = user.value(forKey: "Weight") as! [String]
                        let Type = user.value(forKey: "Type") as! [String]
                        
                        self.CONNOTENO = ConnoteNo[0]
                        self.CONNOTEDATE = ConnoteDate[0]
                        self.PRODUCTCODE = ProductCode[0]
                        self.SENDERNAME = SenderName[0]
                        self.SENDERPHONE = SenderPhone[0]
                        self.SENDERPOSTCODE = SenderPostcode[0]
                        self.RECIPIENTACCOUNTNO = RecipientAccountNo[0]
                        self.RECIPIENTNAME = RecipientName[0]
                        self.RECIPIENTADDRESS01 = RecipientAddress01[0]
                        self.RECIPIENTADDRESS02 = RecipientAddress02[0]
                        self.RECIPIENTPOSTCODE = RecipientPostcode[0]
                        self.RECIPIENTCITY = RecipientCity[0]
                        self.RECIPIENTSTATE = RecipientState[0]
                        self.RECIPIENTPHONE = RecipientPhone[0]
                        self.RECIPIENTEMAIL = RecipientEmail[0]
                        self.WEIGHTCONNOTE = Weight[0]
                        self.TYPE = Type[0]
                        
                        self.GeneratePDF(ShipDate: date, Weight: self.WEIGHTCONNOTE, OrderID: getProductCode, SenderName: self.SENDERNAME, SenderPhone: self.SENDERPHONE, SenderAddress: SenderAddress, SenderPostCode: self.SENDERPOSTCODE, RecipientName: self.RECIPIENTNAME, RecipientPhone: self.RECIPIENTPHONE, RecipientPostCode: self.RECIPIENTPOSTCODE, RecipientAccountNO: self.RECIPIENTACCOUNTNO, RecipientAddress: RecipientAddress, RecipientAddress01: self.RECIPIENTADDRESS01, RecipientAddress02: self.RECIPIENTADDRESS02, RecipientCity: self.RECIPIENTCITY, RecipientState: self.RECIPIENTSTATE, RecipientEmail: self.RECIPIENTEMAIL, ProductCode: self.PRODUCTCODE, Type: self.TYPE, RoutingCode: RoutingCode, ConnoteNo: self.CONNOTENO, ConnoteDate: self.CONNOTEDATE)
                        
                    }
                }
        }
    }
    
    func GetPlayerData(CustomerID: String, OrderID: String){
        let parameters: Parameters=[
            "UserID": CustomerID
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
                        
                        self.OneSignalNoti(PlayerID: PlayerID[0], Name: Name[0], OrderID: OrderID)
                    }
                }else{
                    print("FAILED")
                }
                
        }
    }
    
    func OneSignalNoti(PlayerID: String, Name: String, OrderID: String){
        let parameters: Parameters=[
            "PlayerID": PlayerID,
            "Name": Name,
            "Words": "Your Order " + OrderID + " have been shipped! Please check My Buying for more details."
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
    
    @objc func keyboardWillShow(sender: NSNotification) {
         self.view.frame.origin.y = -150 // Move view 150 points upward
    }

    @objc func keyboardWillHide(sender: NSNotification) {
         self.view.frame.origin.y = 0 // Move view to original position
    }
}

