//
//  MySellingViewController.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 29/08/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

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
    
    var userID: String = ""
    var CustEmail: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
//                if let result = response.result.value{
//                    let jsonData = result as! NSDictionary
//
//                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
//                        let user = jsonData.value(forKey: "read") as! NSArray
//                    }
//                }
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
        
        cell.delegate = self
        return cell
    }
    
    func btnREJECT(cell: MySellingCollectionViewCell) {
        guard let indexPath = self.MySellingView.indexPath(for: cell) else{
            return
        }
        
        let CustEmail = self.customer_id[indexPath.row]
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
                        self.getCustomerDetails(CustomerID: CustEmail, OrderID: Order_ID)
                        self.spinner.indicatorView = JGProgressHUDSuccessIndicatorView()
                        self.spinner.textLabel.text = "Successfully Rejected"
                        self.spinner.show(in: self.view)
                        self.spinner.dismiss(afterDelay: 4.0)
                    }
                }
        }
        
    }
    
    func btnVIEW(cell: MySellingCollectionViewCell) {
        guard let indexPath = self.MySellingView.indexPath(for: cell) else{
            return
        }
        
        let MySelling = self.storyboard!.instantiateViewController(identifier: "ViewSellingViewController") as! ViewSellingViewController
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
        MySelling.TRACKINGNO = self.tracking_no[indexPath.row]
        if let navigator = self.navigationController {
            navigator.pushViewController(MySelling, animated: true)
        }
    }
    
    
}
