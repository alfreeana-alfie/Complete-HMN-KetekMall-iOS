

import UIKit
import Alamofire
import JGProgressHUD

class MySellingViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, MySellingDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var MySellingView: UICollectionView!
    
    private let spinner = JGProgressHUD(style: .dark)
    
    let URL_READ = "https://ketekmall.com/ketekmall/read_order_buyer_done_two.php"
    let URL_REJECT = "https://ketekmall.com/ketekmall/edit_order.php"
    let URL_READ_CUSTOMER = "https://ketekmall.com/ketekmall/read_detail.php"
    let URL_SEND = "https://ketekmall.com/ketekmall/sendEmail_product_reject.php"
    let URL_GET_PLAYERID = "https://ketekmall.com/ketekmall/getPlayerID.php"
    let URL_NOTI = "https://ketekmall.com/ketekmall/onesignal_noti.php"
    
    var item_photo: [String] = []
    var ad_Detail: [String] = []
    var item_price: [String] = []
    var item_quantity: [String] = []
    var item_orderDate: [String] = []
    var item_Shipped: [String] = []
    var item_status: [String] = []
    var item_orderID: [String] = []
    var order_date: [String] = []
    var customer_id: [String] = []
    var tracking_no: [String] = []
    var postcode: [String] = []
    var weight: [String] = []
    var deliveryprice: [String] = []
    
    let sharedPref = UserDefaults.standard
    var lang: String = ""

    var userID: String = ""
    var CustEmail: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lang = sharedPref.string(forKey: "LANG") ?? "0"
        

        MySellingView.delegate = self
        MySellingView.dataSource = self
        
        navigationItem.title = "My Selling"
        spinner.show(in: self.view)
        let parameters: Parameters=[
            "seller_id": userID,
        ]
        
        //Sending http post request
        Alamofire.request(URL_READ, method: .post, parameters: parameters).responseJSON
            {
                response in
                //printing response
                print(response)
                
                //getting the json value from the server
                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        self.spinner.dismiss(afterDelay: 3.0)
                        let user = jsonData.value(forKey: "read") as! NSArray
                        
                        //                                let userID = user.value(forKey: "user_id") as! [String]
                        let AdDetail = user.value(forKey: "ad_detail") as! [String]
                        let CustomerID = user.value(forKey: "customer_id") as! [String]
                        let OrderID = user.value(forKey: "id") as! [String]
                        let Price = user.value(forKey: "price") as! [String]
                        let Quantity = user.value(forKey: "quantity") as! [String]
                        let OrderDate = user.value(forKey: "date") as! [String]
                        let Status = user.value(forKey: "status") as! [String]
                        let Photo = user.value(forKey: "photo") as! [String]
                        let Division = user.value(forKey: "division") as! [String]
                        let Order_Date = user.value(forKey: "order_date") as! [String]
                        
                        let Tracking_NO = user.value(forKey: "tracking_no") as! [String]
                        let DeliveryPrice = user.value(forKey: "delivery_price") as! [String]
                        let PostCode = user.value(forKey: "postcode") as! [String]
                        let Weight = user.value(forKey: "weight") as! [String]
                        
                        self.tracking_no = Tracking_NO
                        self.customer_id = CustomerID
                        self.item_orderID = OrderID
                        self.ad_Detail = AdDetail
                        self.item_photo = Photo
                        self.item_price = Price
                        self.item_quantity = Quantity
                        self.item_orderDate = OrderDate
                        self.item_Shipped = Division
                        self.item_status = Status
                        self.postcode = PostCode
                        self.weight = Weight
                        self.deliveryprice = DeliveryPrice
                        self.order_date = Order_Date
                        
                        self.MySellingView.reloadData()
                        
                    }
                }
        }
        
    }
    
    
    func getCustomerDetails(CustomerID: String, OrderID: String){
        let parameters: Parameters=[
            "id": CustomerID,
        ]
        Alamofire.request(URL_READ_CUSTOMER, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        let user = jsonData.value(forKey: "read") as! NSArray
                        let CustomerEmail = user.value(forKey: "email") as! [String]
                        
                        self.CustEmail = CustomerEmail[0]
                        
                        self.sendEmail(Email: self.CustEmail, OrderID: OrderID)
                    }
                }
        }
    }
    
    func sendEmail(Email: String, OrderID: String){
        let parameters: Parameters=[
            "email": Email,
            "order_id": OrderID
        ]
        
        //Sending http post request
        Alamofire.request(URL_SEND, method: .post, parameters: parameters).responseJSON
            {
                response in
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return item_orderID.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let screenSize = collectionView.bounds
            let screenWidth = screenSize.width
    //        let screenHeight = screenSize.height
            let cellSquareSize: CGFloat = screenWidth
            let cellSquareHeight: CGFloat = 250
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MySellingCollectionViewCell", for: indexPath) as! MySellingCollectionViewCell
        
        cell.OrderID.text! = "KM" + self.item_orderID[indexPath.row]
        cell.AdDetail.text! = self.ad_Detail[indexPath.row]
        cell.Price.text! = "MYR" + self.item_price[indexPath.row]
        cell.Quantity.text! = "x" + self.item_quantity[indexPath.row]
        cell.DateOrder.text! = "Order Placed on " + self.item_orderDate[indexPath.row]
        cell.ShipPlace.text! = "Shipped out to " + self.item_Shipped[indexPath.row]
        cell.Status.text! = self.item_status[indexPath.row]
        let NEWIm = self.item_photo[indexPath.row].addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        
        cell.ItemImage.setImageWith(URL(string: NEWIm!)!)
        cell.ButtonView.layer.cornerRadius = 7
        cell.ButtonReject.layer.cornerRadius = 7
        if(lang == "ms"){
            cell.ButtonView.setTitle("VIEW".localized(lang: "ms"), for: .normal)
            cell.ButtonReject.setTitle("REJECT".localized(lang: "ms"), for: .normal)
        }else{
            cell.ButtonView.setTitle("VIEW".localized(lang: "en"), for: .normal)
            cell.ButtonReject.setTitle("REJECT".localized(lang: "en"), for: .normal)
        }
        
        let color1 = UIColor(hexString: "#FC4A1A").cgColor
        let color2 = UIColor(hexString: "#F7B733").cgColor
        
        let ReceivedGradient = CAGradientLayer()
        ReceivedGradient.frame = cell.ButtonView.bounds
        ReceivedGradient.colors = [color1, color2]
        ReceivedGradient.startPoint = CGPoint(x: 0, y: 0.5)
        ReceivedGradient.endPoint = CGPoint(x: 1, y: 0.5)
        ReceivedGradient.cornerRadius = 5
            cell.ButtonView.layer.insertSublayer(ReceivedGradient, at: 0)
        
        //Button Cancel
        let color3 = UIColor(hexString: "#FC4A1A").cgColor
        let color4 = UIColor(hexString: "#F7B733").cgColor
        
        let CancelGradient = CAGradientLayer()
        CancelGradient.frame = cell.ButtonReject.bounds
        CancelGradient.colors = [color3, color4]
        CancelGradient.startPoint = CGPoint(x: 0, y: 0.5)
        CancelGradient.endPoint = CGPoint(x: 1, y: 0.5)
        CancelGradient.cornerRadius = 5
        cell.ButtonReject.layer.insertSublayer(CancelGradient, at: 0)
        cell.delegate = self
        return cell
    }
    
    func btnREJECT(cell: MySellingCollectionViewCell) {
        guard let indexPath = self.MySellingView.indexPath(for: cell) else{
            return
        }
        
        let CustID = self.customer_id[indexPath.row]
        let Order_ID = self.item_orderID[indexPath.row]
        let Order_Date = self.order_date[indexPath.row]
        let Remarks = "Reject"
        
        
        let parameters: Parameters=[
            "order_date": Order_Date,
            "remarks": Remarks,
            "status": Remarks
        ]
        
        //Sending http post request
        Alamofire.request(URL_REJECT, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        self.getCustomerDetails(CustomerID: CustID, OrderID: Order_ID)
                        self.spinner.indicatorView = JGProgressHUDSuccessIndicatorView()
                        self.spinner.textLabel.text = "Successfully Rejected"
                        self.spinner.show(in: self.view)
                        self.spinner.dismiss(afterDelay: 4.0)
                        
                        self.GetPlayerData(CustomerID: CustID, OrderID: Order_ID)
                    }
                }
        }
        
    }
    
    func btnVIEW(cell: MySellingCollectionViewCell) {
        guard let indexPath = self.MySellingView.indexPath(for: cell) else{
            return
        }
        
        let Amount01 = Double(self.item_price[indexPath.row])! * Double(self.item_quantity[indexPath.row])!
        let Amount02 = Amount01 + Double(self.deliveryprice[indexPath.row])!
        let TotalAmount = String(format: "%.2f", Amount02)
        
        let MySelling = self.storyboard!.instantiateViewController(withIdentifier: "ViewSellingViewController") as! ViewSellingViewController
        let ID = self.item_orderID[indexPath.row]
        MySelling.ItemID = ID
        MySelling.USERID = self.userID
        MySelling.ITEMIMAGE = self.item_photo[indexPath.row]
        MySelling.ITEMNAME = self.ad_Detail[indexPath.row]
        MySelling.ORDERID = self.item_orderID[indexPath.row]
        MySelling.ITEMPRICE = self.item_price[indexPath.row]
        MySelling.DATEORDER = self.item_orderDate[indexPath.row]
        MySelling.SHIPPLACED = self.item_Shipped[indexPath.row]
        MySelling.STATUS = self.item_status[indexPath.row]
        MySelling.QUANTITY = self.item_quantity[indexPath.row]
        MySelling.CUSTOMERID = self.customer_id[indexPath.row]
        MySelling.ORDER_DATE = self.order_date[indexPath.row]
        MySelling.AMOUNT = TotalAmount
        MySelling.POSTCODE = self.postcode[indexPath.row]
        MySelling.WEIGHT = self.weight[indexPath.row]
        if let navigator = self.navigationController {
            navigator.pushViewController(MySelling, animated: true)
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
            "Words": "Order KM" + OrderID + " have been rejected! Please contact respective Seller for more details."
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
