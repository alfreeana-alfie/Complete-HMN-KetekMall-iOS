//
//  MySellingViewController.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 29/08/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit
import Alamofire

class MySellingViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, MySellingDelegate {
    
    
    
    @IBOutlet var MySellingView: UICollectionView!
    
    let URL_READ = "https://ketekmall.com/ketekmall/read_order_buyer_done_two.php";
    let URL_REJECT = "https://ketekmall.com/ketekmall/edit_order.php";
    
    var item_photo: [String] = []
    var ad_Detail: [String] = []
    var item_price: [String] = []
    var item_quantity: [String] = []
    var item_orderDate: [String] = []
    var item_Shipped: [String] = []
    var item_status: [String] = []
    var item_orderID: [String] = []
    var order_date: [String] = []
    
    var userID: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MySellingView.delegate = self
        MySellingView.dataSource = self
        
        navigationItem.title = "My Selling"
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return item_orderID.count
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
        
        cell.delegate = self
        return cell
    }
    
    func btnREJECT(cell: MySellingCollectionViewCell) {
        guard let indexPath = self.MySellingView.indexPath(for: cell) else{
            return
        }
        
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
                //printing response
                //                print(response)
                
                //getting the json value from the server
                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        print("SUCCESS")
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
        if let navigator = self.navigationController {
            navigator.pushViewController(MySelling, animated: true)
        }
    }
}
