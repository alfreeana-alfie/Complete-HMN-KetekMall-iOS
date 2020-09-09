//
//  MyIncomeViewController.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 29/08/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit
import Alamofire
import JGProgressHUD

class MyIncomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
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
    
    var newSold: Double = 0.00
    var newSold2: Double = 0.00
    
    
    
    @IBOutlet weak var IncomeTotal: UILabel!
    @IBOutlet weak var MyIncomeView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
                       self.IncomeTotal.text! = String(format: "%.2f", self.newSold2)
                        
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
                            var STRGrand_Total: Double = 0.00
                            var STRGrand_Total2: Double = 0.00
                            
                            self.STRad_Detail = i["ad_detail"] as! String
                            self.STRitem_photo = i["photo"] as! String
                            self.STRitem_price = i["price"] as! String
                            self.STRitem_quantity = i["quantity"] as! String
                            self.STRdelivery_addr = i["delivery_addr"] as? String ?? "null"
                            self.STRdelivery_time = i["delivery_date"] as! String
                            self.STRdelivery_price = i["delivery_price"] as! String
                            self.STRitem_status = i["status"] as! String
                            
                            STRGrand_Total = Double(self.STRitem_price)! * Double(self.STRitem_quantity)!
                            STRGrand_Total2 += STRGrand_Total + Double(self.STRdelivery_price)!
                            
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
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ad_Detail.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyIncomeCollectionViewCell", for: indexPath) as! MyIncomeCollectionViewCell
        
        let NEWIm = self.item_photo[indexPath.row].addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        
        cell.ItemImage.setImageWith(URL(string: NEWIm!)!)
        
        cell.ItemName.text! = self.ad_Detail[indexPath.row]
//        cell.UserName.text! = self.customer_name[indexPath.row]
        cell.Price.text! = self.item_price[indexPath.row]
        cell.Quantity.text! = self.item_quantity[indexPath.row]
        cell.DeliveryAddress.text! = self.delivery_address[indexPath.row]
        cell.DeliveryTime.text! = self.delivery_time[indexPath.row]
        cell.DeliveryPrice.text! = self.delivery_price[indexPath.row]
        print(self.grand_total[indexPath.row])
        cell.GrandTotal.text! = self.grand_total[indexPath.row]
        cell.Status.text! = self.item_status[indexPath.row]
        
        return cell
    }
}
