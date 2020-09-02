//
//  DeliveryViewController.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 03/09/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit
import Alamofire

class DeliveryViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, DeliveryDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ID.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DeliveryCollectionViewCell", for: indexPath) as! DeliveryCollectionViewCell
        
        cell.Division.text! = self.DIVISION[indexPath.row]
        cell.Days.text! = self.DAYS[indexPath.row]
        cell.Price.text! = self.PRICE[indexPath.row]
        
        return cell
    }
    
    func onEditClick(cell: DeliveryCollectionViewCell) {
        guard let indexPath = self.DeliveryView.indexPath(for: cell) else{
            return
        }
        
        let myBuying = self.storyboard!.instantiateViewController(identifier: "DeliveryAddViewController") as! DeliveryAddViewController
        myBuying.USERID = userID
        myBuying.ITEMID = itemID
        myBuying.ADDETAIL = Addetail
        myBuying.DIVISION = self.DIVISION[indexPath.row]
        myBuying.DAYS = self.DAYS[indexPath.row]
        myBuying.PRICE = self.PRICE[indexPath.row]
        if let navigator = self.navigationController {
            navigator.pushViewController(myBuying, animated: true)
        }
    }
    
    func onDeleteClick(cell: DeliveryCollectionViewCell) {
        guard let indexPath = self.DeliveryView.indexPath(for: cell) else{
            return
        }
        
        let parameters: Parameters=[
            "id": self.ID[indexPath.row]
        ]
        
        Alamofire.request(URL_DELETE_DELIVERY, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    print("SUCCESS")
                    }else{
                    print("FAILED")
                }
            }
                
        }
    
    
    @IBAction func Add(_ sender: Any) {
        let myBuying = self.storyboard!.instantiateViewController(identifier: "DeliveryAddViewController") as! DeliveryAddViewController
        myBuying.USERID = userID
        myBuying.ITEMID = itemID
        myBuying.ADDETAIL = Addetail
        if let navigator = self.navigationController {
            navigator.pushViewController(myBuying, animated: true)
        }
    }
    
    @IBAction func Accept(_ sender: Any) {
        let myBuying = self.storyboard!.instantiateViewController(identifier: "MySellingViewController") as! MySellingViewController
        myBuying.userID = userID
        if let navigator = self.navigationController {
            navigator.pushViewController(myBuying, animated: true)
        }
    }
    
    @IBAction func Cancel(_ sender: Any) {
    }
    
    
    
    @IBOutlet weak var DeliveryView: UICollectionView!
    
    var userID: String = ""
    var itemID: String = ""
    var Addetail: String = ""
    
    var ID: [String] = []
    var DIVISION: [String] = []
    var PRICE: [String] = []
    var DAYS: [String] = []
    
    let URL_READ_DELIVERY = "https://ketekmall.com/ketekmall/read_delivery_single.php"
    let URL_DELETE_DELIVERY = "https://ketekmall.com/ketekmall/delete_delivery_two.php"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DeliveryView.delegate = self
        DeliveryView.dataSource = self
        
        let parameters: Parameters=[
            "item_id": itemID
        ]
        
        Alamofire.request(URL_READ_DELIVERY, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        let user = jsonData.value(forKey: "read") as! NSArray
                        
                        let id = user.value(forKey: "id") as! [String]
                        let division = user.value(forKey: "division") as! [String]
                        let price = user.value(forKey: "price") as! [String]
                        let days = user.value(forKey: "days") as! [String]
                        
                        self.ID = id
                        self.DIVISION = division
                        self.PRICE = price
                        self.DAYS = days
                        
                        self.DeliveryView.reloadData()
                    }
                }else{
                    print("FAILED")
                }
                
        }
    }
}
