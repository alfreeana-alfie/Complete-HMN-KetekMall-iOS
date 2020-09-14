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
class ShippingInfoViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITabBarDelegate, UICollectionViewDelegateFlowLayout {

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
            presentMethod(storyBoardName: "Main", storyBoardID: "HomeViewController")
            break
            
        case 2:
            presentMethod(storyBoardName: "Main", storyBoardID: "NotificationViewController")
            break
            
        case 3:
            presentMethod(storyBoardName: "Main", storyBoardID: "ViewController")
            break
            
        default:
            break
        }
    }
    
    func presentMethod(storyBoardName: String, storyBoardID: String) {
        let storyBoard: UIStoryboard = UIStoryboard(name: storyBoardName, bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: storyBoardID)
        self.definesPresentationContext = true
        self.present(newViewController, animated: true, completion: nil)
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = collectionView.bounds
        let screenWidth = screenSize.width
        let cellSquareSize: CGFloat = screenWidth
        return CGSize(width: cellSquareSize, height: 94);
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShippingInfoCollectionViewCell", for: indexPath) as! ShippingInfoCollectionViewCell
        cell.layer.cornerRadius = 5
        cell.Division.text! = self.DIVISION[indexPath.row]
        cell.Days.text! = "Delivered in " + self.DAYS[indexPath.row] + " Days"
        cell.Price.text! = "MYR" + self.PRICE[indexPath.row]
        
        return cell
    }
    
    
}
