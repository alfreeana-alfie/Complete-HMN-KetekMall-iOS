//
//  CategoryViewController.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 31/08/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit
import Alamofire

class CategoryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, CategoryDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ITEMID.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
        
        cell.ItemName.text! = self.ADDETAIL[indexPath.row]
        cell.Price.text! = self.PRICE[indexPath.row]
        cell.District.text! = self.DISTRICT[indexPath.row]
        
        return cell
    }
    
    func onViewClick(cell: CategoryCollectionViewCell) {
        print("success")
    }
    
    @IBOutlet weak var CategoryView: UICollectionView!
    
    var UserID: String = ""
    var URL_READ: String = ""
    var URL_SEARCH: String = ""
    var URL_FILTER_DISTRICT: String = ""
    var URL_FILTER_DIVISION: String = ""
    var URL_FILTER_SEARCH_DIVISION: String = ""
    
    var ITEMID: [String] = []
    var ADDETAIL: [String] = []
    var PRICE: [String] = []
    var PHOTO: [String] = []
    var DISTRICT: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        CategoryView.delegate = self
        CategoryView.dataSource = self
        
        ViewList()
    }
    
    func ViewList(){
        Alamofire.request(URL_READ, method: .post).responseJSON
            {
                response in
                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        let user = jsonData.value(forKey: "read") as! NSArray
                        
                        let ItemID = user.value(forKey: "id") as! [String]
                        let Ad_Detail = user.value(forKey: "ad_detail") as! [String]
                        let Price = user.value(forKey: "price") as! [String]
                        let Photo = user.value(forKey: "photo") as! [String]
                        let District = user.value(forKey: "district") as! [String]
                        
                        self.ITEMID = ItemID
                        self.ADDETAIL = Ad_Detail
                        self.PRICE = Price
                        self.PHOTO = Photo
                        self.DISTRICT = District
                        
                        self.CategoryView.reloadData()
                        
                    }
                }
        }
    }

}
