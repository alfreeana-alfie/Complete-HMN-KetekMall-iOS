//
//  CategoryViewController.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 31/08/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit
import Alamofire
import AARatingBar

class CategoryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, CategoryDelegate, UISearchBarDelegate {
    func onAddToFav(cell: CategoryCollectionViewCell) {
        guard let indexPath = self.CategoryView.indexPath(for: cell) else{
            return
        }
        
        let parameters: Parameters=[
            "seller_id": self.SELLERID[indexPath.row],
            "item_id": self.ITEMID[indexPath.row],
            "customer_id": UserID,
            "main_category": self.MAINCATE[indexPath.row],
            "sub_category": self.SUBCATE[indexPath.row],
            "ad_detail": self.ADDETAIL[indexPath.row],
            "brand_material":self.BRAND[indexPath.row],
            "inner_material": self.INNER[indexPath.row],
            "stock": self.STOCK[indexPath.row],
            "description": self.DESC[indexPath.row],
            "price": self.PRICE[indexPath.row],
            "rating": self.RATING[indexPath.row],
            "division": self.DIVISION[indexPath.row],
            "district": self.DISTRICT[indexPath.row],
            "photo": self.PHOTO[indexPath.row]
        ]
        
        Alamofire.request(URL_ADD_FAV, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value {
                    let jsonData = result as! NSDictionary
                    print(jsonData.value(forKey: "message")!)
                    
                }
        }
    }
    
    func onAddToCart(cell: CategoryCollectionViewCell) {
        guard let indexPath = self.CategoryView.indexPath(for: cell) else{
            return
        }
        
        let parameters: Parameters=[
            "seller_id": self.SELLERID[indexPath.row],
            "item_id": self.ITEMID[indexPath.row],
            "customer_id": UserID,
            "main_category": self.MAINCATE[indexPath.row],
            "sub_category": self.SUBCATE[indexPath.row],
            "ad_detail": self.ADDETAIL[indexPath.row],
            "price": self.PRICE[indexPath.row],
            "quantity": "1",
            "division": self.DIVISION[indexPath.row],
            "district": self.DISTRICT[indexPath.row],
            "photo": self.PHOTO[indexPath.row]
        ]
        
        Alamofire.request(URL_ADD_CART, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value {
                    let jsonData = result as! NSDictionary
                    print(jsonData.value(forKey: "message")!)
                    
                }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ITEMID.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
        
        let NEWIm = self.PHOTO[indexPath.row].addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)

        cell.ItemImage.setImageWith(URL(string: NEWIm!)!)
        if let n = NumberFormatter().number(from: self.RATING[indexPath.row]) {
            let f = CGFloat(truncating: n)
            cell.Rating.value = f
        }
        cell.ItemName.text! = self.ADDETAIL[indexPath.row]
        cell.Price.text! = "MYR" + self.PRICE[indexPath.row]
        cell.District.text! = self.DISTRICT[indexPath.row]
        cell.ButtonView.layer.cornerRadius = 5
        
        cell.delegate = self
        return cell
    }
    
    func onViewClick(cell: CategoryCollectionViewCell) {
        guard let indexPath = self.CategoryView.indexPath(for: cell) else{
            return
        }
        
        let viewProduct = self.storyboard!.instantiateViewController(identifier: "ViewProductViewController") as! ViewProductViewController
        viewProduct.USERID = UserID
        viewProduct.ItemID = self.ITEMID[indexPath.row]
        viewProduct.SELLERID = self.SELLERID[indexPath.row]
        viewProduct.MAINCATE = self.MAINCATE[indexPath.row]
        viewProduct.SUBCATE = self.SUBCATE[indexPath.row]
        viewProduct.ADDETAIL = self.ADDETAIL[indexPath.row]
        viewProduct.BRAND = self.BRAND[indexPath.row]
        viewProduct.INNER = self.INNER[indexPath.row]
        viewProduct.STOCK = self.STOCK[indexPath.row]
        viewProduct.DESC = self.DESC[indexPath.row]
        viewProduct.PRICE = self.PRICE[indexPath.row]
        viewProduct.PHOTO = self.PHOTO[indexPath.row]
        viewProduct.DIVISION = self.DIVISION[indexPath.row]
        viewProduct.DISTRICT = self.DISTRICT[indexPath.row]
        if let navigator = self.navigationController {
            navigator.pushViewController(viewProduct, animated: true)
        }
    }
    
