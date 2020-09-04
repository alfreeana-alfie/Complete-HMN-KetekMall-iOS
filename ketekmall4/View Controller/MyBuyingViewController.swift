//
//  MyBuyingViewController.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 30/08/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit
import Alamofire

class MyBuyingViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, MyBuyingDelegate {
    
    
    
    @IBOutlet weak var MyBuyingView: UICollectionView!
    
    let URL_READ = "https://ketekmall.com/ketekmall/read_order_buyer_done.php";
    let URL_CANCEL = "https://ketekmall.com/ketekmall/edit_order.php";
    let URL_SEND = "https://ketekmall.com/ketekmall/edit_order.php";
    let Main_Photo = "https://ketekmall.com/ketekmall/profile_image/main_photo.png"
    
    var userID: String = ""
    var order_id: String = ""
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
    var Seller_ID: String = ""
    
    var SellerEmail:String = ""
    
    var OrderID: [String] = []
    var ad_Detail: [String] = []
    var ItemImage: [String] = []
    var ItemPrice: [String] = []
    var ItemQuan: [String] = []
    var ItemOrderPlaced: [String] = []
    var ItemShipPlaced: [String] = []
    var ItemStatus: [String] = []
    var OrderDate: [String] = []
    
    var seller_id: [String] = []
    var TrackingNo: [String] = []
    var DeliveryPrice: [String] = []
    var DeliveryDate: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MyBuyingView.delegate = self
        MyBuyingView.dataSource = self
        
        navigationItem.title = "My Buying"
        let parameters: Parameters=[
            "customer_id": userID,
        ]
        
        //Sending http post request
        Alamofire.request(URL_READ, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value as? Dictionary<String,Any>{
                    if let list = result["read"] as? [Dictionary<String,Any>]{
                        for i in list{
                            self.order_id = i["id"] as! String
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
                            
                            self.seller_id.append(self.Seller_ID)
                            self.OrderID.append(self.order_id)
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
                            
                            self.MyBuyingView.reloadData()
                        }
                    }
                    
                }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return OrderID.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyBuyingCollectionViewCell", for: indexPath) as! MyBuyingCollectionViewCell
        
        let NEWIm = self.ItemImage[indexPath.row].addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        
        cell.ItemImage.setImageWith(URL(string: NEWIm!)!)
        
        cell.AdDetail.text! = ad_Detail[indexPath.row]
        
        cell.OrderID.text! = "KM" + OrderID[indexPath.row]
        cell.Price.text! = "MYR" + ItemPrice[indexPath.row]
        cell.Quantity.text! = "x" + ItemQuan[indexPath.row]
        cell.OrderPlaced.text! = "Order Placed on " + ItemOrderPlaced[indexPath.row]
        cell.ShipPlaced.text! = "Shipped out to " + ItemShipPlaced[indexPath.row]
        cell.Status.text! = ItemStatus[indexPath.row]
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
    
    func btnREJECT(cell: MyBuyingCollectionViewCell) {
        guard let indexPath = self.MyBuyingView.indexPath(for: cell) else{
            return
        }
        let Seller_ID = self.seller_id[indexPath.row]
        let Order_ID = self.OrderID[indexPath.row]
        let Order_Date = self.OrderDate[indexPath.row]
        let Remarks = "Cancel"
        
        
        let parameters: Parameters=[
                    "order_date": Order_Date,
                    "remarks": Remarks,
                    "status": Remarks
                ]
                Alamofire.request(URL_CANCEL, method: .post, parameters: parameters).responseJSON
                    {
                        response in
                        if let result = response.result.value{
                            let jsonData = result as! NSDictionary
                            
                            if((jsonData.value(forKey: "success") as! NSString).boolValue){
                                print("SUCCESS")
                                self.getSellerDetails(SellerID: Seller_ID, OrderID: Order_ID)
                            }
                        }
                }
        
    }
    
    func btnVIEW(cell: MyBuyingCollectionViewCell) {
        guard let indexPath = self.MyBuyingView.indexPath(for: cell) else{
            return
        }
        
        let ReviewProduct = self.storyboard!.instantiateViewController(identifier: "ReviewPageViewController") as! ReviewPageViewController
        let ID = self.OrderID[indexPath.row]
        ReviewProduct.itemID = ID
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
        ReviewProduct.SELLERID = self.seller_id[indexPath.row]
        if let navigator = self.navigationController {
            navigator.pushViewController(ReviewProduct, animated: true)
        }
    }
}
