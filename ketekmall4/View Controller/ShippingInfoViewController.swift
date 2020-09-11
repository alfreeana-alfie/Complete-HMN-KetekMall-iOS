//
//  ShippingInfoViewController.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 01/09/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit
import Alamofire
import JGProgressHUD
class ShippingInfoViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITabBarDelegate {

    let URL_READ_DELIVERY = "https://ketekmall.com/ketekmall/read_delivery_single.php"
    
    private let spinner = JGProgressHUD(style: .dark)
    
    var ITEMID: String = ""
    var DEL_ID: [String] = []
    var DIVISION: [String] = []
    var DAYS: [String] = []
    var PRICE: [String] = []
    
    @IBOutlet weak var DeliveryView: UICollectionView!
    @IBOutlet weak var Tabbar: UITabBar!
    var viewController1: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DeliveryView.delegate = self
        DeliveryView.dataSource = self
        
        Tabbar.delegate = self
        
        DeliveryList()
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem){
        switch item.tag {
        case 1:
            navigationController?.setNavigationBarHidden(true, animated: false)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            viewController1 = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            navigationController?.pushViewController(viewController1!, animated: true)
            break
            
        case 2:
            navigationController?.setNavigationBarHidden(true, animated: false)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            viewController1 = storyboard.instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
            navigationController?.pushViewController(viewController1!, animated: true)
            break
            
        case 3:
            navigationController?.setNavigationBarHidden(true, animated: false)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            viewController1 = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            navigationController?.pushViewController(viewController1!, animated: true)
            break
            
        default:
            break
        }
    }

    
    func DeliveryList(){
        spinner.show(in: self.view)
        let parameters: Parameters=[
            "item_id": ITEMID
        ]
        
        Alamofire.request(URL_READ_DELIVERY, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        self.spinner.dismiss(afterDelay: 3.0)
                        let user = jsonData.value(forKey: "read") as! NSArray
                        
                        let id = user.value(forKey: "id") as! [String]
                        let division = user.value(forKey: "division") as! [String]
                        let days = user.value(forKey: "days") as! [String]
                        let price = user.value(forKey: "price") as! [String]
                        
                        self.DEL_ID = id
                        self.DIVISION = division
                        self.DAYS = days
                        self.PRICE = price
                        
                        self.DeliveryView.reloadData()
                    }
                }else{
                    print("FAILED")
                }
                
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DEL_ID.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShippingInfoCollectionViewCell", for: indexPath) as! ShippingInfoCollectionViewCell
        cell.layer.cornerRadius = 5
        cell.Division.text! = self.DIVISION[indexPath.row]
        cell.Days.text! = "Delivered in " + self.DAYS[indexPath.row] + " Days"
        cell.Price.text! = "MYR" + self.PRICE[indexPath.row]
        
        return cell
    }
}