    @IBAction func PriceUp(_ sender: Any) {
        ButtonPriceDown.isHidden = false
        ButtonPriceUp.isHidden = true
        ITEMID.sort()
        PRICE.sort()
        
    }
    
    @IBAction func PriceDown(_ sender: Any) {
        ButtonPriceDown.isHidden = true
        ButtonPriceUp.isHidden = false
    }
    
    
    @IBOutlet weak var ButtonPriceUp: UIButton!
    @IBOutlet weak var ButtonPriceDown: UIButton!
    @IBOutlet weak var CategoryView: UICollectionView!
    
    @IBAction func Filter(_ sender: Any) {
        let filter = self.storyboard!.instantiateViewController(identifier: "FilterViewController") as! FilterViewController
        filter.DivisionFilter = DivisionFilter
        filter.DistricFilter = DistricFilter
        filter.URL_READ = URL_READ
        filter.URL_FILTER_DIVISION = URL_FILTER_DIVISION
        filter.URL_FILTER_DISTRICT = URL_FILTER_DISTRICT
        filter.URL_SEARCH = URL_SEARCH
        filter.URL_FILTER_SEARCH_DIVISION = URL_FILTER_SEARCH_DIVISION
        if let navigator = self.navigationController {
            navigator.pushViewController(filter, animated: true)
        }
    }
    
    var UserID: String = ""
    var URL_READ: String = ""
    var URL_SEARCH: String = ""
    var URL_FILTER_DISTRICT: String = ""
    var URL_FILTER_DIVISION: String = ""
    var URL_FILTER_SEARCH_DIVISION: String = ""
    
    var DivisionFilter: String = ""
    var DistricFilter: String = ""
    
    let URL_ADD_FAV = "https://ketekmall.com/ketekmall/add_to_fav.php"
    let URL_ADD_CART = "https://ketekmall.com/ketekmall/add_to_cart.php"
    
    var SELLERID: [String] = []
    var MAINCATE: [String] = []
    var SUBCATE: [String] = []
    var BRAND: [String] = []
    var INNER: [String] = []
    var STOCK: [String] = []
    var DESC: [String] = []
    var MAXORDER: [String] = []
    var DIVISION: [String] = []
    var RATING: [String] = []
    var ITEMID: [String] = []
    var ADDETAIL: [String] = []
    var PRICE: [String] = []
    var PHOTO: [String] = []
    var DISTRICT: [String] = []
    
    @IBOutlet weak var SearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SearchBar.delegate = self
        
        CategoryView.delegate = self
        CategoryView.dataSource = self
        
