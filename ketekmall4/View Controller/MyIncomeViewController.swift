
import UIKit
import Alamofire
import JGProgressHUD

class MyIncomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let URL_READ = "https://ketekmall.com/ketekmall/read_order_buyer_done_profile.php";
    let URL_READ_TWO = "https://ketekmall.com/ketekmall/read_order_two.php";
    
    private let spinner = JGProgressHUD(style: .dark)
    
    var userID: String = ""
    var ad_Detail: [String] = []
    var item_photo: [String] = []
    var item_price: [String] = []
    var item_quantity: [String] = []
    var delivery_address: [String] = []
    var delivery_time: [String] = []
    var delivery_price: [String] = []
    var grand_total: [String] = []
    var item_status: [String] = []
    
    var item_price_income: String = ""
    var item_quantity_income: String = ""
    var delivery_price_income: String = ""
    
    var STRad_Detail: String = ""
    var STRitem_photo: String = ""
    var STRitem_price: String = ""
    var STRitem_quantity: String = ""
    var STRdelivery_addr: String = ""
    var STRdelivery_time: String = ""
    var STRdelivery_price: String = ""
    var STRGrandTotal: String = ""
    var STRitem_status: String = ""
    
    let sharedPref = UserDefaults.standard
    var lang: String = ""
    
    var newSold: Double = 0.00
    var newSold2: Double = 0.00
    
    @IBOutlet weak var MyIncomeLabel: UILabel!
    @IBOutlet weak var IncomeTotal: UILabel!
    @IBOutlet weak var MyIncomeView: UICollectionView!
    
//    override func viewDidAppear(_ animated: Bool) {
//        ColorFunc()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lang = sharedPref.string(forKey: "LANG") ?? "0"
        if(lang == "ms"){
            changeLanguage(str: "ms")
            
        }else{
            changeLanguage(str: "en")
            
        }
        
        MyIncomeView.delegate = self
        MyIncomeView.dataSource = self
        
        navigationItem.title = "My Income"
        
        spinner.show(in: self.view)
        let parameters: Parameters=[
            "seller_id": userID,
        ]
        
        //Sending http post request
        Alamofire.request(URL_READ_TWO, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value as? Dictionary<String,Any>{
                    if let list = result["read"] as? [Dictionary<String,Any>]{
                        
                        for i in list{
                            
                            self.item_price_income = i["price"] as! String
                            self.item_quantity_income = i["quantity"] as! String
                            self.delivery_price_income = i["delivery_price"] as! String
                            
                            self.newSold += Double(self.item_price_income)! * Double(self.item_quantity_income)!
                            self.newSold2 += self.newSold + Double(self.delivery_price_income)!
                            
                            
                        }
                       self.IncomeTotal.text! = "RM"+String(format: "%.2f", self.newSold2)
                        
                    }
                    
                }
        }
        
        Alamofire.request(URL_READ, method: .post, parameters: parameters).responseJSON
            {
                response in
                
                if let result = response.result.value as? Dictionary<String,Any>{
                    if let list = result["read"] as? [Dictionary<String,Any>]{
                        self.spinner.dismiss(afterDelay: 3.0)
                        for i in list{
                            var STRGrand_Total1: Double = 0.00
                            var STRGrand_Total2: Double = 0.00
                            
                            self.STRad_Detail = i["ad_detail"] as! String
                            self.STRitem_photo = i["photo"] as! String
                            self.STRitem_price = i["price"] as! String
                            self.STRitem_quantity = i["quantity"] as! String
                            self.STRdelivery_addr = i["delivery_addr"] as? String ?? "null"
                            self.STRdelivery_time = i["delivery_date"] as! String
                            self.STRdelivery_price = i["delivery_price"] as! String
                            self.STRitem_status = i["status"] as! String
                            
                            STRGrand_Total1 = Double(self.STRitem_price)! * Double(self.STRitem_quantity)!
                            STRGrand_Total2 += STRGrand_Total1 + Double(self.STRdelivery_price)!
                            
                            self.STRGrandTotal = String(format: "%.2f", STRGrand_Total2)
                            
                            self.ad_Detail.append(self.STRad_Detail)
                            self.item_photo.append(self.STRitem_photo)
                            self.item_price.append(self.STRitem_price)
                            self.item_quantity.append(self.STRitem_quantity)
                            self.delivery_address.append(self.STRdelivery_addr)
                            self.delivery_time.append(self.STRdelivery_time)
                            self.delivery_price.append(self.STRdelivery_price)
                            self.item_status.append(self.STRitem_status)
                            self.grand_total.append(self.STRGrandTotal)
//                            print(self.grand_total)
                        }
                        self.MyIncomeView.reloadData()
                    }
                    
                }
        }
        
        
    }
    @objc override func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    func ColorFunc(){
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
    
    func changeLanguage(str: String){
        MyIncomeLabel.text = "My Income".localized(lang: str)
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ad_Detail.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let screenSize = collectionView.bounds
            let screenWidth = screenSize.width
    //        let screenHeight = screenSize.height
            let cellSquareSize: CGFloat = screenWidth
            let cellSquareHeight: CGFloat = 259
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyIncomeCollectionViewCell", for: indexPath) as! MyIncomeCollectionViewCell
        
        if !self.item_photo[indexPath.row].contains("%20"){
            print("contain whitespace \(self.item_photo[indexPath.row].trimmingCharacters(in: .whitespaces))")
            let NEWIm = self.item_photo[indexPath.row].addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
            
            cell.ItemImage.setImageWith(URL(string: NEWIm!)!)
        }else{
            print("contain whitespace")
            
            cell.ItemImage.setImageWith(URL(string: self.item_photo[indexPath.row])!)
        }
        
        cell.ItemName.text! = self.ad_Detail[indexPath.row]
//        cell.UserName.text! = self.customer_name[indexPath.row]
        cell.Price.text! = "RM"+self.item_price[indexPath.row]
        cell.Quantity.text! = self.item_quantity[indexPath.row]
        cell.DeliveryAddress.text! = self.delivery_address[indexPath.row]
        cell.DeliveryTime.text! = self.delivery_time[indexPath.row]
        cell.DeliveryPrice.text! = "RM"+self.delivery_price[indexPath.row]
        print(self.grand_total[indexPath.row])
        cell.GrandTotal.text! = "RM"+self.grand_total[indexPath.row]
        cell.Status.text! = self.item_status[indexPath.row]
        if(lang == "ms"){
            cell.DeliveryAddresslabel.text = "Delivery Address".localized(lang: "ms")
            cell.DeliveryTimeLabel.text = "Delivery Time".localized(lang: "ms")
            cell.ShippingTotalLabel.text = "Shipping Total".localized(lang: "ms")
            cell.GrandTotalLabel.text = "Grand Total".localized(lang: "ms")
        }else{
            cell.DeliveryAddresslabel.text = "Delivery Address".localized(lang: "en")
            cell.DeliveryTimeLabel.text = "Delivery Time".localized(lang: "en")
            cell.ShippingTotalLabel.text = "Shipping Total".localized(lang: "en")
            cell.GrandTotalLabel.text = "Grand Total".localized(lang: "en")
        }
        return cell
    }
}
