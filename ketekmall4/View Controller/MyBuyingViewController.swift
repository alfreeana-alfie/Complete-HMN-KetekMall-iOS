
import UIKit
import Alamofire
import JGProgressHUD

class MyBuyingViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, MyBuyingDelegate, UICollectionViewDelegateFlowLayout, UITabBarDelegate {
    
    
    @IBOutlet weak var MyBuyingView: UICollectionView!
    
    private let spinner = JGProgressHUD(style: .dark)
    
    let URL_READ = "https://ketekmall.com/ketekmall/read_order_buyer_done.php";
    let URL_CANCEL = "https://ketekmall.com/ketekmall/edit_order.php";
    let URL_SEND = "https://ketekmall.com/ketekmall/edit_order.php";
    let Main_Photo = "https://ketekmall.com/ketekmall/profile_image/main_photo.png"
    let URL_GET_PLAYERID = "https://ketekmall.com/ketekmall/getPlayerID.php"
    let URL_NOTI = "https://ketekmall.com/ketekmall/onesignal_noti.php"
    let URL_getPayment = "https://ketekmall.com/ketekmall/getPaymentBuyerIOS.php"
    let URL_updateOrder = "https://ketekmall.com/ketekmall/updateOrder.php"
    
    var userID: String = ""
    var order_id: String = ""
    var item_id: String = ""
    var ad_detail: String = ""
    var item_img: String = ""
    var item_price: String = ""
    var item_quantity: String = ""
    var item_orderplaced: String = ""
    var item_shipplaced: String = ""
    var item_status: String = ""
    var order_date: String = ""
    var tracking_no: String = ""
    var delivery_price: String = ""
    var delivery_date: String = ""
    var seller_division: String = ""
    var Seller_ID: String = ""
    var refno: String = ""
    var payStatus: String = ""
    
    var SellerEmail:String = ""
    var viewController1: UIViewController?
    @IBOutlet weak var Tabbar: UITabBar!
    var OrderID: [String] = []
    var ItemID: [String] = []
    
    var ad_Detail: [String] = []
    var ItemImage: [String] = []
    var ItemPrice: [String] = []
    var ItemQuan: [String] = []
    var Seller_Division: [String] = []
    var ItemOrderPlaced: [String] = []
    var ItemShipPlaced: [String] = []
    var ItemStatus: [String] = []
    var OrderDate: [String] = []
    
    var seller_id: [String] = []
    var TrackingNo: [String] = []
    var DeliveryPrice: [String] = []
    var DeliveryDate: [String] = []
    var RefNo: [String] = []
    var PaymentStatus: [String] = []
    
    var BarHidden: Bool = false
    @IBOutlet weak var BarHeight: NSLayoutConstraint!
    
    let sharedPref = UserDefaults.standard
    var lang: String = ""
    
    override func viewDidAppear(_ animated: Bool) {
//        ColorFunc()
    }
    