        if(DivisionFilter.isEmpty && DistricFilter.isEmpty){
            ViewList()
        }else if(!DivisionFilter.isEmpty && DistricFilter.isEmpty){
            Filter_Division()
        }else if(!DivisionFilter.isEmpty && !DistricFilter.isEmpty){
            Filter_District()
        }
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(DivisionFilter.isEmpty){
            Search(SearchValue: searchText)
            
        }else{
            Search(SearchValue: searchText, Division: DivisionFilter)
        }
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text! = ""
    }
    
    func Search(SearchValue: String, Division: String){
        let parameters: Parameters=[
            "ad_detail": SearchValue,
            "division": Division
        ]
        
        Alamofire.request(URL_FILTER_SEARCH_DIVISION, method: .post, parameters: parameters).responseJSON
                   {
                       response in
                       if let result = response.result.value{
                           let jsonData = result as! NSDictionary
                           
                           if((jsonData.value(forKey: "success") as! NSString).boolValue){
                               let user = jsonData.value(forKey: "read") as! NSArray
                               
                               let ItemID = user.value(forKey: "id") as! [String]
                               let Seller_ID = user.value(forKey: "user_id") as! [String]
                               let Main_Cate = user.value(forKey: "main_category") as! [String]
                               let Sub_Cate = user.value(forKey: "sub_category") as! [String]
                               let Ad_Detail = user.value(forKey: "ad_detail") as! [String]
                               let brand_mat = user.value(forKey: "brand_material") as! [String]
                               let inner_mat = user.value(forKey: "inner_material") as! [String]
                               let stock = user.value(forKey: "stock") as! [String]
                               let description = user.value(forKey: "description") as! [String]
                               let rating = user.value(forKey: "rating") as! [String]
                               let Price = user.value(forKey: "price") as! [String]
                               let Photo = user.value(forKey: "photo") as! [String]
                               let Division = user.value(forKey: "division") as! [String]
                               let District = user.value(forKey: "district") as! [String]
                               
                               self.ITEMID = ItemID
                               self.SELLERID = Seller_ID
                               self.MAINCATE = Main_Cate
                               self.SUBCATE = Sub_Cate
                               self.ADDETAIL = Ad_Detail
                               self.BRAND = brand_mat
                               self.INNER = inner_mat
                               self.STOCK = stock
                               self.DESC = description
                               self.PRICE = Price
                               self.PHOTO = Photo
                               self.RATING = rating
                               self.DIVISION = Division
                               self.DISTRICT = District
                               
                               self.CategoryView.reloadData()
                           }
                       }
               }
    }
    
    func Search(SearchValue: String){
        let parameters: Parameters=[
            "ad_detail": SearchValue
        ]
        
        Alamofire.request(URL_SEARCH, method: .post, parameters: parameters).responseJSON
                   {
                       response in
                       if let result = response.result.value{
                           let jsonData = result as! NSDictionary
                           
                           if((jsonData.value(forKey: "success") as! NSString).boolValue){
                               let user = jsonData.value(forKey: "read") as! NSArray
                               
                               let ItemID = user.value(forKey: "id") as! [String]
                               let Seller_ID = user.value(forKey: "user_id") as! [String]
                               let Main_Cate = user.value(forKey: "main_category") as! [String]
                               let Sub_Cate = user.value(forKey: "sub_category") as! [String]
                               let Ad_Detail = user.value(forKey: "ad_detail") as! [String]
                               let brand_mat = user.value(forKey: "brand_material") as! [String]
                               let inner_mat = user.value(forKey: "inner_material") as! [String]
                               let stock = user.value(forKey: "stock") as! [String]
                               let description = user.value(forKey: "description") as! [String]
                               let rating = user.value(forKey: "rating") as! [String]
                               let Price = user.value(forKey: "price") as! [String]
                               let Photo = user.value(forKey: "photo") as! [String]
                               let Division = user.value(forKey: "division") as! [String]
                               let District = user.value(forKey: "district") as! [String]
                               
                               self.ITEMID = ItemID
                               self.SELLERID = Seller_ID
                               self.MAINCATE = Main_Cate
                               self.SUBCATE = Sub_Cate
                               self.ADDETAIL = Ad_Detail
                               self.BRAND = brand_mat
                               self.INNER = inner_mat
                               self.STOCK = stock
                               self.DESC = description
                               self.PRICE = Price
                               self.PHOTO = Photo
                               self.RATING = rating
                               self.DIVISION = Division
                               self.DISTRICT = District
                               
                               self.CategoryView.reloadData()
                            
                           }
                       }
               }
    }
    
    func Filter_Division(){
        let parameters: Parameters=[
            "division": DivisionFilter
        ]
        
        Alamofire.request(URL_FILTER_DIVISION, method: .post, parameters: parameters).responseJSON
                   {
                       response in
                       if let result = response.result.value{
                           let jsonData = result as! NSDictionary
                           
                           if((jsonData.value(forKey: "success") as! NSString).boolValue){
                               let user = jsonData.value(forKey: "read") as! NSArray
                               
                               let ItemID = user.value(forKey: "id") as! [String]
                               let Seller_ID = user.value(forKey: "user_id") as! [String]
                               let Main_Cate = user.value(forKey: "main_category") as! [String]
                               let Sub_Cate = user.value(forKey: "sub_category") as! [String]
                               let Ad_Detail = user.value(forKey: "ad_detail") as! [String]
                               let brand_mat = user.value(forKey: "brand_material") as! [String]
                               let inner_mat = user.value(forKey: "inner_material") as! [String]
                               let stock = user.value(forKey: "stock") as! [String]
                               let description = user.value(forKey: "description") as! [String]
                               let rating = user.value(forKey: "rating") as! [String]
                               let Price = user.value(forKey: "price") as! [String]
                               let Photo = user.value(forKey: "photo") as! [String]
                               let Division = user.value(forKey: "division") as! [String]
                               let District = user.value(forKey: "district") as! [String]
                               
                               self.ITEMID = ItemID
                               self.SELLERID = Seller_ID
                               self.MAINCATE = Main_Cate
                               self.SUBCATE = Sub_Cate
                               self.ADDETAIL = Ad_Detail
                               self.BRAND = brand_mat
                               self.INNER = inner_mat
                               self.STOCK = stock
                               self.DESC = description
                               self.PRICE = Price
                               self.PHOTO = Photo
                               self.RATING = rating
                               self.DIVISION = Division
                               self.DISTRICT = District
                               
                               self.CategoryView.reloadData()
                           }
                       }
               }
    }
    
    func Filter_District(){
        let parameters: Parameters=[
            "division": DivisionFilter,
            "district": DistricFilter
        ]
        
        Alamofire.request(URL_FILTER_DISTRICT, method: .post, parameters: parameters).responseJSON
                   {
                       response in
                       if let result = response.result.value{
                           let jsonData = result as! NSDictionary
                           
                           if((jsonData.value(forKey: "success") as! NSString).boolValue){
                               let user = jsonData.value(forKey: "read") as! NSArray
                               
                               let ItemID = user.value(forKey: "id") as! [String]
                               let Seller_ID = user.value(forKey: "user_id") as! [String]
                               let Main_Cate = user.value(forKey: "main_category") as! [String]
                               let Sub_Cate = user.value(forKey: "sub_category") as! [String]
                               let Ad_Detail = user.value(forKey: "ad_detail") as! [String]
                               let brand_mat = user.value(forKey: "brand_material") as! [String]
                               let inner_mat = user.value(forKey: "inner_material") as! [String]
                               let stock = user.value(forKey: "stock") as! [String]
                               let description = user.value(forKey: "description") as! [String]
                               let rating = user.value(forKey: "rating") as! [String]
                               let Price = user.value(forKey: "price") as! [String]
                               let Photo = user.value(forKey: "photo") as! [String]
                               let Division = user.value(forKey: "division") as! [String]
                               let District = user.value(forKey: "district") as! [String]
                               
                               self.ITEMID = ItemID
                               self.SELLERID = Seller_ID
                               self.MAINCATE = Main_Cate
                               self.SUBCATE = Sub_Cate
                               self.ADDETAIL = Ad_Detail
                               self.BRAND = brand_mat
                               self.INNER = inner_mat
                               self.STOCK = stock
                               self.DESC = description
                               self.PRICE = Price
                               self.PHOTO = Photo
                               self.RATING = rating
                               self.DIVISION = Division
                               self.DISTRICT = District
                               
                               self.CategoryView.reloadData()
                           }
                       }
               }
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
                        let Seller_ID = user.value(forKey: "user_id") as! [String]
                        let Main_Cate = user.value(forKey: "main_category") as! [String]
                        let Sub_Cate = user.value(forKey: "sub_category") as! [String]
                        let Ad_Detail = user.value(forKey: "ad_detail") as! [String]
                        let brand_mat = user.value(forKey: "brand_material") as! [String]
                        let inner_mat = user.value(forKey: "inner_material") as! [String]
                        let stock = user.value(forKey: "stock") as! [String]
                        let description = user.value(forKey: "description") as! [String]
                        let rating = user.value(forKey: "rating") as! [String]
                        let Price = user.value(forKey: "price") as! [String]
                        let Photo = user.value(forKey: "photo") as! [String]
                        let Division = user.value(forKey: "division") as! [String]
                        let District = user.value(forKey: "district") as! [String]
                        
                        self.ITEMID = ItemID
                        self.SELLERID = Seller_ID
                        self.MAINCATE = Main_Cate
                        self.SUBCATE = Sub_Cate
                        self.ADDETAIL = Ad_Detail
                        self.BRAND = brand_mat
                        self.INNER = inner_mat
                        self.STOCK = stock
                        self.DESC = description
                        self.PRICE = Price
                        self.PHOTO = Photo
                        self.RATING = rating
                        self.DIVISION = Division
                        self.DISTRICT = District
                        
                        self.CategoryView.reloadData()
                    }
                }
        }
    }
    
}
