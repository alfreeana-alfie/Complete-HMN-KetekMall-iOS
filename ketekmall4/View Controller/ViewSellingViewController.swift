
import UIKit
import Alamofire
import JGProgressHUD
import PDFKit

class ViewSellingViewController: UIViewController {

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
    
    @IBOutlet weak var ButtonSubmit: UIButton!
    @IBOutlet weak var ButtonCancel: UIButton!
    
    @IBOutlet weak var PosLabel: UILabel!
    
    
    let URL_READ_CUSTOMER = "https://ketekmall.com/ketekmall/read_detail.php"
    let URL_EDIT = "https://ketekmall.com/ketekmall/edit_tracking_no.php"
    let URL_SEND = "https://ketekmall.com/ketekmall/sendEmail_product_reject.php"
    let URL_GET_PLAYERID = "https://ketekmall.com/ketekmall/getPlayerID.php"
    let URL_NOTI = "https://ketekmall.com/ketekmall/onesignal_noti.php"
    
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
//    @IBOutlet weak var TrackingHeight: NSLayoutConstraint!
    @IBOutlet weak var SubmitHeight: NSLayoutConstraint!
    
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
        Item_Price.text! = "MYR" + ITEMPRICE
        Date_Order.text! = "Order Placed on" + DATEORDER
        Ship_Place.text! = "Shipped out to" + SHIPPLACED
        Status.text! = STATUS
        Quantity.text! = "x" + QUANTITY
        
        ButtonSubmit.layer.cornerRadius = 5
        ButtonCancel.layer.cornerRadius = 5
        
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
        }else if(STATUS == "Reject"){
            
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
            ButtonSubmit.isHidden = true
            SubmitHeight.constant = 0
            
        }else if(STATUS == "Cancel"){
            
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
            ButtonSubmit.isHidden = true
            SubmitHeight.constant = 0
        }
        
        
        getUserDetails()
        
        
    }
    
    func ColorFunc(){
        //Button Accept
        let color1 = UIColor(hexString: "#FC4A1A").cgColor
        let color2 = UIColor(hexString: "#F7B733").cgColor
        
        let ReceivedGradient = CAGradientLayer()
        ReceivedGradient.frame = ButtonSubmit.bounds
        ReceivedGradient.colors = [color1, color2]
        ReceivedGradient.startPoint = CGPoint(x: 0, y: 0.5)
        ReceivedGradient.endPoint = CGPoint(x: 1, y: 0.5)
        ReceivedGradient.cornerRadius = 5
            ButtonSubmit.layer.insertSublayer(ReceivedGradient, at: 0)
        
        //Button Cancel
        let color3 = UIColor(hexString: "#FC4A1A").cgColor
        let color4 = UIColor(hexString: "#F7B733").cgColor
        
        let CancelGradient = CAGradientLayer()
        CancelGradient.frame = ButtonCancel.bounds
        CancelGradient.colors = [color3, color4]
        CancelGradient.startPoint = CGPoint(x: 0, y: 0.5)
        CancelGradient.endPoint = CGPoint(x: 1, y: 0.5)
        CancelGradient.cornerRadius = 5
        ButtonCancel.layer.insertSublayer(CancelGradient, at: 0)
    }
    
    func changeLanguage(str: String){
        ButtonSubmit.titleLabel?.text = "SUBMIT".localized(lang: str)
        ButtonCancel.titleLabel?.text = "Cancel".localized(lang: str)
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

        Alamofire.request(HTTP_GenConnote + "?numberOfItem=" + numberOfItem + "&Prefix=ERC" + "&ApplicationCode=HNM" + "&Secretid=HM@$343" + "&Orderid=" + "4" + "&username=HMNNadhir", method: .get, encoding: URLEncoding.httpBody, headers: headers).responseJSON
                {
                    response in
                    if let result = response.result.value {
                        let details = result as! NSObject
                        
                        let ConnoteNo = details.value(forKey: "ConnoteNo") as! String
                        print("JSON: \(ConnoteNo)")
                        
                        self.PreAcceptanceSingle(subscriptionCode: subscriptionCode, AccountNo: AccountNo, SellerName: SellerName, SellerPhone: SellerPhone, SellerAddress: SellerAddress, PickupLocationID: PickupLocationID, ContactPerson: ContactPerson, PostCode: PostCode, TotalQuantityToPickup: TotalQuantityToPickup, Weight: self.WEIGHT, ConsignmentNoteNumber: ConnoteNo, Amount: self.AMOUNT, ReceiverName: ReceiverName, ReceiverAddress: ReceiverAddress, ReceiverPostCode: ReceiverPostCode, ReceiverPhone: ReceiverPhone, PickupDistrict: PickupDistrict, PickupProvince: PickupProvince, PickupEmail: PickupEmail, ReceiverFirstName: ReceiverFirstName, ReceiverLastName: ReceiverLastName, ReceiverDistrict: ReceiverDistrict, ReceiverProvince: ReceiverProvince, ReceiverCity: ReceiverCity, ReceiverEmail: ReceiverEmail)
                        
                        self.GeneratePDF(ShipDate: date, Weight: self.WEIGHT, OrderID: self.ORDERID, SenderName: SellerName, SenderPhone: SellerPhone, SenderAddress: SellerAddress, SenderPostCode: PostCode, RecipientName: ReceiverName, RecipientPhone: ReceiverPhone, RecipientPostCode: ReceiverPostCode, RecipientAccountNO: AccountNo, RecipientAddress: ReceiverAddress, RecipientAddress01: ReceiverAddress01, RecipientAddress02: ReceiverAddress02, RecipientCity: ReceiverCity, RecipientState: ReceiverProvince, RecipientEmail: ReceiverEmail, ProductCode: self.ORDERID, Type: "Document", RoutingCode: RoutingCode, ConnoteNo: ConnoteNo, ConnoteDate: date)
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

    @IBAction func Submit(_ sender: Any) {
        
        PosLajuGetData(customerID: self.CUSTOMERID, OrderID: "KM" + self.ORDERID, subscriptionCode: "admin@ketekmall.com", AccountNo: "8800546487")
        GetPlayerData(CustomerID: self.CUSTOMERID, OrderID: self.ORDERID)
    }
    
    @IBAction func Cancel(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
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
}