    func getList(){
        let parameters: Parameters=[
            "customer_id": userID,
        ]
        
        //Sending http post request
        Alamofire.request(URL_getPayment, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value as? Dictionary<String,Any>{
                    if let list = result["read"] as? [Dictionary<String,Any>]{
                        self.spinner.dismiss(afterDelay: 3.0)
                        for i in list{
                            self.order_id = i["id"] as! String
                            self.item_id = i["item_id"] as! String
                            self.ad_detail = i["ad_detail"] as! String
                            self.item_img = i["photo"] as! String
                            self.item_price = i["price"] as! String
                            self.item_quantity = i["quantity"] as! String
                            self.item_orderplaced = i["date"] as! String
                            self.item_shipplaced = i["division"] as! String
                            self.item_status = i["status"] as! String
                            self.order_date = i["order_date"] as! String
                            self.delivery_price = i["delivery_price"] as! String
                            self.delivery_date = i["delivery_date"] as! String
                            self.tracking_no = i["tracking_no"] as! String
                            self.Seller_ID = i["seller_id"] as! String
                            self.seller_division = i["seller_division"] as! String
//                            self.refno = i["refno"] as! String
                            self.payStatus = i["Status"] as! String
                            
                            self.seller_id.append(self.Seller_ID)
                            self.Seller_Division.append(self.seller_division)
                            self.OrderID.append(self.order_id)
                            self.ItemID.append(self.item_id)
                            
                            self.ad_Detail.append(self.ad_detail)
                            self.ItemImage.append(self.item_img)
                            self.ItemPrice.append(self.item_price)
                            self.ItemQuan.append(self.item_quantity)
                            self.ItemOrderPlaced.append(self.item_orderplaced)
                            self.ItemShipPlaced.append(self.item_shipplaced)
                            self.ItemStatus.append(self.item_status)
                            self.OrderDate.append(self.order_date)
                            
                            self.TrackingNo.append(self.tracking_no)
                            self.DeliveryPrice.append(self.delivery_price)
                            self.DeliveryDate.append(self.delivery_date)
//                            self.RefNo.append(self.refno)
                            self.PaymentStatus.append(self.payStatus)
                            
                            self.MyBuyingView.reloadData()
                        }
                    }
                }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        MyBuyingView.delegate = self
        MyBuyingView.dataSource = self
        Tabbar.delegate = self
        
        lang = sharedPref.string(forKey: "LANG") ?? "0"
        if(lang == "ms"){
            changeLanguage(str: "ms")
            
        }else{
            changeLanguage(str: "en")
            
        }
        
        
        if(BarHidden == true){
            Tabbar.isHidden = true
            BarHeight.constant = 0
        }else{
            Tabbar.isHidden = false
        }
        
        navigationItem.title = "My Buying"
        
        spinner.show(in: self.view)
        getList()
    }
    
    @objc override func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    func ColorFunc(){
        let color1 = UIColor(hexString: "#FC4A1A").cgColor
        let color2 = UIColor(hexString: "#F7B733").cgColor
        
        let l = CAGradientLayer()
        l.frame = self.view.bounds
        l.colors = [color1, color2]
        l.startPoint = CGPoint(x: 0, y: 0.5)
        l.endPoint = CGPoint(x: 1, y: 0.5)
        l.cornerRadius = 16
        self.view.layer.insertSublayer(l, at: 0)
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
    
    func changeLanguage(str: String){
        Tabbar.items?[0].title = "Home".localized(lang: str)
        Tabbar.items?[1].title = "Notification".localized(lang: str)
        Tabbar.items?[2].title = "Me".localized(lang: str)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return OrderID.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = collectionView.bounds
        let screenWidth = screenSize.width
        
        let cellSquareSize: CGFloat = screenWidth
        
        return CGSize(width: cellSquareSize, height: 254);
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyBuyingCollectionViewCell", for: indexPath) as! MyBuyingCollectionViewCell
        
        if !self.ItemImage[indexPath.row].contains("%20"){
            let NEWIm = self.ItemImage[indexPath.row].addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
            
            cell.ItemImage.setImageWith(URL(string: NEWIm!)!)
        }else{
            cell.ItemImage.setImageWith(URL(string: self.ItemImage[indexPath.row])!)
        }
        
        cell.AdDetail.text! = ad_Detail[indexPath.row]
        
        cell.OrderID.text! = "KM" + OrderID[indexPath.row]
        cell.Price.text! = "MYR" + ItemPrice[indexPath.row]
        cell.Quantity.text! = "x" + ItemQuan[indexPath.row]
        cell.OrderPlaced.text! = "Order Placed on " + ItemOrderPlaced[indexPath.row]
        cell.ShipPlaced.text! = "Shipped out to " + ItemShipPlaced[indexPath.row]
        if(self.PaymentStatus[indexPath.row] == "Unsuccessful"){
            cell.Status.text! = "Unsuccessful"
            cell.Status.textColor = UIColor.red
        }else{
            cell.Status.text! = self.ItemStatus[indexPath.row]
            if(self.ItemStatus[indexPath.row] == "Rejected"){
                cell.Status.textColor = UIColor.red
            }
        }
        cell.ButtonView.layer.cornerRadius = 5
        cell.ButtonReject.layer.cornerRadius = 5
        
        
        cell.delegate = self
        return cell
    }
    
    func getSellerDetails(SellerID: String, OrderID: String){
        let parameters: Parameters=[
            "id": SellerID,
        ]
        Alamofire.request(URL_READ, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        let user = jsonData.value(forKey: "read") as! NSArray
                        let SellerEmail = user.value(forKey: "email") as! [String]
                        
                        self.SellerEmail = SellerEmail[0]
                        
                        self.sendEmail(Email: self.SellerEmail, OrderID: OrderID)
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
                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        let user = jsonData.value(forKey: "read") as! NSArray
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
            "Words": "Order KM" + OrderID + " have been canceld! Please contact respective Buyer for more details."
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
    
    func btnREJECT(cell: MyBuyingCollectionViewCell) {
//        let spinner1 = JGProgressHUD(style: .dark)
        
        guard let indexPath = self.MyBuyingView.indexPath(for: cell) else{
            return
        }
        
        
        
        let Seller_ID = self.seller_id[indexPath.row]
        let Order_ID = self.OrderID[indexPath.row]
        let Remarks = "Cancelled"
        
        
        let parameters: Parameters=[
            "id": Order_ID,
            "remarks": Remarks,
            "status": Remarks
        ]
        Alamofire.request(URL_updateOrder, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        print("SUCCESS")
//                        self.getSellerDetails(SellerID: Seller_ID, OrderID: Order_ID)
                        self.GetPlayerData(CustomerID: Seller_ID, OrderID: Order_ID)
                        self.viewDidLoad()
//                        spinner1.indicatorView = JGProgressHUDSuccessIndicatorView()
//                        spinner1.textLabel.text = "Successfully Cancelled"
//                        spinner1.show(in: self.view)
//                        spinner1.dismiss(afterDelay: 3.0)
                        
                    }
                }
        }
        
    }
    
    func btnVIEW(cell: MyBuyingCollectionViewCell) {
        guard let indexPath = self.MyBuyingView.indexPath(for: cell) else{
            return
        }
        
        let ReviewProduct = self.storyboard!.instantiateViewController(withIdentifier: "ReviewPageViewController") as! ReviewPageViewController
        ReviewProduct.itemID = self.ItemID[indexPath.row]
        ReviewProduct.ORDERID = self.OrderID[indexPath.row]
        ReviewProduct.TRACKINGNO = self.TrackingNo[indexPath.row]
        ReviewProduct.DATEORDER = self.OrderDate[indexPath.row]
        ReviewProduct.DATERECEIVED = self.DeliveryDate[indexPath.row]
        ReviewProduct.ADDETAIL = self.ad_Detail[indexPath.row]
        ReviewProduct.PRICE = self.ItemPrice[indexPath.row]
        ReviewProduct.QUANTITY = self.ItemQuan[indexPath.row]
        ReviewProduct.PHOTO = self.ItemImage[indexPath.row]
        ReviewProduct.SHIPPINGTOTAL = self.DeliveryPrice[indexPath.row]
        ReviewProduct.SHIPPEDTO = self.ItemShipPlaced[indexPath.row]
        ReviewProduct.USERID = userID
        ReviewProduct.SELLER_DIVISION = self.Seller_Division[indexPath.row]
        ReviewProduct.SELLERID = self.seller_id[indexPath.row]
        ReviewProduct.STATUS = self.ItemStatus[indexPath.row]
        ReviewProduct.BarHidden = true
        
        print("PRICE" + self.DeliveryPrice[indexPath.row])
        if let navigator = self.navigationController {
            navigator.pushViewController(ReviewProduct, animated: true)
        }
    }
}
