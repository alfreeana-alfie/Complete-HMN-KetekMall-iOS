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
    
    var OrderID: [String] = []
    var ad_Detail: [String] = []
    var ItemImage: [String] = []
    var ItemPrice: [String] = []
    var ItemQuan: [String] = []
    var ItemOrderPlaced: [String] = []
    var ItemShipPlaced: [String] = []
    var ItemStatus: [String] = []
    var OrderDate: [String] = []
    
    
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
                            
                            self.OrderID.append(self.order_id)
                            self.ad_Detail.append(self.ad_detail)
                            self.ItemImage.append(self.item_img)
                            self.ItemPrice.append(self.item_price)
                            self.ItemQuan.append(self.item_quantity)
                            self.ItemOrderPlaced.append(self.item_orderplaced)
                            self.ItemShipPlaced.append(self.item_shipplaced)
                            self.ItemStatus.append(self.item_status)
                            self.OrderDate.append(self.order_date)
                            
                            
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
        
        cell.AdDetail.text! = ad_Detail[indexPath.row]
        cell.ItemImage.setImageWith(URL(string: Main_Photo)!)
        cell.OrderID.text! = "KM" + OrderID[indexPath.row]
        cell.Price.text! = "MYR" + ItemPrice[indexPath.row]
        cell.Quantity.text! = "x" + ItemQuan[indexPath.row]
        cell.OrderPlaced.text! = "Order Placed on " + ItemOrderPlaced[indexPath.row]
        cell.ShipPlaced.text! = "Shipped out to " + ItemShipPlaced[indexPath.row]
        cell.Status.text! = ItemStatus[indexPath.row]
        
        cell.delegate = self
        return cell
    }
    
    func btnREJECT(cell: MyBuyingCollectionViewCell) {
        guard let indexPath = self.MyBuyingView.indexPath(for: cell) else{
            return
        }
        
        let Order_Date = self.OrderDate[indexPath.row]
        let Remarks = "Cancel"
        
        
        let parameters: Parameters=[
                    "order_date": Order_Date,
                    "remarks": Remarks,
                    "status": Remarks
                ]
                
                //Sending http post request
                Alamofire.request(URL_CANCEL, method: .post, parameters: parameters).responseJSON
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
    
    func btnVIEW(cell: MyBuyingCollectionViewCell) {
        guard let indexPath = self.MyBuyingView.indexPath(for: cell) else{
            return
        }
        
        let ReviewProduct = self.storyboard!.instantiateViewController(identifier: "ReviewPageViewController") as! ReviewPageViewController
        let ID = self.OrderID[indexPath.row]
        ReviewProduct.itemID = ID
        if let navigator = self.navigationController {
            navigator.pushViewController(ReviewProduct, animated: true)
        }
    }
}
