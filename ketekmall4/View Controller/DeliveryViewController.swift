//
//  DeliveryViewController.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 03/09/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit
import Alamofire
import JGProgressHUD

class DeliveryViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, DeliveryDelegate, UICollectionViewDelegateFlowLayout {
    
    private let spinner = JGProgressHUD(style: .dark)
    
    @IBOutlet weak var DeliveryView: UICollectionView!
    @IBOutlet weak var ButtonAdd: UIButton!
    @IBOutlet weak var ButtonAccept: UIButton!
    @IBOutlet weak var ButtonCancel: UIButton!
    
    var userID: String = ""
    var itemID: String = ""
    var Addetail: String = ""
    
    var ID: [String] = []
    var DIVISION: [String] = []
    var PRICE: [String] = []
    var DAYS: [String] = []
    
    let URL_READ_DELIVERY = "https://ketekmall.com/ketekmall/read_delivery_single.php"
    let URL_DELETE_DELIVERY = "https://ketekmall.com/ketekmall/delete_delivery_two.php"
    
    let sharedPref = UserDefaults.standard
    var lang: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lang = sharedPref.string(forKey: "LANG") ?? "0"
        if(lang == "ms"){
            changeLanguage(str: "ms")
            
        }else{
            changeLanguage(str: "en")
            
        }

        DeliveryView.delegate = self
        DeliveryView.dataSource = self
        
        ButtonAdd.layer.cornerRadius = 5
        ButtonAccept.layer.cornerRadius = 5
        ButtonCancel.layer.cornerRadius = 5
        
        spinner.show(in: self.view)
        let parameters: Parameters=[
            "item_id": itemID
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
                        let price = user.value(forKey: "price") as! [String]
                        let days = user.value(forKey: "days") as! [String]
                        
                        self.ID = id
                        self.DIVISION = division
                        self.PRICE = price
                        self.DAYS = days
                        
                        self.DeliveryView.reloadData()
                    }
                }else{
                    self.spinner.indicatorView = JGProgressHUDErrorIndicatorView()
                    self.spinner.textLabel.text = "Failed"
                    self.spinner.show(in: self.view)
                    self.spinner.dismiss(afterDelay: 4.0)
                    print("FAILED")
                }
                
        }
    }
    
    func changeLanguage(str: String){
        ButtonAdd.setTitle("ADD".localized(lang: str), for: .normal)
        ButtonAccept.setTitle("ACCEPT".localized(lang: str), for: .normal)
        ButtonCancel.setTitle("CANCEL".localized(lang: str), for: .normal)
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ID.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let screenSize = collectionView.bounds
            let screenWidth = screenSize.width
    //        let screenHeight = screenSize.height
            let cellSquareSize: CGFloat = screenWidth
            let cellSquareHeight: CGFloat = 114
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DeliveryCollectionViewCell", for: indexPath) as! DeliveryCollectionViewCell
        
        cell.Division.text! = self.DIVISION[indexPath.row]
        cell.Days.text! = self.DAYS[indexPath.row]
        cell.Price.text! = self.PRICE[indexPath.row]
        
        cell.EditButton.layer.cornerRadius = 5
        cell.DeleteButton.layer.cornerRadius = 5
        
        if(lang == "ms"){
            cell.EditButton.setTitle("Edit".localized(lang: "ms"), for: .normal)
            cell.DeleteButton.setTitle("Delete".localized(lang: "ms"), for: .normal)
        }else{
            cell.EditButton.setTitle("Edit".localized(lang: "en"), for: .normal)
            cell.DeleteButton.setTitle("Delete".localized(lang: "en"), for: .normal)
        }
        cell.delegate = self
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
                    self.DeliveryView.deleteItems(at: [indexPath])
                    }else{
                    self.spinner.indicatorView = JGProgressHUDErrorIndicatorView()
                    self.spinner.textLabel.text = "Failed"
                    self.spinner.show(in: self.view)
                    self.spinner.dismiss(afterDelay: 4.0)
                    
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
         _ = navigationController?.popViewController(animated: true)
    }
}
